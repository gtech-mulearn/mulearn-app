// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enabler_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(enablerRepository)
const enablerRepositoryProvider = EnablerRepositoryProvider._();

final class EnablerRepositoryProvider
    extends
        $FunctionalProvider<
          EnablerRepository,
          EnablerRepository,
          EnablerRepository
        >
    with $Provider<EnablerRepository> {
  const EnablerRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'enablerRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enablerRepositoryHash();

  @$internal
  @override
  $ProviderElement<EnablerRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EnablerRepository create(Ref ref) {
    return enablerRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EnablerRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EnablerRepository>(value),
    );
  }
}

String _$enablerRepositoryHash() => r'a854187f755eb90a0b05a81ce09c6f3fd44ea803';

@ProviderFor(enablerSummary)
const enablerSummaryProvider = EnablerSummaryProvider._();

final class EnablerSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<EnablerSummary>,
          EnablerSummary,
          FutureOr<EnablerSummary>
        >
    with $FutureModifier<EnablerSummary>, $FutureProvider<EnablerSummary> {
  const EnablerSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'enablerSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enablerSummaryHash();

  @$internal
  @override
  $FutureProviderElement<EnablerSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EnablerSummary> create(Ref ref) {
    return enablerSummary(ref);
  }
}

String _$enablerSummaryHash() => r'a86d706c96eab90a9713b9f57e73d90197fa4af3';

@ProviderFor(enablerCampuses)
const enablerCampusesProvider = EnablerCampusesProvider._();

final class EnablerCampusesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EnablerCampus>>,
          List<EnablerCampus>,
          FutureOr<List<EnablerCampus>>
        >
    with
        $FutureModifier<List<EnablerCampus>>,
        $FutureProvider<List<EnablerCampus>> {
  const EnablerCampusesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'enablerCampusesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$enablerCampusesHash();

  @$internal
  @override
  $FutureProviderElement<List<EnablerCampus>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EnablerCampus>> create(Ref ref) {
    return enablerCampuses(ref);
  }
}

String _$enablerCampusesHash() => r'c487d789d29d89ece2fc5f45bc50d44c0c3bd436';

@ProviderFor(enablerCampus)
const enablerCampusProvider = EnablerCampusFamily._();

final class EnablerCampusProvider
    extends
        $FunctionalProvider<
          AsyncValue<EnablerCampus>,
          EnablerCampus,
          FutureOr<EnablerCampus>
        >
    with $FutureModifier<EnablerCampus>, $FutureProvider<EnablerCampus> {
  const EnablerCampusProvider._({
    required EnablerCampusFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'enablerCampusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$enablerCampusHash();

  @override
  String toString() {
    return r'enablerCampusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<EnablerCampus> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EnablerCampus> create(Ref ref) {
    final argument = this.argument as String;
    return enablerCampus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is EnablerCampusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$enablerCampusHash() => r'acf65c4fe66acae8d78d3019ab629300cf11b587';

final class EnablerCampusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<EnablerCampus>, String> {
  const EnablerCampusFamily._()
    : super(
        retry: noRetry,
        name: r'enablerCampusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  EnablerCampusProvider call(String id) =>
      EnablerCampusProvider._(argument: id, from: this);

  @override
  String toString() => r'enablerCampusProvider';
}

/// A campus's notes; [add] saves one and reloads the list (the backend
/// returns only a message).

@ProviderFor(CampusNotesController)
const campusNotesControllerProvider = CampusNotesControllerFamily._();

/// A campus's notes; [add] saves one and reloads the list (the backend
/// returns only a message).
final class CampusNotesControllerProvider
    extends $AsyncNotifierProvider<CampusNotesController, List<CampusNote>> {
  /// A campus's notes; [add] saves one and reloads the list (the backend
  /// returns only a message).
  const CampusNotesControllerProvider._({
    required CampusNotesControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusNotesControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusNotesControllerHash();

  @override
  String toString() {
    return r'campusNotesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampusNotesController create() => CampusNotesController();

  @override
  bool operator ==(Object other) {
    return other is CampusNotesControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusNotesControllerHash() =>
    r'b6dfa00e07ff20b1833c48c3a2994911276a14aa';

/// A campus's notes; [add] saves one and reloads the list (the backend
/// returns only a message).

final class CampusNotesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          CampusNotesController,
          AsyncValue<List<CampusNote>>,
          List<CampusNote>,
          FutureOr<List<CampusNote>>,
          String
        > {
  const CampusNotesControllerFamily._()
    : super(
        retry: noRetry,
        name: r'campusNotesControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A campus's notes; [add] saves one and reloads the list (the backend
  /// returns only a message).

  CampusNotesControllerProvider call(String campusId) =>
      CampusNotesControllerProvider._(argument: campusId, from: this);

  @override
  String toString() => r'campusNotesControllerProvider';
}

/// A campus's notes; [add] saves one and reloads the list (the backend
/// returns only a message).

abstract class _$CampusNotesController
    extends $AsyncNotifier<List<CampusNote>> {
  late final _$args = ref.$arg as String;
  String get campusId => _$args;

  FutureOr<List<CampusNote>> build(String campusId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<List<CampusNote>>, List<CampusNote>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CampusNote>>, List<CampusNote>>,
              AsyncValue<List<CampusNote>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
