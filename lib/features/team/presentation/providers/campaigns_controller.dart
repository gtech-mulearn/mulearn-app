import 'dart:async';

import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/team/domain/entities/campaign_draft.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campaigns_controller.g.dart';

/// Push campaigns, newest first. Loads on open and on pull-to-refresh. While
/// any campaign is `sending` it refreshes every 5 s, because the backend
/// sends in the background; it stops as soon as none is sending, and when
/// the last screen closes.
@Riverpod(retry: noRetry)
class CampaignsController extends _$CampaignsController {
  static const _pollEvery = Duration(seconds: 5);

  Timer? _timer;

  @override
  Future<List<PushCampaign>> build() async {
    _timer = null;
    ref.onDispose(() => _timer?.cancel());
    final list = await ref.watch(teamRepositoryProvider).campaigns();
    _watchSending(list);
    return list;
  }

  /// Refetches. On failure the loaded list stays and the error is rethrown
  /// (pull-to-refresh shows it as a toast).
  Future<void> refresh() async {
    final list = await ref.read(teamRepositoryProvider).campaigns();
    if (!ref.mounted) return;
    state = AsyncData(list);
    _watchSending(list);
  }

  void _watchSending(List<PushCampaign> list) {
    _timer?.cancel();
    _timer = null;
    if (list.every((c) => c.status != CampaignStatus.sending)) return;
    _timer = Timer(_pollEvery, () => unawaited(_poll()));
  }

  Future<void> _poll() async {
    try {
      await refresh();
    } on Object catch (e, st) {
      appLogger.w('Polling campaigns failed', error: e, stackTrace: st);
      // Keep watching while the last good list still has a send going.
      final last = state.value;
      if (ref.mounted && last != null) _watchSending(last);
    }
  }

  /// Saves a campaign and returns it. Rethrows the backend's error.
  Future<PushCampaign> create(CampaignDraft draft) async {
    final link = ref.keepAlive();
    try {
      final created = await ref
          .read(teamRepositoryProvider)
          .createCampaign(draft);
      await _refreshAfterWrite();
      return created;
    } finally {
      link.close();
    }
  }

  /// Sends or cancels one campaign, then refreshes. Rethrows the backend's
  /// error.
  Future<void> act(String id, CampaignAction action) async {
    final link = ref.keepAlive();
    try {
      await ref.read(teamRepositoryProvider).campaignAction(id, action);
      await _refreshAfterWrite();
    } finally {
      link.close();
    }
  }

  /// A failed refresh after a write that went through is logged, not
  /// reported as a failed write.
  Future<void> _refreshAfterWrite() async {
    try {
      await refresh();
    } on Object catch (e, st) {
      appLogger.w(
        'Refreshing campaigns after a change failed',
        error: e,
        stackTrace: st,
      );
    }
  }
}
