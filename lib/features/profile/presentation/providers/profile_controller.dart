import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
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

/// The current user's profile, mapped from the shared `user-profile` payload
/// (one request for every reader). Call [refresh] to refetch, e.g. from the
/// error-state retry button.
@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<UserProfile> build() async {
    final repository = ref.watch(profileRepositoryProvider);
    return repository.profileFromPayload(await ref.watch(myProfilePayloadProvider.future));
  }

  /// Refetches the shared profile; every reader of it refreshes.
  Future<void> refresh() async => ref.invalidate(myProfilePayloadProvider);

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
