// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dashboardRemoteDataSource)
const dashboardRemoteDataSourceProvider = DashboardRemoteDataSourceProvider._();

final class DashboardRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          DashboardRemoteDataSource,
          DashboardRemoteDataSource,
          DashboardRemoteDataSource
        >
    with $Provider<DashboardRemoteDataSource> {
  const DashboardRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<DashboardRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardRemoteDataSource create(Ref ref) {
    return dashboardRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRemoteDataSource>(value),
    );
  }
}

String _$dashboardRemoteDataSourceHash() =>
    r'0fe8dc540cdbf6ec63852b5682cae016cc1bd745';

/// Presentation depends on the [DashboardRepository] contract (rules.md
/// §2/§5).

@ProviderFor(dashboardRepository)
const dashboardRepositoryProvider = DashboardRepositoryProvider._();

/// Presentation depends on the [DashboardRepository] contract (rules.md
/// §2/§5).

final class DashboardRepositoryProvider
    extends
        $FunctionalProvider<
          DashboardRepository,
          DashboardRepository,
          DashboardRepository
        >
    with $Provider<DashboardRepository> {
  /// Presentation depends on the [DashboardRepository] contract (rules.md
  /// §2/§5).
  const DashboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<DashboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DashboardRepository create(Ref ref) {
    return dashboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DashboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DashboardRepository>(value),
    );
  }
}

String _$dashboardRepositoryHash() =>
    r'7b8de6e77090b445fd69facc27796ecb670a7ec1';

@ProviderFor(KarmaFeedController)
const karmaFeedControllerProvider = KarmaFeedControllerProvider._();

final class KarmaFeedControllerProvider
    extends $AsyncNotifierProvider<KarmaFeedController, KarmaFeed> {
  const KarmaFeedControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'karmaFeedControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$karmaFeedControllerHash();

  @$internal
  @override
  KarmaFeedController create() => KarmaFeedController();
}

String _$karmaFeedControllerHash() =>
    r'd7062589ea7ef0af238b36b131869262a58845d0';

abstract class _$KarmaFeedController extends $AsyncNotifier<KarmaFeed> {
  FutureOr<KarmaFeed> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<KarmaFeed>, KarmaFeed>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<KarmaFeed>, KarmaFeed>,
              AsyncValue<KarmaFeed>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(FeaturedEventsController)
const featuredEventsControllerProvider = FeaturedEventsControllerProvider._();

final class FeaturedEventsControllerProvider
    extends
        $AsyncNotifierProvider<FeaturedEventsController, List<FeaturedEvent>> {
  const FeaturedEventsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'featuredEventsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$featuredEventsControllerHash();

  @$internal
  @override
  FeaturedEventsController create() => FeaturedEventsController();
}

String _$featuredEventsControllerHash() =>
    r'f54578ca25cbeccb5716c6754c9e39b900e51097';

abstract class _$FeaturedEventsController
    extends $AsyncNotifier<List<FeaturedEvent>> {
  FutureOr<List<FeaturedEvent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<FeaturedEvent>>, List<FeaturedEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FeaturedEvent>>, List<FeaturedEvent>>,
              AsyncValue<List<FeaturedEvent>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MyProgressSummaryController)
const myProgressSummaryControllerProvider =
    MyProgressSummaryControllerProvider._();

final class MyProgressSummaryControllerProvider
    extends
        $AsyncNotifierProvider<MyProgressSummaryController, MyProgressSummary> {
  const MyProgressSummaryControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProgressSummaryControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProgressSummaryControllerHash();

  @$internal
  @override
  MyProgressSummaryController create() => MyProgressSummaryController();
}

String _$myProgressSummaryControllerHash() =>
    r'b23e73332b7518149afc582121e0a6da2ec35df4';

abstract class _$MyProgressSummaryController
    extends $AsyncNotifier<MyProgressSummary> {
  FutureOr<MyProgressSummary> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<MyProgressSummary>, MyProgressSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MyProgressSummary>, MyProgressSummary>,
              AsyncValue<MyProgressSummary>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
