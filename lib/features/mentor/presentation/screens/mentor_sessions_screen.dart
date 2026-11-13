import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/session_filter.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
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
                            child: Text(formatDay(g.day).toUpperCase(), style: MuType.eyebrow),
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

/// Statuses an edit is allowed on (`MentorSessionUpdateAPI`).
const _editable = {SessionStatus.scheduled, SessionStatus.pendingApproval, SessionStatus.requested};

String statusLabel(SessionStatus s) => switch (s) {
      SessionStatus.requested => 'Requested',
      SessionStatus.scheduled => 'Scheduled',
      SessionStatus.pendingApproval => 'Awaiting approval',
      SessionStatus.completed => 'Completed',
      SessionStatus.cancelled => 'Cancelled',
      SessionStatus.rejected => 'Rejected',
      SessionStatus.unknown => 'Unknown',
    };

class _SessionTile extends ConsumerWidget {
  const _SessionTile({required this.session, required this.showStatus});

  final MentorSession session;
  final bool showStatus;

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete this session?'),
        content: Text(session.title),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(dialogContext, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      final message = await ref.read(sessionActionsProvider.notifier).delete(session.id);
      if (context.mounted) {
        MuToast.show(context, message: message.isEmpty ? 'Session deleted' : message, type: MuToastType.success);
      }
    } on Object catch (e) {
      if (context.mounted) MuToast.show(context, message: ApiException.messageFor(e), type: MuToastType.error);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final starts = session.startsAt.toLocal();
    final ends = session.endsAt.toLocal();
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.s),
      child: MuCard(
        padding: const EdgeInsets.fromLTRB(MuSpace.l, MuSpace.m, MuSpace.xs, MuSpace.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${formatTime(starts)} – ${formatTime(ends)}', style: MuType.caption),
                  const SizedBox(height: 2),
                  Text(session.title, style: MuType.bodyMed, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Text(
                    [sessionModeLabel(session.mode), if (session.entityName.isNotEmpty) session.entityName].join(' · '),
                    style: MuType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (showStatus) ...[
                    const SizedBox(height: MuSpace.xs),
                    MuTagChip(label: statusLabel(session.status)),
                  ],
                ],
              ),
            ),
            PopupMenuButton<String>(
              tooltip: 'Session actions',
              icon: const Icon(LucideIcons.moreVertical, size: 20, color: MuColors.inkSecondary),
              onSelected: (value) {
                if (value == 'edit') {
                  context.push(RoutePaths.mentorSessionEditPath(session.id));
                } else {
                  unawaited(_delete(context, ref));
                }
              },
              itemBuilder: (_) => [
                if (_editable.contains(session.status)) const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
