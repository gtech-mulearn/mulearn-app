import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/session_filter.dart';
import 'package:mulearn_app/features/mentor/domain/session_rules.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/meeting_actions.dart';
import 'package:mulearn_app/features/mentor/presentation/widgets/session_labels.dart';

/// The mentor's sessions (M2): Upcoming / Awaiting approval / Completed /
/// All, grouped by local day, with New session and per-session Edit/Delete.
class MentorSessionsScreen extends ConsumerStatefulWidget {
  const MentorSessionsScreen({super.key});

  @override
  ConsumerState<MentorSessionsScreen> createState() => _MentorSessionsScreenState();
}

class _MentorSessionsScreenState extends ConsumerState<MentorSessionsScreen> {
  SessionFilter _filter = SessionFilter.upcoming;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mentorSessionsControllerProvider(_filter));
    final canCreate = ref.watch(sessionTargetsProvider).value?.isNotEmpty ?? false;
    return Scaffold(
      backgroundColor: MuColors.canvas,
      appBar: AppBar(backgroundColor: MuColors.canvas, elevation: 0, title: const Text('Sessions')),
      floatingActionButton: canCreate
          ? FloatingActionButton.extended(
              onPressed: () => context.push(RoutePaths.mentorSessionNew),
              icon: const Icon(LucideIcons.plus),
              label: const Text('New session'),
            )
          : null,
      body: Column(
        children: [
          SizedBox(
            height: 44,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
              children: [
                for (final f in SessionFilter.values) ...[
                  MuFilterChip(label: f.label, selected: f == _filter, onTap: () => setState(() => _filter = f)),
                  const SizedBox(width: MuSpace.s),
                ],
              ],
            ),
          ),
          Expanded(
            child: state.when(
              skipError: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorRetryView(
                error: e,
                onRetry: () => ref.invalidate(mentorSessionsControllerProvider(_filter)),
              ),
              data: (paged) {
                Future<void> refresh() => ref.refresh(mentorSessionsControllerProvider(_filter).future);
                if (paged.items.isEmpty) {
                  // The dashboard's sessions page: StateDisplay "no-results", small.
                  return MuRefresh(
                    onRefresh: refresh,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [MuStateDisplay(variant: MuStateVariant.noResults, size: MuStateSize.sm)],
                    ),
                  );
                }
                final groups = groupByLocalDay(paged.items);
                return MuRefresh(
                  onRefresh: refresh,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (n) {
                      if (n.metrics.extentAfter < 400 && paged.hasMore && paged.loadMoreError == null) {
                        unawaited(ref.read(mentorSessionsControllerProvider(_filter).notifier).loadMore());
                      }
                      return false;
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(MuSpace.screenH, MuSpace.m, MuSpace.screenH, 96),
                      children: [
                        for (final g in groups) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: MuSpace.m, bottom: MuSpace.s),
                            child: Text(
                              formatDayHeading(g.day, ref.watch(clockProvider)().toLocal()).toUpperCase(),
                              style: MuType.eyebrow,
                            ),
                          ),
                          for (final s in g.sessions) _SessionTile(session: s, showStatus: _filter == SessionFilter.all),
                        ],
                        if (paged.hasMore || paged.loadMoreError != null)
                          MuLoadMoreFooter(
                            isLoading: paged.isLoadingMore,
                            error: paged.loadMoreError,
                            onRetry: () => ref.read(mentorSessionsControllerProvider(_filter).notifier).loadMore(),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

String statusLabel(SessionStatus s) => switch (s) {
      SessionStatus.requested => 'Requested',
      SessionStatus.scheduled => 'Scheduled',
      SessionStatus.pendingApproval => 'Awaiting approval',
      SessionStatus.completed => 'Completed',
      SessionStatus.cancelled => 'Cancelled',
      SessionStatus.rejected => 'Rejected',
      SessionStatus.unknown => 'Unknown',
    };

/// One session: time on the left (like a calendar), title and where in the
/// middle, Join or a chevron on the right. The whole row opens the session.
class _SessionTile extends ConsumerWidget {
  const _SessionTile({required this.session, required this.showStatus});

  final MentorSession session;
  final bool showStatus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(clockProvider)();
    final starts = session.startsAt.toLocal();
    final ends = session.endsAt.toLocal();
    final live = hasStarted(session, now) && now.isBefore(session.endsAt) && session.status == SessionStatus.scheduled;
    final joinable = canJoinSession(session, now);
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        onTap: () => context.push(RoutePaths.mentorSessionDetailPath(session.id)),
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.s, MuSpace.m),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(formatTime(starts), style: MuType.bodyMed),
                  Text(formatTime(ends), style: MuType.caption),
                ],
              ),
            ),
            const SizedBox(width: MuSpace.s),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(session.title, style: MuType.bodyMed, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(
                    [sessionModeLabel(session.mode), if (session.entityName.isNotEmpty) session.entityName].join(' · '),
                    style: MuType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (live || showStatus) ...[
                    const SizedBox(height: MuSpace.xs),
                    MuTagChip(
                      label: live ? 'Live now' : statusLabel(session.status),
                      style: live ? MuTagStyle.success : MuTagStyle.neutral,
                    ),
                  ],
                ],
              ),
            ),
            if (joinable)
              FilledButton(
                onPressed: () => openLink(ref, session.meetingLink!),
                style: FilledButton.styleFrom(backgroundColor: MuColors.primary, visualDensity: VisualDensity.compact),
                child: const Text('Join'),
              )
            else
              const Icon(LucideIcons.chevronRight, size: 18, color: MuColors.inkSecondary),
          ],
        ),
      ),
    );
  }
}
