import 'package:mulearn_app/features/profile/domain/entities/user_achievement.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'achievements_controller.g.dart';

@riverpod
Future<List<UserAchievement>> userAchievements(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getUserAchievements(muid);

/// DIDs already connected/verified via QSeverse for [muid] — used to decide
/// whether the VC-issuance flow can proceed without an extra connect step.
@riverpod
Future<List<String>> connectedDids(Ref ref, String muid) =>
    ref.watch(profileRepositoryProvider).getConnectedDids(muid);
