// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(profileRemoteDataSource)
const profileRemoteDataSourceProvider = ProfileRemoteDataSourceProvider._();

final class ProfileRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ProfileRemoteDataSource,
          ProfileRemoteDataSource,
          ProfileRemoteDataSource
        >
    with $Provider<ProfileRemoteDataSource> {
  const ProfileRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ProfileRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRemoteDataSource create(Ref ref) {
    return profileRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRemoteDataSource>(value),
    );
  }
}

String _$profileRemoteDataSourceHash() =>
    r'0fed139b97bbdfbf0f8cbf17910ee5c531213d52';

@ProviderFor(profileRepository)
const profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  const ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'babcceef764de52b2a40ee0a629c88f5298829a1';

/// The current user's profile, mapped from the shared `user-profile` payload
/// (one request for every reader). Call [refresh] to refetch, e.g. from the
/// error-state retry button.

@ProviderFor(ProfileController)
const profileControllerProvider = ProfileControllerProvider._();

/// The current user's profile, mapped from the shared `user-profile` payload
/// (one request for every reader). Call [refresh] to refetch, e.g. from the
/// error-state retry button.
final class ProfileControllerProvider
    extends $AsyncNotifierProvider<ProfileController, UserProfile> {
  /// The current user's profile, mapped from the shared `user-profile` payload
  /// (one request for every reader). Call [refresh] to refetch, e.g. from the
  /// error-state retry button.
  const ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();
}

String _$profileControllerHash() => r'a97fd75d9d987e5508e077df409df7118d3aa6e6';

/// The current user's profile, mapped from the shared `user-profile` payload
/// (one request for every reader). Call [refresh] to refetch, e.g. from the
/// error-state retry button.

abstract class _$ProfileController extends $AsyncNotifier<UserProfile> {
  FutureOr<UserProfile> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<UserProfile>, UserProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile>, UserProfile>,
              AsyncValue<UserProfile>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
