// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sessionRemoteDataSource)
const sessionRemoteDataSourceProvider = SessionRemoteDataSourceProvider._();

final class SessionRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SessionRemoteDataSource,
          SessionRemoteDataSource,
          SessionRemoteDataSource
        >
    with $Provider<SessionRemoteDataSource> {
  const SessionRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<SessionRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SessionRemoteDataSource create(Ref ref) {
    return sessionRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionRemoteDataSource>(value),
    );
  }
}

String _$sessionRemoteDataSourceHash() =>
    r'e5cdf69b352e6e02ee5d6853234357f9bc73b06b';

/// The signed-in user (`/dashboard/user/info/`); `null` when signed out.

@ProviderFor(currentUser)
const currentUserProvider = CurrentUserProvider._();

/// The signed-in user (`/dashboard/user/info/`); `null` when signed out.

final class CurrentUserProvider
    extends
        $FunctionalProvider<
          AsyncValue<CurrentUser?>,
          CurrentUser?,
          FutureOr<CurrentUser?>
        >
    with $FutureModifier<CurrentUser?>, $FutureProvider<CurrentUser?> {
  /// The signed-in user (`/dashboard/user/info/`); `null` when signed out.
  const CurrentUserProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserHash();

  @$internal
  @override
  $FutureProviderElement<CurrentUser?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CurrentUser?> create(Ref ref) {
    return currentUser(ref);
  }
}

String _$currentUserHash() => r'cd8efa7744c41b09ba8d73ec95f4d21457c65d30';

/// The user's mentor applications — fetched only for users with the Mentor
/// role (others get `[]` without a request).

@ProviderFor(mentorApplications)
const mentorApplicationsProvider = MentorApplicationsProvider._();

/// The user's mentor applications — fetched only for users with the Mentor
/// role (others get `[]` without a request).

final class MentorApplicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorApplication>>,
          List<MentorApplication>,
          FutureOr<List<MentorApplication>>
        >
    with
        $FutureModifier<List<MentorApplication>>,
        $FutureProvider<List<MentorApplication>> {
  /// The user's mentor applications — fetched only for users with the Mentor
  /// role (others get `[]` without a request).
  const MentorApplicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorApplicationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorApplicationsHash();

  @$internal
  @override
  $FutureProviderElement<List<MentorApplication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorApplication>> create(Ref ref) {
    return mentorApplications(ref);
  }
}

String _$mentorApplicationsHash() =>
    r'14584f60e0da203951a4a79614921a6b6b88030b';

/// What the signed-in user can do; `null` when signed out. A failure to
/// load either source is an error, never a silent downgrade.

@ProviderFor(capabilities)
const capabilitiesProvider = CapabilitiesProvider._();

/// What the signed-in user can do; `null` when signed out. A failure to
/// load either source is an error, never a silent downgrade.

final class CapabilitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Capabilities?>,
          Capabilities?,
          FutureOr<Capabilities?>
        >
    with $FutureModifier<Capabilities?>, $FutureProvider<Capabilities?> {
  /// What the signed-in user can do; `null` when signed out. A failure to
  /// load either source is an error, never a silent downgrade.
  const CapabilitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'capabilitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$capabilitiesHash();

  @$internal
  @override
  $FutureProviderElement<Capabilities?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Capabilities?> create(Ref ref) {
    return capabilities(ref);
  }
}

String _$capabilitiesHash() => r'e6a6ad2cf4b3699ada56c8024391f4b57929f18f';
