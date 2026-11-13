import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'change_password_controller.g.dart';

/// Submits a password change; the screen reads the state for its spinner
/// and errors.
@riverpod
class ChangePasswordController extends _$ChangePasswordController {
  @override
  Future<void> build() async {}

  /// True when the password was changed.
  Future<bool> submit({required String current, required String next}) async {
    final repository = ref.read(profileRepositoryProvider);
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() => repository.changePassword(current: current, next: next));
    if (ref.mounted) state = result;
    return !result.hasError;
  }
}
