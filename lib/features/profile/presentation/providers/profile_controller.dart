import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mulearn_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
ProfileRemoteDataSource profileRemoteDataSource(Ref ref) =>
    ProfileRemoteDataSource(ref.watch(dioProvider));

@riverpod
ProfileRepository profileRepository(Ref ref) => ProfileRepositoryImpl(
      remote: ref.watch(profileRemoteDataSourceProvider),
      locationRemote: ref.watch(locationRemoteDataSourceProvider),
    );

/// Loads the current user's profile once on screen load and caches it for the
/// session (Riverpod's built-in caching — build prompt §5). Call [refresh] to
/// refetch, e.g. from the error-state retry button.
@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<UserProfile> build() =>
      ref.watch(profileRepositoryProvider).getCurrentUserProfile();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(profileRepositoryProvider).getCurrentUserProfile(),
    );
  }

  /// Toggles profile visibility, then reflects the change immediately
  /// without a full refetch.
  Future<void> togglePublic({required bool isPublic}) async {
    final current = state.value;
    await ref
        .read(profileRepositoryProvider)
        .togglePublicProfile(isPublic: isPublic);
    if (current != null) {
      state = AsyncData(current.copyWith(isPublic: isPublic));
    }
  }
}
