import 'package:mulearn_app/features/profile/domain/entities/editable_profile.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'editable_profile_controller.g.dart';

/// Pre-fill data + save action for the edit-profile form. Loaded fresh each
/// time the modal opens (`keepAlive: false`, the default) since it's a
/// one-shot form, not a cached read.
@riverpod
class EditableProfileController extends _$EditableProfileController {
  @override
  Future<EditableProfile> build() =>
      ref.watch(profileRepositoryProvider).getEditableProfile();

  /// Saves the form, then refreshes the main profile so the header/sidebar
  /// reflect the change.
  Future<void> save({
    String? fullName,
    String? email,
    String? mobile,
    String? gender,
    String? dob,
    String? districtId,
    List<String>? communities,
  }) async {
    await ref.read(profileRepositoryProvider).updateProfile(
          fullName: fullName,
          email: email,
          mobile: mobile,
          gender: gender,
          dob: dob,
          districtId: districtId,
          communities: communities,
        );
    ref
      ..invalidateSelf()
      ..invalidate(profileControllerProvider);
  }
}
