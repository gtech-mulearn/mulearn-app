// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_sessions_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The mentor's sessions for one [SessionFilter], page by page. A failed
/// "load more" keeps the rows and records the error for an inline retry.

@ProviderFor(MentorSessionsController)
const mentorSessionsControllerProvider = MentorSessionsControllerFamily._();

/// The mentor's sessions for one [SessionFilter], page by page. A failed
/// "load more" keeps the rows and records the error for an inline retry.
final class MentorSessionsControllerProvider
    extends
        $AsyncNotifierProvider<
          MentorSessionsController,
          PagedState<MentorSession>
        > {
  /// The mentor's sessions for one [SessionFilter], page by page. A failed
  /// "load more" keeps the rows and records the error for an inline retry.
  const MentorSessionsControllerProvider._({
    required MentorSessionsControllerFamily super.from,
    required SessionFilter super.argument,
  }) : super(
         retry: noRetry,
         name: r'mentorSessionsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mentorSessionsControllerHash();

  @override
  String toString() {
    return r'mentorSessionsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MentorSessionsController create() => MentorSessionsController();

  @override
  bool operator ==(Object other) {
    return other is MentorSessionsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mentorSessionsControllerHash() =>
    r'2a501228aece12cc5ec57abfc6067ef3153fc403';

/// The mentor's sessions for one [SessionFilter], page by page. A failed
/// "load more" keeps the rows and records the error for an inline retry.

final class MentorSessionsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          MentorSessionsController,
          AsyncValue<PagedState<MentorSession>>,
          PagedState<MentorSession>,
          FutureOr<PagedState<MentorSession>>,
          SessionFilter
        > {
  const MentorSessionsControllerFamily._()
    : super(
        retry: noRetry,
        name: r'mentorSessionsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The mentor's sessions for one [SessionFilter], page by page. A failed
  /// "load more" keeps the rows and records the error for an inline retry.

  MentorSessionsControllerProvider call(SessionFilter filter) =>
      MentorSessionsControllerProvider._(argument: filter, from: this);

  @override
  String toString() => r'mentorSessionsControllerProvider';
}

/// The mentor's sessions for one [SessionFilter], page by page. A failed
/// "load more" keeps the rows and records the error for an inline retry.

abstract class _$MentorSessionsController
    extends $AsyncNotifier<PagedState<MentorSession>> {
  late final _$args = ref.$arg as SessionFilter;
  SessionFilter get filter => _$args;

  FutureOr<PagedState<MentorSession>> build(SessionFilter filter);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<MentorSession>>,
              PagedState<MentorSession>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<MentorSession>>,
                PagedState<MentorSession>
              >,
              AsyncValue<PagedState<MentorSession>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// One of the mentor's sessions (`session/list/<id>/`).

@ProviderFor(mentorSession)
const mentorSessionProvider = MentorSessionFamily._();

/// One of the mentor's sessions (`session/list/<id>/`).

final class MentorSessionProvider
    extends
        $FunctionalProvider<
          AsyncValue<MentorSession>,
          MentorSession,
          FutureOr<MentorSession>
        >
    with $FutureModifier<MentorSession>, $FutureProvider<MentorSession> {
  /// One of the mentor's sessions (`session/list/<id>/`).
  const MentorSessionProvider._({
    required MentorSessionFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'mentorSessionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mentorSessionHash();

  @override
  String toString() {
    return r'mentorSessionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MentorSession> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MentorSession> create(Ref ref) {
    final argument = this.argument as String;
    return mentorSession(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MentorSessionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mentorSessionHash() => r'beaa953e519ce03c02ba717ab24d3a9d0c7c0eea';

/// One of the mentor's sessions (`session/list/<id>/`).

final class MentorSessionFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MentorSession>, String> {
  const MentorSessionFamily._()
    : super(
        retry: noRetry,
        name: r'mentorSessionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One of the mentor's sessions (`session/list/<id>/`).

  MentorSessionProvider call(String id) =>
      MentorSessionProvider._(argument: id, from: this);

  @override
  String toString() => r'mentorSessionProvider';
}

/// The interest groups the mentor can use.

@ProviderFor(mentorIgs)
const mentorIgsProvider = MentorIgsProvider._();

/// The interest groups the mentor can use.

final class MentorIgsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<IgOption>>,
          List<IgOption>,
          FutureOr<List<IgOption>>
        >
    with $FutureModifier<List<IgOption>>, $FutureProvider<List<IgOption>> {
  /// The interest groups the mentor can use.
  const MentorIgsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorIgsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorIgsHash();

  @$internal
  @override
  $FutureProviderElement<List<IgOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<IgOption>> create(Ref ref) {
    return mentorIgs(ref);
  }
}

String _$mentorIgsHash() => r'948c618de778518af78c0a849e7e6d4d92b7cb50';

/// Where the mentor can create sessions. The interest-group list is fetched
/// only for a global mentor.

@ProviderFor(sessionTargets)
const sessionTargetsProvider = SessionTargetsProvider._();

/// Where the mentor can create sessions. The interest-group list is fetched
/// only for a global mentor.

final class SessionTargetsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SessionTarget>>,
          List<SessionTarget>,
          FutureOr<List<SessionTarget>>
        >
    with
        $FutureModifier<List<SessionTarget>>,
        $FutureProvider<List<SessionTarget>> {
  /// Where the mentor can create sessions. The interest-group list is fetched
  /// only for a global mentor.
  const SessionTargetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'sessionTargetsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionTargetsHash();

  @$internal
  @override
  $FutureProviderElement<List<SessionTarget>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SessionTarget>> create(Ref ref) {
    return sessionTargets(ref);
  }
}

String _$sessionTargetsHash() => r'ac75c6dbb7784ff316fa8e40312a3598d9121e8d';

/// Create, edit and delete. Each refreshes the lists and the hub after it
/// succeeds, even if the screen closed meanwhile (keep-alive). Errors are
/// thrown to the caller, which shows them.

@ProviderFor(SessionActions)
const sessionActionsProvider = SessionActionsProvider._();

/// Create, edit and delete. Each refreshes the lists and the hub after it
/// succeeds, even if the screen closed meanwhile (keep-alive). Errors are
/// thrown to the caller, which shows them.
final class SessionActionsProvider
    extends $NotifierProvider<SessionActions, void> {
  /// Create, edit and delete. Each refreshes the lists and the hub after it
  /// succeeds, even if the screen closed meanwhile (keep-alive). Errors are
  /// thrown to the caller, which shows them.
  const SessionActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionActionsHash();

  @$internal
  @override
  SessionActions create() => SessionActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$sessionActionsHash() => r'fc110f7cace92c45e3c85871bbde684b0e96fe1d';

/// Create, edit and delete. Each refreshes the lists and the hub after it
/// succeeds, even if the screen closed meanwhile (keep-alive). Errors are
/// thrown to the caller, which shows them.

abstract class _$SessionActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
