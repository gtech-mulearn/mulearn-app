import 'package:mulearn_app/features/profile/domain/entities/user_preferences.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_preferences_controller.g.dart';

@riverpod
class UserPreferencesController extends _$UserPreferencesController {
  @override
  Future<UserPreferences> build() =>
      ref.watch(profileRepositoryProvider).getUserPreferences();

  Future<void> save({
    List<String>? domains,
    List<String>? endgoals,
    bool? interestedInWork,
    bool? interestedInGigWork,
  }) async {
    await ref.read(profileRepositoryProvider).updateUserPreferences(
          domains: domains,
          endgoals: endgoals,
          interestedInWork: interestedInWork,
          interestedInGigWork: interestedInGigWork,
        );
    ref.invalidateSelf();
  }
}
