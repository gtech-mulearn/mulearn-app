import 'package:mulearn_app/core/events/profile_event_bus.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_image_controller.g.dart';

@riverpod
class ProfileImageController extends _$ProfileImageController {
  @override
  Future<void> build() async {}

  Future<void> upload(List<int> bytes, String filename) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final profile = await ref.read(profileControllerProvider.future);
      await ref.read(profileRepositoryProvider).updateProfileImage(
            bytes: bytes,
            filename: filename,
            userId: profile.id,
          );
      ref.invalidate(profileControllerProvider);
      // features/dashboard caches its own read-model of the same endpoint
      // (rules.md §2: no direct cross-feature import) — signal it via the
      // shared bus so Home's avatar doesn't keep showing the stale photo.
      ref.read(profileEventBusProvider).emit(ProfileEvent.updated);
    });
  }
}
