// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// A session's participants (first 50; sessions are small). Attendance
/// changes show at once and roll back if the backend refuses them.

@ProviderFor(SessionParticipantsController)
const sessionParticipantsControllerProvider =
    SessionParticipantsControllerFamily._();

/// A session's participants (first 50; sessions are small). Attendance
/// changes show at once and roll back if the backend refuses them.
final class SessionParticipantsControllerProvider
    extends
        $AsyncNotifierProvider<
          SessionParticipantsController,
          ({int count, List<SessionParticipant> items})
        > {
  /// A session's participants (first 50; sessions are small). Attendance
  /// changes show at once and roll back if the backend refuses them.
  const SessionParticipantsControllerProvider._({
    required SessionParticipantsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'sessionParticipantsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$sessionParticipantsControllerHash();

  @override
  String toString() {
    return r'sessionParticipantsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  SessionParticipantsController create() => SessionParticipantsController();

  @override
  bool operator ==(Object other) {
    return other is SessionParticipantsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$sessionParticipantsControllerHash() =>
    r'7480f14d3e4843898db61b73a2f9c0561a7a2437';

/// A session's participants (first 50; sessions are small). Attendance
/// changes show at once and roll back if the backend refuses them.

final class SessionParticipantsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          SessionParticipantsController,
          AsyncValue<({int count, List<SessionParticipant> items})>,
          ({int count, List<SessionParticipant> items}),
          FutureOr<({int count, List<SessionParticipant> items})>,
          String
        > {
  const SessionParticipantsControllerFamily._()
    : super(
        retry: noRetry,
        name: r'sessionParticipantsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A session's participants (first 50; sessions are small). Attendance
  /// changes show at once and roll back if the backend refuses them.

  SessionParticipantsControllerProvider call(String sessionId) =>
      SessionParticipantsControllerProvider._(argument: sessionId, from: this);

  @override
  String toString() => r'sessionParticipantsControllerProvider';
}

/// A session's participants (first 50; sessions are small). Attendance
/// changes show at once and roll back if the backend refuses them.

abstract class _$SessionParticipantsController
    extends $AsyncNotifier<({int count, List<SessionParticipant> items})> {
  late final _$args = ref.$arg as String;
  String get sessionId => _$args;

  FutureOr<({int count, List<SessionParticipant> items})> build(
    String sessionId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<
              AsyncValue<({int count, List<SessionParticipant> items})>,
              ({int count, List<SessionParticipant> items})
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<({int count, List<SessionParticipant> items})>,
                ({int count, List<SessionParticipant> items})
              >,
              AsyncValue<({int count, List<SessionParticipant> items})>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Marks a scheduled session completed. Success or failure, the session is
/// refetched so the screen shows the backend's current status.

@ProviderFor(SessionCompletion)
const sessionCompletionProvider = SessionCompletionProvider._();

/// Marks a scheduled session completed. Success or failure, the session is
/// refetched so the screen shows the backend's current status.
final class SessionCompletionProvider
    extends $NotifierProvider<SessionCompletion, void> {
  /// Marks a scheduled session completed. Success or failure, the session is
  /// refetched so the screen shows the backend's current status.
  const SessionCompletionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionCompletionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionCompletionHash();

  @$internal
  @override
  SessionCompletion create() => SessionCompletion();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$sessionCompletionHash() => r'9831423c935778239cc2de71772eebf2abbddc84';

/// Marks a scheduled session completed. Success or failure, the session is
/// refetched so the screen shows the backend's current status.

abstract class _$SessionCompletion extends $Notifier<void> {
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
