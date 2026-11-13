// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_groups_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(interestGroupsRemoteDataSource)
const interestGroupsRemoteDataSourceProvider =
    InterestGroupsRemoteDataSourceProvider._();

final class InterestGroupsRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          InterestGroupsRemoteDataSource,
          InterestGroupsRemoteDataSource,
          InterestGroupsRemoteDataSource
        >
    with $Provider<InterestGroupsRemoteDataSource> {
  const InterestGroupsRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestGroupsRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestGroupsRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<InterestGroupsRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InterestGroupsRemoteDataSource create(Ref ref) {
    return interestGroupsRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InterestGroupsRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InterestGroupsRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$interestGroupsRemoteDataSourceHash() =>
    r'0eec931ccf5d2dcd03c84afad5abc2ef91721a9c';

/// Presentation depends on the [InterestGroupsRepository] contract
/// (rules.md §2/§5).

@ProviderFor(interestGroupsRepository)
const interestGroupsRepositoryProvider = InterestGroupsRepositoryProvider._();

/// Presentation depends on the [InterestGroupsRepository] contract
/// (rules.md §2/§5).

final class InterestGroupsRepositoryProvider
    extends
        $FunctionalProvider<
          InterestGroupsRepository,
          InterestGroupsRepository,
          InterestGroupsRepository
        >
    with $Provider<InterestGroupsRepository> {
  /// Presentation depends on the [InterestGroupsRepository] contract
  /// (rules.md §2/§5).
  const InterestGroupsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestGroupsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestGroupsRepositoryHash();

  @$internal
  @override
  $ProviderElement<InterestGroupsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  InterestGroupsRepository create(Ref ref) {
    return interestGroupsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InterestGroupsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InterestGroupsRepository>(value),
    );
  }
}

String _$interestGroupsRepositoryHash() =>
    r'38a50a508b393bfedc8eb5d7d86f5cb86bd3e8b6';

@ProviderFor(interestGroupsCatalog)
const interestGroupsCatalogProvider = InterestGroupsCatalogProvider._();

final class InterestGroupsCatalogProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<InterestGroupSummary>>,
          List<InterestGroupSummary>,
          FutureOr<List<InterestGroupSummary>>
        >
    with
        $FutureModifier<List<InterestGroupSummary>>,
        $FutureProvider<List<InterestGroupSummary>> {
  const InterestGroupsCatalogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestGroupsCatalogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$interestGroupsCatalogHash();

  @$internal
  @override
  $FutureProviderElement<List<InterestGroupSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<InterestGroupSummary>> create(Ref ref) {
    return interestGroupsCatalog(ref);
  }
}

String _$interestGroupsCatalogHash() =>
    r'e3cabc5ddb53c9be19ebad74717481bb47677815';

@ProviderFor(interestGroupDetail)
const interestGroupDetailProvider = InterestGroupDetailFamily._();

final class InterestGroupDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<InterestGroupSummary>,
          InterestGroupSummary,
          FutureOr<InterestGroupSummary>
        >
    with
        $FutureModifier<InterestGroupSummary>,
        $FutureProvider<InterestGroupSummary> {
  const InterestGroupDetailProvider._({
    required InterestGroupDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'interestGroupDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$interestGroupDetailHash();

  @override
  String toString() {
    return r'interestGroupDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<InterestGroupSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<InterestGroupSummary> create(Ref ref) {
    final argument = this.argument as String;
    return interestGroupDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InterestGroupDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$interestGroupDetailHash() =>
    r'a6778a80b8d4e7d944d996a47f012dd5b13e6107';

final class InterestGroupDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<InterestGroupSummary>, String> {
  const InterestGroupDetailFamily._()
    : super(
        retry: null,
        name: r'interestGroupDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InterestGroupDetailProvider call(String id) =>
      InterestGroupDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'interestGroupDetailProvider';
}

@ProviderFor(myInterestGroupIds)
const myInterestGroupIdsProvider = MyInterestGroupIdsProvider._();

final class MyInterestGroupIdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>
        >
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  const MyInterestGroupIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'myInterestGroupIdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myInterestGroupIdsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return myInterestGroupIds(ref);
  }
}

String _$myInterestGroupIdsHash() =>
    r'3864b731ebe0559b1be8520023d12cc2592a43e5';

/// The first circles in a group, for its page.

@ProviderFor(circlesInGroup)
const circlesInGroupProvider = CirclesInGroupFamily._();

/// The first circles in a group, for its page.

final class CirclesInGroupProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IgCircleRef>>,
          List<IgCircleRef>,
          FutureOr<List<IgCircleRef>>
        >
    with
        $FutureModifier<List<IgCircleRef>>,
        $FutureProvider<List<IgCircleRef>> {
  /// The first circles in a group, for its page.
  const CirclesInGroupProvider._({
    required CirclesInGroupFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'circlesInGroupProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$circlesInGroupHash();

  @override
  String toString() {
    return r'circlesInGroupProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<IgCircleRef>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IgCircleRef>> create(Ref ref) {
    final argument = this.argument as String;
    return circlesInGroup(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CirclesInGroupProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$circlesInGroupHash() => r'cce060fd5807d54f381a51c10a2f76b058ff3c77';

/// The first circles in a group, for its page.

final class CirclesInGroupFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<IgCircleRef>>, String> {
  const CirclesInGroupFamily._()
    : super(
        retry: noRetry,
        name: r'circlesInGroupProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The first circles in a group, for its page.

  CirclesInGroupProvider call(String igId) =>
      CirclesInGroupProvider._(argument: igId, from: this);

  @override
  String toString() => r'circlesInGroupProvider';
}

/// The first events scoped to a group, for its page.

@ProviderFor(eventsInGroup)
const eventsInGroupProvider = EventsInGroupFamily._();

/// The first events scoped to a group, for its page.

final class EventsInGroupProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IgEventRef>>,
          List<IgEventRef>,
          FutureOr<List<IgEventRef>>
        >
    with $FutureModifier<List<IgEventRef>>, $FutureProvider<List<IgEventRef>> {
  /// The first events scoped to a group, for its page.
  const EventsInGroupProvider._({
    required EventsInGroupFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'eventsInGroupProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$eventsInGroupHash();

  @override
  String toString() {
    return r'eventsInGroupProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<IgEventRef>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IgEventRef>> create(Ref ref) {
    final argument = this.argument as String;
    return eventsInGroup(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EventsInGroupProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$eventsInGroupHash() => r'2df1c74a9b9149035d957ff012a6d4d1ed6b775d';

/// The first events scoped to a group, for its page.

final class EventsInGroupFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<IgEventRef>>, String> {
  const EventsInGroupFamily._()
    : super(
        retry: noRetry,
        name: r'eventsInGroupProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The first events scoped to a group, for its page.

  EventsInGroupProvider call(String igId) =>
      EventsInGroupProvider._(argument: igId, from: this);

  @override
  String toString() => r'eventsInGroupProvider';
}

/// Joins or leaves one group through its own endpoints (FEAT-08) — no
/// full-list rewrite, so a group joined elsewhere can't be dropped — then
/// refreshes the shared profile so every card (and Profile) shows it.

@ProviderFor(InterestGroupMembershipController)
const interestGroupMembershipControllerProvider =
    InterestGroupMembershipControllerProvider._();

/// Joins or leaves one group through its own endpoints (FEAT-08) — no
/// full-list rewrite, so a group joined elsewhere can't be dropped — then
/// refreshes the shared profile so every card (and Profile) shows it.
final class InterestGroupMembershipControllerProvider
    extends $AsyncNotifierProvider<InterestGroupMembershipController, void> {
  /// Joins or leaves one group through its own endpoints (FEAT-08) — no
  /// full-list rewrite, so a group joined elsewhere can't be dropped — then
  /// refreshes the shared profile so every card (and Profile) shows it.
  const InterestGroupMembershipControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'interestGroupMembershipControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$interestGroupMembershipControllerHash();

  @$internal
  @override
  InterestGroupMembershipController create() =>
      InterestGroupMembershipController();
}

String _$interestGroupMembershipControllerHash() =>
    r'2b392660e9a46b3abf3c01af5655408b1e63833c';

/// Joins or leaves one group through its own endpoints (FEAT-08) — no
/// full-list rewrite, so a group joined elsewhere can't be dropped — then
/// refreshes the shared profile so every card (and Profile) shows it.

abstract class _$InterestGroupMembershipController
    extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
