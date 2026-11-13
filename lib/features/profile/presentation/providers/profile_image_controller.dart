import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_image_controller.g.dart';

@riverpod
class ProfileImageController extends _$ProfileImageController {
  @override
  Future<void> build() async {}

  Future<void> upload(List<int> bytes, String filename) async {
    final link = ref.keepAlive(); // finish the follow-up refresh even if the screen closes
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      final profile = await ref.read(profileControllerProvider.future);
      await ref.read(profileRepositoryProvider).updateProfileImage(
            bytes: bytes,
            filename: filename,
            userId: profile.id,
          );
      ref.invalidate(myProfilePayloadProvider);
      // features/dashboard caches its own read-model of the same endpoint
      // (rules.md §2: no direct cross-feature import) — signal it via the
      // shared bus so Home's avatar doesn't keep showing the stale photo.
    });
    if (ref.mounted) state = result;
    link.close();
  }
}
