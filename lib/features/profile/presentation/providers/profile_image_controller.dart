import 'package:cached_network_image/cached_network_image.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_image_controller.g.dart';

/// The most a profile photo may weigh: the dashboard's limit (5 MB), the
/// same as the cover's.
const profilePicMaxBytes = 5 * 1024 * 1024;

/// Uploads the member's profile photo. Errors (too large, rejected by the
/// server) land in [state] for the screen to show.
@riverpod
class ProfileImageController extends _$ProfileImageController {
  @override
  Future<void> build() async {}

  Future<void> upload(List<int> bytes, String filename) async {
    if (bytes.length > profilePicMaxBytes) {
      state = AsyncError(
        const ApiException(message: 'Profile photo must be under 5 MB.'),
        StackTrace.current,
      );
      return;
    }
    // The backend saves every photo at the same URL
    // (`user/profile/<id>.png`), so the cached image keeps showing the old
    // one unless it's evicted.
    final previousUrl = ref
        .read(profileControllerProvider)
        .value
        ?.profilePicUrl;
    final link = ref
        .keepAlive(); // finish the follow-up refresh even if the screen closes
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final profile = await ref.read(profileControllerProvider.future);
      await ref
          .read(profileRepositoryProvider)
          .updateProfileImage(
            bytes: bytes,
            filename: filename,
            userId: profile.id,
          );
      if (previousUrl != null && previousUrl.isNotEmpty) {
        await CachedNetworkImage.evictFromCache(previousUrl);
      }
      ref.invalidate(myProfilePayloadProvider);
    });
    if (ref.mounted) state = result;
    link.close();
  }
}
