import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
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
/// All as chips, grouped by local day, each a row with its times on the
/// left and Join when it's time. New session is pinned at the bottom.
class MentorSessionsScreen extends ConsumerStatefulWidget {
  const MentorSessionsScreen({super.key});

  @override
  ConsumerState<MentorSessionsScreen> createState() => _MentorSessionsScreenState();
}

class _MentorSessionsScreenState extends ConsumerState<MentorSessionsScreen> {
  SessionFilter _filter = SessionFilter.upcoming;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final state = ref.watch(mentorSessionsControllerProvider(_filter));
    final canCreate = ref.watch(sessionTargetsProvider).value?.isNotEmpty ?? false;
    return MuWorkspacePage(
      bottom: canCreate
          ? MuButton(
              label: 'New session',
              icon: LucideIcons.plus,
              block: true,
              onPressed: () => context.push(RoutePaths.mentorSessionNew),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, 0),
            child: Semantics(header: true, child: Text('Sessions', style: mu.text.display.copyWith(fontSize: 32))),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space5, vertical: MuSpacing.space3),
            child: Row(
              children: [
                for (final f in SessionFilter.values) ...[
                  MuFilterChip(label: f.label, selected: f == _filter, onTap: () => setState(() => _filter = f)),
                  const SizedBox(width: MuSpacing.space2),
                ],
              ],
            ),
          ),
          Expanded(
            child: state.when(
              skipError: true,
              loading: () => const Center(child: MuDotsLoader(label: 'Loading sessions…')),
              error: (e, _) =>
                  ErrorRetryView(error: e, onRetry: () => ref.invalidate(mentorSessionsControllerProvider(_filter))),
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
                final today = ref.watch(clockProvider)().toLocal();
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
                      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space8),
                      children: [
                        for (final g in groups) ...[
                          MuSectionEyebrow(formatDayHeading(g.day, today), top: MuSpacing.space4),
                          MuFeedGroup(
                            children: [
                              for (var i = 0; i < g.sessions.length; i++)
                                _SessionRow(
                                  session: g.sessions[i],
                                  showStatus: _filter == SessionFilter.all,
                                  last: i == g.sessions.length - 1,
                                ),
                            ],
                          ),
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

/// One session: start and end on the left (like a calendar), title and
/// where, a Live now or status pill, Join or a chevron on the right. The
/// row opens the session.
class _SessionRow extends ConsumerWidget {
  const _SessionRow({required this.session, required this.showStatus, required this.last});

  final MentorSession session;
  final bool showStatus;
  final bool last;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final now = ref.watch(clockProvider)();
    final starts = session.startsAt.toLocal();
    final ends = session.endsAt.toLocal();
    final live = hasStarted(session, now) && now.isBefore(session.endsAt) && session.status == SessionStatus.scheduled;
    final joinable = canJoinSession(session, now);
    return MuFeedRow(
      leading: SizedBox(
        width: 64,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(formatTime(starts), style: mu.text.bodyStrong.copyWith(fontSize: 14, color: live ? c.success : c.ink)),
            Text(formatTime(ends), style: mu.text.caption),
          ],
        ),
      ),
      subject: session.title,
      time: [sessionModeLabel(session.mode), if (session.entityName.isNotEmpty) session.entityName].join(' · '),
      trailing: joinable
          ? MuButton(
              label: 'Join',
              size: MuButtonSize.small,
              onPressed: () => openLink(context, ref, session.meetingLink!),
            )
          : Icon(LucideIcons.chevronRight, size: MuSizes.iconSm + 2, color: c.ink3),
      actions: [
        if (live)
          const MuPill('Live now', tone: MuPillTone.volt, icon: LucideIcons.radio)
        else if (showStatus)
          MuPill(statusLabel(session.status)),
      ],
      divider: !last,
      onTap: () => context.push(RoutePaths.mentorSessionDetailPath(session.id)),
    );
  }
}
