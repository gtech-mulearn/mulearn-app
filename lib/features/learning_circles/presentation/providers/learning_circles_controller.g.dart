// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_circles_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(learningCirclesRemoteDataSource)
const learningCirclesRemoteDataSourceProvider =
    LearningCirclesRemoteDataSourceProvider._();

final class LearningCirclesRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          LearningCirclesRemoteDataSource,
          LearningCirclesRemoteDataSource,
          LearningCirclesRemoteDataSource
        >
    with $Provider<LearningCirclesRemoteDataSource> {
  const LearningCirclesRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningCirclesRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningCirclesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LearningCirclesRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LearningCirclesRemoteDataSource create(Ref ref) {
    return learningCirclesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningCirclesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningCirclesRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$learningCirclesRemoteDataSourceHash() =>
    r'cfc5d781a7a261a7911caf4beac01091abd73717';

/// Presentation depends on the [LearningCirclesRepository] contract
/// (rules.md §2/§5).

@ProviderFor(learningCirclesRepository)
const learningCirclesRepositoryProvider = LearningCirclesRepositoryProvider._();

/// Presentation depends on the [LearningCirclesRepository] contract
/// (rules.md §2/§5).

final class LearningCirclesRepositoryProvider
    extends
        $FunctionalProvider<
          LearningCirclesRepository,
          LearningCirclesRepository,
          LearningCirclesRepository
        >
    with $Provider<LearningCirclesRepository> {
  /// Presentation depends on the [LearningCirclesRepository] contract
  /// (rules.md §2/§5).
  const LearningCirclesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningCirclesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningCirclesRepositoryHash();

  @$internal
  @override
  $ProviderElement<LearningCirclesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LearningCirclesRepository create(Ref ref) {
    return learningCirclesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningCirclesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningCirclesRepository>(value),
    );
  }
}

String _$learningCirclesRepositoryHash() =>
    r'edd8d64217e58b023a75bdf17ae4ff242fed470f';

@ProviderFor(myCircles)
const myCirclesProvider = MyCirclesProvider._();

final class MyCirclesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LearningCircle>>,
          List<LearningCircle>,
          FutureOr<List<LearningCircle>>
        >
    with
        $FutureModifier<List<LearningCircle>>,
        $FutureProvider<List<LearningCircle>> {
  const MyCirclesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myCirclesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myCirclesHash();

  @$internal
  @override
  $FutureProviderElement<List<LearningCircle>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LearningCircle>> create(Ref ref) {
    return myCircles(ref);
  }
}

String _$myCirclesHash() => r'1fe2564b81aa0ce7d0502f2fa31fff8b9912b373';

@ProviderFor(circleDetail)
const circleDetailProvider = CircleDetailFamily._();

final class CircleDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<LearningCircleDetail>,
          LearningCircleDetail,
          FutureOr<LearningCircleDetail>
        >
    with
        $FutureModifier<LearningCircleDetail>,
        $FutureProvider<LearningCircleDetail> {
  const CircleDetailProvider._({
    required CircleDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'circleDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$circleDetailHash();

  @override
  String toString() {
    return r'circleDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<LearningCircleDetail> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LearningCircleDetail> create(Ref ref) {
    final argument = this.argument as String;
    return circleDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CircleDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$circleDetailHash() => r'6a94a629c7d0b5fbacac51c7a7c9f2f5b0a2f4ec';

final class CircleDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<LearningCircleDetail>, String> {
  const CircleDetailFamily._()
    : super(
        retry: null,
        name: r'circleDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CircleDetailProvider call(String id) =>
      CircleDetailProvider._(argument: id, from: this);

  @override
  String toString() => r'circleDetailProvider';
}

@ProviderFor(circleMembers)
const circleMembersProvider = CircleMembersFamily._();

final class CircleMembersProvider
    extends
        $FunctionalProvider<
          AsyncValue<CircleMembers>,
          CircleMembers,
          FutureOr<CircleMembers>
        >
    with $FutureModifier<CircleMembers>, $FutureProvider<CircleMembers> {
  const CircleMembersProvider._({
    required CircleMembersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'circleMembersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$circleMembersHash();

  @override
  String toString() {
    return r'circleMembersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CircleMembers> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CircleMembers> create(Ref ref) {
    final argument = this.argument as String;
    return circleMembers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CircleMembersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$circleMembersHash() => r'61f1da6b05c32912b2c83f9cac9d4f49a0a36ffd';

final class CircleMembersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CircleMembers>, String> {
  const CircleMembersFamily._()
    : super(
        retry: null,
        name: r'circleMembersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CircleMembersProvider call(String id) =>
      CircleMembersProvider._(argument: id, from: this);

  @override
  String toString() => r'circleMembersProvider';
}

@ProviderFor(circleJoinRequests)
const circleJoinRequestsProvider = CircleJoinRequestsFamily._();

final class CircleJoinRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JoinRequest>>,
          List<JoinRequest>,
          FutureOr<List<JoinRequest>>
        >
    with
        $FutureModifier<List<JoinRequest>>,
        $FutureProvider<List<JoinRequest>> {
  const CircleJoinRequestsProvider._({
    required CircleJoinRequestsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'circleJoinRequestsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$circleJoinRequestsHash();

  @override
  String toString() {
    return r'circleJoinRequestsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<JoinRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<JoinRequest>> create(Ref ref) {
    final argument = this.argument as String;
    return circleJoinRequests(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CircleJoinRequestsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$circleJoinRequestsHash() =>
    r'04700bdef56bb8eb0cef6eca0f439cbf1fa35e68';

final class CircleJoinRequestsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<JoinRequest>>, String> {
  const CircleJoinRequestsFamily._()
    : super(
        retry: null,
        name: r'circleJoinRequestsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CircleJoinRequestsProvider call(String id) =>
      CircleJoinRequestsProvider._(argument: id, from: this);

  @override
  String toString() => r'circleJoinRequestsProvider';
}

@ProviderFor(circleSentInvites)
const circleSentInvitesProvider = CircleSentInvitesFamily._();

final class CircleSentInvitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CircleInvite>>,
          List<CircleInvite>,
          FutureOr<List<CircleInvite>>
        >
    with
        $FutureModifier<List<CircleInvite>>,
        $FutureProvider<List<CircleInvite>> {
  const CircleSentInvitesProvider._({
    required CircleSentInvitesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'circleSentInvitesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$circleSentInvitesHash();

  @override
  String toString() {
    return r'circleSentInvitesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CircleInvite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CircleInvite>> create(Ref ref) {
    final argument = this.argument as String;
    return circleSentInvites(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CircleSentInvitesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$circleSentInvitesHash() => r'38134681215caab627bb3de8217bfd403a2d3f62';

final class CircleSentInvitesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CircleInvite>>, String> {
  const CircleSentInvitesFamily._()
    : super(
        retry: null,
        name: r'circleSentInvitesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CircleSentInvitesProvider call(String id) =>
      CircleSentInvitesProvider._(argument: id, from: this);

  @override
  String toString() => r'circleSentInvitesProvider';
}

@ProviderFor(myPendingCircleInvites)
const myPendingCircleInvitesProvider = MyPendingCircleInvitesProvider._();

final class MyPendingCircleInvitesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CircleInvite>>,
          List<CircleInvite>,
          FutureOr<List<CircleInvite>>
        >
    with
        $FutureModifier<List<CircleInvite>>,
        $FutureProvider<List<CircleInvite>> {
  const MyPendingCircleInvitesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPendingCircleInvitesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPendingCircleInvitesHash();

  @$internal
  @override
  $FutureProviderElement<List<CircleInvite>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CircleInvite>> create(Ref ref) {
    return myPendingCircleInvites(ref);
  }
}

String _$myPendingCircleInvitesHash() =>
    r'd75b493fc82a437eef366ce68dc7903cd59d0121';

/// IG options for the create-circle picker — `{id, name}` only (rules.md
/// §2: fetched independently rather than importing the `interest_groups`
/// feature's richer catalog).

@ProviderFor(circleIgOptions)
const circleIgOptionsProvider = CircleIgOptionsProvider._();

/// IG options for the create-circle picker — `{id, name}` only (rules.md
/// §2: fetched independently rather than importing the `interest_groups`
/// feature's richer catalog).

final class CircleIgOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SelectOption>>,
          List<SelectOption>,
          FutureOr<List<SelectOption>>
        >
    with
        $FutureModifier<List<SelectOption>>,
        $FutureProvider<List<SelectOption>> {
  /// IG options for the create-circle picker — `{id, name}` only (rules.md
  /// §2: fetched independently rather than importing the `interest_groups`
  /// feature's richer catalog).
  const CircleIgOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'circleIgOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$circleIgOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<SelectOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SelectOption>> create(Ref ref) {
    return circleIgOptions(ref);
  }
}

String _$circleIgOptionsHash() => r'b0089f447a4e2bc35866de0b8d41304bb9a5b09a';

/// College/org options for the create-circle picker — reuses the shared
/// [LocationRemoteDataSource] (rules.md §2), the same id space
/// `learningcircle/create/`'s `org` field validates against.

@ProviderFor(circleOrgOptions)
const circleOrgOptionsProvider = CircleOrgOptionsProvider._();

/// College/org options for the create-circle picker — reuses the shared
/// [LocationRemoteDataSource] (rules.md §2), the same id space
/// `learningcircle/create/`'s `org` field validates against.

final class CircleOrgOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SelectOption>>,
          List<SelectOption>,
          FutureOr<List<SelectOption>>
        >
    with
        $FutureModifier<List<SelectOption>>,
        $FutureProvider<List<SelectOption>> {
  /// College/org options for the create-circle picker — reuses the shared
  /// [LocationRemoteDataSource] (rules.md §2), the same id space
  /// `learningcircle/create/`'s `org` field validates against.
  const CircleOrgOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'circleOrgOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$circleOrgOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<SelectOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SelectOption>> create(Ref ref) {
    return circleOrgOptions(ref);
  }
}

String _$circleOrgOptionsHash() => r'926d97d6b6d9a416547de1ab53be863a4331bed9';

/// Accumulates circle catalog pages across "load more" — mirrors
/// [EventsListController]'s infinite-scroll pattern.

@ProviderFor(CirclesListController)
const circlesListControllerProvider = CirclesListControllerProvider._();

/// Accumulates circle catalog pages across "load more" — mirrors
/// [EventsListController]'s infinite-scroll pattern.
final class CirclesListControllerProvider
    extends
        $AsyncNotifierProvider<CirclesListController, List<LearningCircle>> {
  /// Accumulates circle catalog pages across "load more" — mirrors
  /// [EventsListController]'s infinite-scroll pattern.
  const CirclesListControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'circlesListControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$circlesListControllerHash();

  @$internal
  @override
  CirclesListController create() => CirclesListController();
}

String _$circlesListControllerHash() =>
    r'df90646c35588e4ec02c18caa2b3913ceee2cf15';

/// Accumulates circle catalog pages across "load more" — mirrors
/// [EventsListController]'s infinite-scroll pattern.

abstract class _$CirclesListController
    extends $AsyncNotifier<List<LearningCircle>> {
  FutureOr<List<LearningCircle>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<LearningCircle>>, List<LearningCircle>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<LearningCircle>>,
                List<LearningCircle>
              >,
              AsyncValue<List<LearningCircle>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Every mutating circle action (create/edit/delete/join/membership/
/// invites) — a single notifier so screens show one consistent busy/error
/// state, mirroring [InterestGroupMembershipController]'s pattern.

@ProviderFor(CircleActionsController)
const circleActionsControllerProvider = CircleActionsControllerProvider._();

/// Every mutating circle action (create/edit/delete/join/membership/
/// invites) — a single notifier so screens show one consistent busy/error
/// state, mirroring [InterestGroupMembershipController]'s pattern.
final class CircleActionsControllerProvider
    extends $AsyncNotifierProvider<CircleActionsController, void> {
  /// Every mutating circle action (create/edit/delete/join/membership/
  /// invites) — a single notifier so screens show one consistent busy/error
  /// state, mirroring [InterestGroupMembershipController]'s pattern.
  const CircleActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'circleActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$circleActionsControllerHash();

  @$internal
  @override
  CircleActionsController create() => CircleActionsController();
}

String _$circleActionsControllerHash() =>
    r'15c69d17767b38e2d0e16cf0ee4749321d2efaad';

/// Every mutating circle action (create/edit/delete/join/membership/
/// invites) — a single notifier so screens show one consistent busy/error
/// state, mirroring [InterestGroupMembershipController]'s pattern.

abstract class _$CircleActionsController extends $AsyncNotifier<void> {
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
