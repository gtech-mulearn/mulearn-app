import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cover_photo_controller.g.dart';

/// Max cover image size in bytes — must match the backend
/// (`UserProfileCoverView.MAX_COVER_SIZE_BYTES`).
const coverPicMaxBytes = 5 * 1024 * 1024;

@riverpod
class CoverPhotoController extends _$CoverPhotoController {
  @override
  Future<void> build() async {}

  Future<void> upload(List<int> bytes, String filename) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(profileRepositoryProvider)
          .uploadCoverPic(bytes, filename);
      ref.invalidate(profileControllerProvider);
    });
  }

  Future<void> delete() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(profileRepositoryProvider).deleteCoverPic();
      ref.invalidate(profileControllerProvider);
    });
  }
}
