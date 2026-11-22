// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_applications_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mentorApplicationsRepository)
final mentorApplicationsRepositoryProvider =
    MentorApplicationsRepositoryProvider._();

final class MentorApplicationsRepositoryProvider
    extends
        $FunctionalProvider<
          MentorApplicationsRepository,
          MentorApplicationsRepository,
          MentorApplicationsRepository
        >
    with $Provider<MentorApplicationsRepository> {
  MentorApplicationsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorApplicationsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorApplicationsRepositoryHash();

  @$internal
  @override
  $ProviderElement<MentorApplicationsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MentorApplicationsRepository create(Ref ref) {
    return mentorApplicationsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MentorApplicationsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MentorApplicationsRepository>(value),
    );
  }
}

String _$mentorApplicationsRepositoryHash() =>
    r'da939ea2e6822263f256a4c65dadf57b7e3e97bc';

/// The answers to fill the form with (null before the first application).

@ProviderFor(mentorProfileSnapshot)
final mentorProfileSnapshotProvider = MentorProfileSnapshotProvider._();

/// The answers to fill the form with (null before the first application).

final class MentorProfileSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<MentorProfileSnapshot?>,
          MentorProfileSnapshot?,
          FutureOr<MentorProfileSnapshot?>
        >
    with
        $FutureModifier<MentorProfileSnapshot?>,
        $FutureProvider<MentorProfileSnapshot?> {
  /// The answers to fill the form with (null before the first application).
  MentorProfileSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorProfileSnapshotProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorProfileSnapshotHash();

  @$internal
  @override
  $FutureProviderElement<MentorProfileSnapshot?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MentorProfileSnapshot?> create(Ref ref) {
    return mentorProfileSnapshot(ref);
  }
}

String _$mentorProfileSnapshotHash() =>
    r'da9d2ca890d58852b46a208280b14f0182a608f9';

/// Every Interest Group, for "which will you mentor?".

@ProviderFor(mentorIgChoices)
final mentorIgChoicesProvider = MentorIgChoicesProvider._();

/// Every Interest Group, for "which will you mentor?".

final class MentorIgChoicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorChoice>>,
          List<MentorChoice>,
          FutureOr<List<MentorChoice>>
        >
    with
        $FutureModifier<List<MentorChoice>>,
        $FutureProvider<List<MentorChoice>> {
  /// Every Interest Group, for "which will you mentor?".
  MentorIgChoicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorIgChoicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorIgChoicesHash();

  @$internal
  @override
  $FutureProviderElement<List<MentorChoice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorChoice>> create(Ref ref) {
    return mentorIgChoices(ref);
  }
}

String _$mentorIgChoicesHash() => r'70b9daf551eda95ae511358b0d3dfedcc4ae6ac2';

/// Companies a Company Mentor can apply from.

@ProviderFor(mentorCompanyChoices)
final mentorCompanyChoicesProvider = MentorCompanyChoicesProvider._();

/// Companies a Company Mentor can apply from.

final class MentorCompanyChoicesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorChoice>>,
          List<MentorChoice>,
          FutureOr<List<MentorChoice>>
        >
    with
        $FutureModifier<List<MentorChoice>>,
        $FutureProvider<List<MentorChoice>> {
  /// Companies a Company Mentor can apply from.
  MentorCompanyChoicesProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorCompanyChoicesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorCompanyChoicesHash();

  @$internal
  @override
  $FutureProviderElement<List<MentorChoice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorChoice>> create(Ref ref) {
    return mentorCompanyChoices(ref);
  }
}

String _$mentorCompanyChoicesHash() =>
    r'acc6c167539ab01efdef6d1808f8dfd915b2bcf5';

/// Colleges matching [query] (2+ characters), kept briefly so going back
/// over a search doesn't ask again.

@ProviderFor(mentorCollegeSearch)
final mentorCollegeSearchProvider = MentorCollegeSearchFamily._();

/// Colleges matching [query] (2+ characters), kept briefly so going back
/// over a search doesn't ask again.

final class MentorCollegeSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<MentorChoice>>,
          List<MentorChoice>,
          FutureOr<List<MentorChoice>>
        >
    with
        $FutureModifier<List<MentorChoice>>,
        $FutureProvider<List<MentorChoice>> {
  /// Colleges matching [query] (2+ characters), kept briefly so going back
  /// over a search doesn't ask again.
  MentorCollegeSearchProvider._({
    required MentorCollegeSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'mentorCollegeSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mentorCollegeSearchHash();

  @override
  String toString() {
    return r'mentorCollegeSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<MentorChoice>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<MentorChoice>> create(Ref ref) {
    final argument = this.argument as String;
    return mentorCollegeSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MentorCollegeSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mentorCollegeSearchHash() =>
    r'17351e1462fee1e12348bccfefb4d6ebd47af3b4';

/// Colleges matching [query] (2+ characters), kept briefly so going back
/// over a search doesn't ask again.

final class MentorCollegeSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<MentorChoice>>, String> {
  MentorCollegeSearchFamily._()
    : super(
        retry: noRetry,
        name: r'mentorCollegeSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Colleges matching [query] (2+ characters), kept briefly so going back
  /// over a search doesn't ask again.

  MentorCollegeSearchProvider call(String query) =>
      MentorCollegeSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'mentorCollegeSearchProvider';
}

/// Sends or edits an application, then refreshes the session's list (which
/// drives the home tile and the applications screen).

@ProviderFor(MentorApplicationSender)
final mentorApplicationSenderProvider = MentorApplicationSenderProvider._();

/// Sends or edits an application, then refreshes the session's list (which
/// drives the home tile and the applications screen).
final class MentorApplicationSenderProvider
    extends $AsyncNotifierProvider<MentorApplicationSender, void> {
  /// Sends or edits an application, then refreshes the session's list (which
  /// drives the home tile and the applications screen).
  MentorApplicationSenderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorApplicationSenderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorApplicationSenderHash();

  @$internal
  @override
  MentorApplicationSender create() => MentorApplicationSender();
}

String _$mentorApplicationSenderHash() =>
    r'fdee902f2d928645a2154be6eaaa459cf4934641';

/// Sends or edits an application, then refreshes the session's list (which
/// drives the home tile and the applications screen).

abstract class _$MentorApplicationSender extends $AsyncNotifier<void> {
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
