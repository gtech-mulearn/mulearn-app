import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/team/domain/entities/campaign_draft.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campaigns_controller.g.dart';

/// Push campaigns, newest first. Loads on open and on pull-to-refresh, and
/// after the user's own create, send or cancel. Nothing polls.
@Riverpod(retry: noRetry)
class CampaignsController extends _$CampaignsController {
  @override
  Future<List<PushCampaign>> build() =>
      ref.watch(teamRepositoryProvider).campaigns();

  /// Refetches. On failure the loaded list stays and the error is rethrown
  /// (pull-to-refresh shows it as a toast).
  Future<void> refresh() async {
    final list = await ref.read(teamRepositoryProvider).campaigns();
    if (!ref.mounted) return;
    state = AsyncData(list);
  }

  /// Saves a campaign and returns it. Rethrows the backend's error.
  Future<PushCampaign> create(CampaignDraft draft) async {
    final link = ref.keepAlive();
    try {
      final created = await ref
          .read(teamRepositoryProvider)
          .createCampaign(draft);
      if (ref.mounted) {
        // Show it at once, so its detail opens even if the refresh fails.
        final current = state.value ?? const <PushCampaign>[];
        state = AsyncData([
          created,
          for (final c in current)
            if (c.id != created.id) c,
        ]);
      }
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
