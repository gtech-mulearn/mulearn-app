// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'welcome_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(welcomeRemoteDataSource)
const welcomeRemoteDataSourceProvider = WelcomeRemoteDataSourceProvider._();

final class WelcomeRemoteDataSourceProvider
    extends $FunctionalProvider<WelcomeRemoteDataSource, WelcomeRemoteDataSource, WelcomeRemoteDataSource>
    with $Provider<WelcomeRemoteDataSource> {
  const WelcomeRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'welcomeRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$welcomeRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<WelcomeRemoteDataSource> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  WelcomeRemoteDataSource create(Ref ref) {
    return welcomeRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WelcomeRemoteDataSource value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<WelcomeRemoteDataSource>(value));
  }
}

String _$welcomeRemoteDataSourceHash() => r'a354a8daaf981d89bd7e1d444f39f20f22dc1df6';

/// Community counts for the arrival beats and the Commons.

@ProviderFor(publicStats)
const publicStatsProvider = PublicStatsProvider._();

/// Community counts for the arrival beats and the Commons.

final class PublicStatsProvider extends $FunctionalProvider<AsyncValue<PublicStats>, PublicStats, FutureOr<PublicStats>>
    with $FutureModifier<PublicStats>, $FutureProvider<PublicStats> {
  /// Community counts for the arrival beats and the Commons.
  const PublicStatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'publicStatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$publicStatsHash();

  @$internal
  @override
  $FutureProviderElement<PublicStats> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicStats> create(Ref ref) {
    return publicStats(ref);
  }
}

String _$publicStatsHash() => r'231f0619bfe709925684061a7fc33b5e5907ac2c';

/// Featured events, for the "Then show up" beat and the Commons.

@ProviderFor(guestFeaturedEvents)
const guestFeaturedEventsProvider = GuestFeaturedEventsProvider._();

/// Featured events, for the "Then show up" beat and the Commons.

final class GuestFeaturedEventsProvider
    extends $FunctionalProvider<AsyncValue<List<GuestEvent>>, List<GuestEvent>, FutureOr<List<GuestEvent>>>
    with $FutureModifier<List<GuestEvent>>, $FutureProvider<List<GuestEvent>> {
  /// Featured events, for the "Then show up" beat and the Commons.
  const GuestFeaturedEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestFeaturedEventsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestFeaturedEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<GuestEvent>> $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<GuestEvent>> create(Ref ref) {
    return guestFeaturedEvents(ref);
  }
}

String _$guestFeaturedEventsHash() => r'239aca4cc120ff0380acfa424fa4af3554d4c994';

/// Every Interest Group's name, for the ring that bursts into stickers.

@ProviderFor(guestInterestGroups)
const guestInterestGroupsProvider = GuestInterestGroupsProvider._();

/// Every Interest Group's name, for the ring that bursts into stickers.

final class GuestInterestGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<GuestInterestGroup>>,
          List<GuestInterestGroup>,
          FutureOr<List<GuestInterestGroup>>
        >
    with $FutureModifier<List<GuestInterestGroup>>, $FutureProvider<List<GuestInterestGroup>> {
  /// Every Interest Group's name, for the ring that bursts into stickers.
  const GuestInterestGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'guestInterestGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$guestInterestGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<GuestInterestGroup>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<GuestInterestGroup>> create(Ref ref) {
    return guestInterestGroups(ref);
  }
}

String _$guestInterestGroupsHash() => r'9f06804e5d4cea5680e355f337946a215c0b16a9';

/// Whether this device has seen the arrival beats. Not a secret, but the
/// app already keeps one small store, so it lives in secure storage.

@ProviderFor(ArrivalSeen)
const arrivalSeenProvider = ArrivalSeenProvider._();

/// Whether this device has seen the arrival beats. Not a secret, but the
/// app already keeps one small store, so it lives in secure storage.
final class ArrivalSeenProvider extends $AsyncNotifierProvider<ArrivalSeen, bool> {
  /// Whether this device has seen the arrival beats. Not a secret, but the
  /// app already keeps one small store, so it lives in secure storage.
  const ArrivalSeenProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'arrivalSeenProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$arrivalSeenHash();

  @$internal
  @override
  ArrivalSeen create() => ArrivalSeen();
}

String _$arrivalSeenHash() => r'6ad96cb110cf42a1a10ad0de0ac5d46203c14d70';

/// Whether this device has seen the arrival beats. Not a secret, but the
/// app already keeps one small store, so it lives in secure storage.

abstract class _$ArrivalSeen extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<AsyncValue<bool>, bool>, AsyncValue<bool>, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
