import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/profile/domain/entities/achievement_progress.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'achievements_controller.g.dart';

@Riverpod(retry: noRetry)
Future<List<UserAchievement>> userAchievements(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getUserAchievements(muid);

/// What the signed-in user can claim now.
@Riverpod(retry: noRetry)
Future<List<AchievementProgress>> eligibleAchievements(Ref ref) =>
    ref.watch(profileRepositoryProvider).getEligibleAchievements();

/// Progress towards every achievement (filtered into "In Progress").
@Riverpod(retry: noRetry)
Future<List<AchievementProgress>> achievementProgress(Ref ref) =>
    ref.watch(profileRepositoryProvider).getAchievementProgress();

/// Catalog descriptions by id, to describe eligible and in-progress items.
@Riverpod(retry: noRetry)
Future<Map<String, String>> achievementDescriptions(Ref ref) =>
    ref.watch(profileRepositoryProvider).getAchievementDescriptions();

/// DIDs already connected/verified via QSeverse for [muid] — used to decide
/// whether the VC-issuance flow can proceed without an extra connect step.
@riverpod
Future<List<String>> connectedDids(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getConnectedDids(muid);

/// Claims an achievement, then refreshes the earned, eligible and progress
/// lists. Throws the backend's reason when refused.
@riverpod
class AchievementClaimController extends _$AchievementClaimController {
  @override
  Future<void> build() async {}

  Future<ClaimResult> claim(String achievementId, {required String muid}) async {
    final repository = ref.read(profileRepositoryProvider);
    final link = ref.keepAlive(); // finish the refresh even if the tab closes
    try {
      final result = await repository.claimAchievement(achievementId);
      ref
        ..invalidate(userAchievementsProvider(muid))
        ..invalidate(eligibleAchievementsProvider)
        ..invalidate(achievementProgressProvider);
      return result;
    } finally {
      link.close();
    }
  }
}
