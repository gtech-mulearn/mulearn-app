// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_statements_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(problemStatementsRepository)
final problemStatementsRepositoryProvider =
    ProblemStatementsRepositoryProvider._();

final class ProblemStatementsRepositoryProvider
    extends
        $FunctionalProvider<
          ProblemStatementsRepository,
          ProblemStatementsRepository,
          ProblemStatementsRepository
        >
    with $Provider<ProblemStatementsRepository> {
  ProblemStatementsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'problemStatementsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$problemStatementsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProblemStatementsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProblemStatementsRepository create(Ref ref) {
    return problemStatementsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProblemStatementsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProblemStatementsRepository>(value),
    );
  }
}

String _$problemStatementsRepositoryHash() =>
    r'3ce2245a923c71121710394c2e3ca3ba6cc820d6';

/// The published feed for a search (all when empty), optionally only those
/// still open, page by page. Each search is kept for a while once seen.

@ProviderFor(PsFeed)
final psFeedProvider = PsFeedFamily._();

/// The published feed for a search (all when empty), optionally only those
/// still open, page by page. Each search is kept for a while once seen.
final class PsFeedProvider
    extends $AsyncNotifierProvider<PsFeed, PagedState<ProblemStatement>> {
  /// The published feed for a search (all when empty), optionally only those
  /// still open, page by page. Each search is kept for a while once seen.
  PsFeedProvider._({
    required PsFeedFamily super.from,
    required (String, bool) super.argument,
  }) : super(
         retry: noRetry,
         name: r'psFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$psFeedHash();

  @override
  String toString() {
    return r'psFeedProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PsFeed create() => PsFeed();

  @override
  bool operator ==(Object other) {
    return other is PsFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$psFeedHash() => r'7a5559e896ab2acb01e8fb7bd31bfd4e7aca55af';

/// The published feed for a search (all when empty), optionally only those
/// still open, page by page. Each search is kept for a while once seen.

final class PsFeedFamily extends $Family
    with
        $ClassFamilyOverride<
          PsFeed,
          AsyncValue<PagedState<ProblemStatement>>,
          PagedState<ProblemStatement>,
          FutureOr<PagedState<ProblemStatement>>,
          (String, bool)
        > {
  PsFeedFamily._()
    : super(
        retry: noRetry,
        name: r'psFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The published feed for a search (all when empty), optionally only those
  /// still open, page by page. Each search is kept for a while once seen.

  PsFeedProvider call(String search, bool openOnly) =>
      PsFeedProvider._(argument: (search, openOnly), from: this);

  @override
  String toString() => r'psFeedProvider';
}

/// The published feed for a search (all when empty), optionally only those
/// still open, page by page. Each search is kept for a while once seen.

abstract class _$PsFeed extends $AsyncNotifier<PagedState<ProblemStatement>> {
  late final _$args = ref.$arg as (String, bool);
  String get search => _$args.$1;
  bool get openOnly => _$args.$2;

  FutureOr<PagedState<ProblemStatement>> build(String search, bool openOnly);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<ProblemStatement>>,
              PagedState<ProblemStatement>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<ProblemStatement>>,
                PagedState<ProblemStatement>
              >,
              AsyncValue<PagedState<ProblemStatement>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// What the learner is trying or has submitted to, newest first.

@ProviderFor(psParticipating)
final psParticipatingProvider = PsParticipatingProvider._();

/// What the learner is trying or has submitted to, newest first.

final class PsParticipatingProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProblemStatement>>,
          List<ProblemStatement>,
          FutureOr<List<ProblemStatement>>
        >
    with
        $FutureModifier<List<ProblemStatement>>,
        $FutureProvider<List<ProblemStatement>> {
  /// What the learner is trying or has submitted to, newest first.
  PsParticipatingProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'psParticipatingProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$psParticipatingHash();

  @$internal
  @override
  $FutureProviderElement<List<ProblemStatement>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProblemStatement>> create(Ref ref) {
    return psParticipating(ref);
  }
}

String _$psParticipatingHash() => r'5975c10aaadc67bf749aed01d0b7c117f53b524d';

/// One statement.

@ProviderFor(problemStatement)
final problemStatementProvider = ProblemStatementFamily._();

/// One statement.

final class ProblemStatementProvider
    extends
        $FunctionalProvider<
          AsyncValue<ProblemStatement>,
          ProblemStatement,
          FutureOr<ProblemStatement>
        >
    with $FutureModifier<ProblemStatement>, $FutureProvider<ProblemStatement> {
  /// One statement.
  ProblemStatementProvider._({
    required ProblemStatementFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'problemStatementProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$problemStatementHash();

  @override
  String toString() {
    return r'problemStatementProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ProblemStatement> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ProblemStatement> create(Ref ref) {
    final argument = this.argument as String;
    return problemStatement(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProblemStatementProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$problemStatementHash() => r'88f4db8821804b34d0473974353d05d0bcc7adb7';

/// One statement.

final class ProblemStatementFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ProblemStatement>, String> {
  ProblemStatementFamily._()
    : super(
        retry: noRetry,
        name: r'problemStatementProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One statement.

  ProblemStatementProvider call(String id) =>
      ProblemStatementProvider._(argument: id, from: this);

  @override
  String toString() => r'problemStatementProvider';
}

/// The learner's own interaction with it (status and solution link).

@ProviderFor(myPsParticipation)
final myPsParticipationProvider = MyPsParticipationFamily._();

/// The learner's own interaction with it (status and solution link).

final class MyPsParticipationProvider
    extends
        $FunctionalProvider<
          AsyncValue<MyPsParticipation>,
          MyPsParticipation,
          FutureOr<MyPsParticipation>
        >
    with
        $FutureModifier<MyPsParticipation>,
        $FutureProvider<MyPsParticipation> {
  /// The learner's own interaction with it (status and solution link).
  MyPsParticipationProvider._({
    required MyPsParticipationFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'myPsParticipationProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$myPsParticipationHash();

  @override
  String toString() {
    return r'myPsParticipationProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MyPsParticipation> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MyPsParticipation> create(Ref ref) {
    final argument = this.argument as String;
    return myPsParticipation(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MyPsParticipationProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myPsParticipationHash() => r'207e6bd9dae6db84bd6e7569744c17f977177093';

/// The learner's own interaction with it (status and solution link).

final class MyPsParticipationFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MyPsParticipation>, String> {
  MyPsParticipationFamily._()
    : super(
        retry: noRetry,
        name: r'myPsParticipationProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The learner's own interaction with it (status and solution link).

  MyPsParticipationProvider call(String id) =>
      MyPsParticipationProvider._(argument: id, from: this);

  @override
  String toString() => r'myPsParticipationProvider';
}

/// Try, leave, submit and withdraw: one notifier so the screen shows one
/// busy / error state. Each success refreshes the statement, the learner's
/// interaction, the participating list and the feeds (their counts).

@ProviderFor(PsActions)
final psActionsProvider = PsActionsProvider._();

/// Try, leave, submit and withdraw: one notifier so the screen shows one
/// busy / error state. Each success refreshes the statement, the learner's
/// interaction, the participating list and the feeds (their counts).
final class PsActionsProvider extends $AsyncNotifierProvider<PsActions, void> {
  /// Try, leave, submit and withdraw: one notifier so the screen shows one
  /// busy / error state. Each success refreshes the statement, the learner's
  /// interaction, the participating list and the feeds (their counts).
  PsActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'psActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$psActionsHash();

  @$internal
  @override
  PsActions create() => PsActions();
}

String _$psActionsHash() => r'57d1d99ee6c1ccc94710926c75c68b35de276ad4';

/// Try, leave, submit and withdraw: one notifier so the screen shows one
/// busy / error state. Each success refreshes the statement, the learner's
/// interaction, the participating list and the feeds (their counts).

abstract class _$PsActions extends $AsyncNotifier<void> {
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
