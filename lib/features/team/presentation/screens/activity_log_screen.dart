import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_paged_list.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/presentation/providers/activity_log_controller.dart';

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
/// A row opens what changed.
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
                  body: _body(e),
                  time: formatAgo(e.createdAt.toLocal(), now),
                  divider: i < page.items.length - 1,
                  onTap: () => unawaited(_open(context, e)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _body(ActivityEntry e) {
    final audience = e.audienceSize != null
        ? '${e.audienceSize} people'
        : e.audienceLabel ?? '';
    return '${e.actorName} (${e.roles.join(' + ')}) · ${e.title ?? ''} · '
        '$audience';
  }

  static Future<void> _open(BuildContext context, ActivityEntry e) =>
      showMuSheet<void>(
        context,
        builder: (_) => SingleChildScrollView(
          child: MuSheetBody(title: e.label, body: _changes(e)),
        ),
      );

  /// One "key: before → after" line per changed key.
  static String _changes(ActivityEntry e) {
    final before = e.oldData ?? const <String, Object?>{};
    final after = e.newData ?? const <String, Object?>{};
    final keys = {...before.keys, ...after.keys};
    if (keys.isEmpty) return 'No details were recorded.';
    return [
      for (final k in keys) '$k: ${_value(before, k)} → ${_value(after, k)}',
    ].join('\n');
  }

  /// A value on one line: scalars as text, maps and lists as JSON, cut at
  /// 160 characters so a delete-all list cannot flood the sheet.
  static String _value(Map<String, Object?> data, String key) {
    if (!data.containsKey(key)) return '—';
    final v = data[key];
    final text = switch (v) {
      null => '—',
      final String s => s,
      final num n => '$n',
      final bool b => '$b',
      _ => jsonEncode(v),
    };
    return text.length > 160 ? '${text.substring(0, 160)}…' : text;
  }
}
