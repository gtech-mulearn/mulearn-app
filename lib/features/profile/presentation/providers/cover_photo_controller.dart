import 'package:cached_network_image/cached_network_image.dart';
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
    // The cover-photo-not-updating bug report pointed here: if the backend
    // overwrites the cover photo at the same storage URL on every upload
    // rather than versioning the filename, `cached_network_image`'s
    // disk/memory cache (keyed by URL) keeps serving the old bytes even
    // after `profileControllerProvider` correctly refetches — the UI would
    // look "stuck" despite the upload having succeeded. Evicting the
    // previous URL from cache forces a real re-fetch regardless.
    final previousUrl = ref.read(profileControllerProvider).value?.coverPicUrl;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref
          .read(profileRepositoryProvider)
          .uploadCoverPic(bytes, filename);
      if (previousUrl != null && previousUrl.isNotEmpty) {
        await CachedNetworkImage.evictFromCache(previousUrl);
      }
      ref.invalidate(profileControllerProvider);
    });
  }

  Future<void> delete() async {
    final previousUrl = ref.read(profileControllerProvider).value?.coverPicUrl;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(profileRepositoryProvider).deleteCoverPic();
      if (previousUrl != null && previousUrl.isNotEmpty) {
        await CachedNetworkImage.evictFromCache(previousUrl);
      }
      ref.invalidate(profileControllerProvider);
    });
  }
}
