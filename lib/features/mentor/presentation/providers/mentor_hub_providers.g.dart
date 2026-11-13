// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_hub_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The mentor's scopes with their numbers (`overview/`).

@ProviderFor(mentorOverview)
const mentorOverviewProvider = MentorOverviewProvider._();

/// The mentor's scopes with their numbers (`overview/`).

final class MentorOverviewProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorScope>>,
          List<MentorScope>,
          FutureOr<List<MentorScope>>
        >
    with
        $FutureModifier<List<MentorScope>>,
        $FutureProvider<List<MentorScope>> {
  /// The mentor's scopes with their numbers (`overview/`).
  const MentorOverviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorOverviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorOverviewHash();

  @$internal
  @override
  $FutureProviderElement<List<MentorScope>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorScope>> create(Ref ref) {
    return mentorOverview(ref);
  }
}

String _$mentorOverviewHash() => r'd0224b85dbc0e48d444e20ee5f590e07c2f38fff';

@ProviderFor(mentorAnalytics)
const mentorAnalyticsProvider = MentorAnalyticsProvider._();

final class MentorAnalyticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<MentorAnalytics>,
          MentorAnalytics,
          FutureOr<MentorAnalytics>
        >
    with $FutureModifier<MentorAnalytics>, $FutureProvider<MentorAnalytics> {
  const MentorAnalyticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorAnalyticsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorAnalyticsHash();

  @$internal
  @override
  $FutureProviderElement<MentorAnalytics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MentorAnalytics> create(Ref ref) {
    return mentorAnalytics(ref);
  }
}

String _$mentorAnalyticsHash() => r'e88f18ea62fe58961a5af5c2bfa5016aa4af7c3d';

@ProviderFor(mentorProfileCompletion)
const mentorProfileCompletionProvider = MentorProfileCompletionProvider._();

final class MentorProfileCompletionProvider
    extends
        $FunctionalProvider<
          AsyncValue<MentorProfileCompletion>,
          MentorProfileCompletion,
          FutureOr<MentorProfileCompletion>
        >
    with
        $FutureModifier<MentorProfileCompletion>,
        $FutureProvider<MentorProfileCompletion> {
  const MentorProfileCompletionProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorProfileCompletionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorProfileCompletionHash();

  @$internal
  @override
  $FutureProviderElement<MentorProfileCompletion> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MentorProfileCompletion> create(Ref ref) {
    return mentorProfileCompletion(ref);
  }
}

String _$mentorProfileCompletionHash() =>
    r'893aaa3c786374fc6a964d270cbd0be185baf950';

/// The next scheduled sessions, soonest first (5 at most), without any that
/// already ended.

@ProviderFor(mentorNextSessions)
const mentorNextSessionsProvider = MentorNextSessionsProvider._();

/// The next scheduled sessions, soonest first (5 at most), without any that
/// already ended.

final class MentorNextSessionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorSession>>,
          List<MentorSession>,
          FutureOr<List<MentorSession>>
        >
    with
        $FutureModifier<List<MentorSession>>,
        $FutureProvider<List<MentorSession>> {
  /// The next scheduled sessions, soonest first (5 at most), without any that
  /// already ended.
  const MentorNextSessionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorNextSessionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorNextSessionsHash();

  @$internal
  @override
  $FutureProviderElement<List<MentorSession>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorSession>> create(Ref ref) {
    return mentorNextSessions(ref);
  }
}

String _$mentorNextSessionsHash() =>
    r'74737fc6043dddafae0bcbf1eb4e40d433703d94';

/// How many student session requests wait for the mentor.

@ProviderFor(mentorRequestCount)
const mentorRequestCountProvider = MentorRequestCountProvider._();

/// How many student session requests wait for the mentor.

final class MentorRequestCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// How many student session requests wait for the mentor.
  const MentorRequestCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorRequestCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorRequestCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return mentorRequestCount(ref);
  }
}

String _$mentorRequestCountHash() =>
    r'3840598c533d73183da20556c032c0d6ffa6b37a';
