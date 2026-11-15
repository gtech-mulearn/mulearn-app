// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learner_sessions_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(learnerSessionsRepository)
final learnerSessionsRepositoryProvider = LearnerSessionsRepositoryProvider._();

final class LearnerSessionsRepositoryProvider
    extends
        $FunctionalProvider<
          LearnerSessionsRepository,
          LearnerSessionsRepository,
          LearnerSessionsRepository
        >
    with $Provider<LearnerSessionsRepository> {
  LearnerSessionsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learnerSessionsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learnerSessionsRepositoryHash();

  @$internal
  @override
  $ProviderElement<LearnerSessionsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LearnerSessionsRepository create(Ref ref) {
    return learnerSessionsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearnerSessionsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearnerSessionsRepository>(value),
    );
  }
}

String _$learnerSessionsRepositoryHash() =>
    r'7deed97a5e17ed7440a4ab9a1f0d6ff0049a9a22';

/// Sessions open to join, soonest first.

@ProviderFor(availableSessions)
final availableSessionsProvider = AvailableSessionsProvider._();

/// Sessions open to join, soonest first.

final class AvailableSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AvailableSession>>,
          List<AvailableSession>,
          FutureOr<List<AvailableSession>>
        >
    with
        $FutureModifier<List<AvailableSession>>,
        $FutureProvider<List<AvailableSession>> {
  /// Sessions open to join, soonest first.
  AvailableSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'availableSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$availableSessionsHash();

  @$internal
  @override
  $FutureProviderElement<List<AvailableSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AvailableSession>> create(Ref ref) {
    return availableSessions(ref);
  }
}

String _$availableSessionsHash() => r'76360518e26efba1bfa8e4f998b7bca44f027bbf';

/// What the learner joined or asked for, newest first.

@ProviderFor(mySessionHistory)
final mySessionHistoryProvider = MySessionHistoryProvider._();

/// What the learner joined or asked for, newest first.

final class MySessionHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SessionRecord>>,
          List<SessionRecord>,
          FutureOr<List<SessionRecord>>
        >
    with
        $FutureModifier<List<SessionRecord>>,
        $FutureProvider<List<SessionRecord>> {
  /// What the learner joined or asked for, newest first.
  MySessionHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mySessionHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mySessionHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<SessionRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SessionRecord>> create(Ref ref) {
    return mySessionHistory(ref);
  }
}

String _$mySessionHistoryHash() => r'5e6745676868f9b6343ab89b1865214149be9944';

/// The learner's requests to mentors.

@ProviderFor(mySessionRequests)
final mySessionRequestsProvider = MySessionRequestsProvider._();

/// The learner's requests to mentors.

final class MySessionRequestsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MySessionRequest>>,
          List<MySessionRequest>,
          FutureOr<List<MySessionRequest>>
        >
    with
        $FutureModifier<List<MySessionRequest>>,
        $FutureProvider<List<MySessionRequest>> {
  /// The learner's requests to mentors.
  MySessionRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mySessionRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mySessionRequestsHash();

  @$internal
  @override
  $FutureProviderElement<List<MySessionRequest>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MySessionRequest>> create(Ref ref) {
    return mySessionRequests(ref);
  }
}

String _$mySessionRequestsHash() => r'300dc458324120f91bac9318103e1cec4efd1b14';

/// The ids of sessions the learner already joined (from their history).

@ProviderFor(joinedSessionIds)
final joinedSessionIdsProvider = JoinedSessionIdsProvider._();

/// The ids of sessions the learner already joined (from their history).

final class JoinedSessionIdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Set<String>>,
          Set<String>,
          FutureOr<Set<String>>
        >
    with $FutureModifier<Set<String>>, $FutureProvider<Set<String>> {
  /// The ids of sessions the learner already joined (from their history).
  JoinedSessionIdsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'joinedSessionIdsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$joinedSessionIdsHash();

  @$internal
  @override
  $FutureProviderElement<Set<String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Set<String>> create(Ref ref) {
    return joinedSessionIds(ref);
  }
}

String _$joinedSessionIdsHash() => r'ae455d2c862f276309d40b80cbdb41af4bc29a92';

/// The learner's Interest Groups: where they can ask for a session.

@ProviderFor(myIgChoices)
final myIgChoicesProvider = MyIgChoicesProvider._();

/// The learner's Interest Groups: where they can ask for a session.

final class MyIgChoicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IgChoice>>,
          List<IgChoice>,
          FutureOr<List<IgChoice>>
        >
    with $FutureModifier<List<IgChoice>>, $FutureProvider<List<IgChoice>> {
  /// The learner's Interest Groups: where they can ask for a session.
  MyIgChoicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'myIgChoicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myIgChoicesHash();

  @$internal
  @override
  $FutureProviderElement<List<IgChoice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IgChoice>> create(Ref ref) {
    return myIgChoices(ref);
  }
}

String _$myIgChoicesHash() => r'2e7805e7bad35d7b157ebd08006482dbf63f429a';

/// Join, request and feedback: one notifier for one busy / error state.
/// Each success refreshes the lists it changes. Returns the backend's
/// message on success, null on failure (the error is in [state]).

@ProviderFor(LearnerSessionActions)
final learnerSessionActionsProvider = LearnerSessionActionsProvider._();

/// Join, request and feedback: one notifier for one busy / error state.
/// Each success refreshes the lists it changes. Returns the backend's
/// message on success, null on failure (the error is in [state]).
final class LearnerSessionActionsProvider
    extends $AsyncNotifierProvider<LearnerSessionActions, void> {
  /// Join, request and feedback: one notifier for one busy / error state.
  /// Each success refreshes the lists it changes. Returns the backend's
  /// message on success, null on failure (the error is in [state]).
  LearnerSessionActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learnerSessionActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learnerSessionActionsHash();

  @$internal
  @override
  LearnerSessionActions create() => LearnerSessionActions();
}

String _$learnerSessionActionsHash() =>
    r'3d0738a859e375c71ad9dd2a96b97fc80fcf3f0c';

/// Join, request and feedback: one notifier for one busy / error state.
/// Each success refreshes the lists it changes. Returns the backend's
/// message on success, null on failure (the error is in [state]).

abstract class _$LearnerSessionActions extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
