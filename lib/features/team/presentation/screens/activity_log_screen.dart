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
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/presentation/activity_labels.dart';
import 'package:mulearn_app/features/team/presentation/providers/activity_log_controller.dart';
import 'package:mulearn_app/features/team/presentation/widgets/activity_detail_sheet.dart';

/// The filter chips: backend action code and its label, in the backend's
/// order (the labels equal `ACTION_LABELS`).
const _actions = <(String, String)>[
  ('NOTIF_BROADCAST_CREATE', 'Created announcement'),
  ('NOTIF_BROADCAST_SEND', 'Sent announcement to everyone'),
  ('NOTIF_BROADCAST_UPDATE', 'Edited announcement'),
  ('NOTIF_BROADCAST_DELETE', 'Deleted announcement'),
  ('NOTIF_BROADCAST_DEL_ALL', 'Deleted all announcements'),
  ('PUSH_CAMPAIGN_CREATE', 'Created push campaign'),
  ('PUSH_CAMPAIGN_SEND', 'Sent push campaign'),
  ('PUSH_CAMPAIGN_CANCEL', 'Cancelled push campaign'),
  ('PUSH_TEST_SEND', 'Sent test push'),
  ('PUSH_CONFIG_UPDATE', 'Changed push settings'),
];

/// Who sent, edited or deleted what in the team workspace, newest first.
/// A row opens what it was and what changed; counts update on pull-to-refresh.
class ActivityLogScreen extends ConsumerStatefulWidget {
  const ActivityLogScreen({super.key});

  @override
  ConsumerState<ActivityLogScreen> createState() => _ActivityLogScreenState();
}

class _ActivityLogScreenState extends ConsumerState<ActivityLogScreen> {
  String? _action;

  @override
  Widget build(BuildContext context) {
    final provider = activityLogControllerProvider(_action);
    final async = ref.watch(provider);
    final controller = ref.read(provider.notifier);
    final now = ref.watch(clockProvider)().toLocal();
    return MuWorkspacePage(
      title: 'Activity log',
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: MuSpacing.space5,
              vertical: MuSpacing.space3,
            ),
            child: Row(
              children: [
                MuFilterChip(
                  label: 'All',
                  selected: _action == null,
                  onTap: () => setState(() => _action = null),
                ),
                for (final (code, label) in _actions) ...[
                  const SizedBox(width: MuSpacing.space2),
                  MuFilterChip(
                    label: label,
                    selected: _action == code,
                    onTap: () => setState(() => _action = code),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: async.when(
              skipError: true,
              skipLoadingOnReload: true,
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ErrorRetryView(
                error: error,
                onRetry: () => ref.invalidate(provider),
              ),
              data: (page) => MuPagedListView<ActivityEntry>(
                state: page,
                grouped: true,
                onLoadMore: controller.loadMore,
                onRefresh: controller.refresh,
                empty: const MuStateDisplay(
                  variant: MuStateVariant.noResults,
                  title: 'Nothing logged yet',
                ),
                itemBuilder: (context, e, i) => MuFeedRow(
                  leading: const MuFeedIcon(
                    LucideIcons.history,
                    tone: MuFeedTone.event,
                  ),
                  subject: e.label,
                  body: activityRowBody(e),
                  time: formatAgo(e.createdAt.toLocal(), now),
                  divider: i < page.items.length - 1,
                  onTap: () => unawaited(_open(context, e, now)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _open(
    BuildContext context,
    ActivityEntry e,
    DateTime now,
  ) {
    final router = GoRouter.of(context);
    return showMuSheet<void>(
      context,
      builder: (sheet) => ActivityDetailSheet(
        entry: e,
        now: now,
        onOpenCampaign: (id) {
          Navigator.of(sheet).pop();
          unawaited(router.push(RoutePaths.teamCampaignPath(id)));
        },
      ),
    );
  }
}
