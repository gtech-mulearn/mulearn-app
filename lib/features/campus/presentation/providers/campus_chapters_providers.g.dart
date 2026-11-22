// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_chapters_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(campusChaptersRepository)
final campusChaptersRepositoryProvider = CampusChaptersRepositoryProvider._();

final class CampusChaptersRepositoryProvider
    extends
        $FunctionalProvider<
          CampusChaptersRepository,
          CampusChaptersRepository,
          CampusChaptersRepository
        >
    with $Provider<CampusChaptersRepository> {
  CampusChaptersRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campusChaptersRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusChaptersRepositoryHash();

  @$internal
  @override
  $ProviderElement<CampusChaptersRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CampusChaptersRepository create(Ref ref) {
    return campusChaptersRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampusChaptersRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampusChaptersRepository>(value),
    );
  }
}

String _$campusChaptersRepositoryHash() =>
    r'079b6feb2d346b535563d39ec9acd95e7ad022c1';

/// The campus's IG chapters, active first, most members first.

@ProviderFor(campusChapters)
final campusChaptersProvider = CampusChaptersProvider._();

/// The campus's IG chapters, active first, most members first.

final class CampusChaptersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CampusChapter>>,
          List<CampusChapter>,
          FutureOr<List<CampusChapter>>
        >
    with
        $FutureModifier<List<CampusChapter>>,
        $FutureProvider<List<CampusChapter>> {
  /// The campus's IG chapters, active first, most members first.
  CampusChaptersProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'campusChaptersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusChaptersHash();

  @$internal
  @override
  $FutureProviderElement<List<CampusChapter>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CampusChapter>> create(Ref ref) {
    return campusChapters(ref);
  }
}

String _$campusChaptersHash() => r'867b0fd5eaefc96ad359d0d00c44c31600754d45';

/// Campus members matching [query] (two letters or more), to pick a lead.
/// Each query is kept a while, so retyping costs no request.

@ProviderFor(campusMemberSearch)
final campusMemberSearchProvider = CampusMemberSearchFamily._();

/// Campus members matching [query] (two letters or more), to pick a lead.
/// Each query is kept a while, so retyping costs no request.

final class CampusMemberSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CampusMember>>,
          List<CampusMember>,
          FutureOr<List<CampusMember>>
        >
    with
        $FutureModifier<List<CampusMember>>,
        $FutureProvider<List<CampusMember>> {
  /// Campus members matching [query] (two letters or more), to pick a lead.
  /// Each query is kept a while, so retyping costs no request.
  CampusMemberSearchProvider._({
    required CampusMemberSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusMemberSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusMemberSearchHash();

  @override
  String toString() {
    return r'campusMemberSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CampusMember>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CampusMember>> create(Ref ref) {
    final argument = this.argument as String;
    return campusMemberSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CampusMemberSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusMemberSearchHash() =>
    r'7ad1d78b8962c3d53301c07630171689be0ded7e';

/// Campus members matching [query] (two letters or more), to pick a lead.
/// Each query is kept a while, so retyping costs no request.

final class CampusMemberSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CampusMember>>, String> {
  CampusMemberSearchFamily._()
    : super(
        retry: noRetry,
        name: r'campusMemberSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Campus members matching [query] (two letters or more), to pick a lead.
  /// Each query is kept a while, so retyping costs no request.

  CampusMemberSearchProvider call(String query) =>
      CampusMemberSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'campusMemberSearchProvider';
}

/// μLearn's interest groups, to start a chapter for.

@ProviderFor(chapterIgOptions)
final chapterIgOptionsProvider = ChapterIgOptionsProvider._();

/// μLearn's interest groups, to start a chapter for.

final class ChapterIgOptionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChapterIgOption>>,
          List<ChapterIgOption>,
          FutureOr<List<ChapterIgOption>>
        >
    with
        $FutureModifier<List<ChapterIgOption>>,
        $FutureProvider<List<ChapterIgOption>> {
  /// μLearn's interest groups, to start a chapter for.
  ChapterIgOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'chapterIgOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chapterIgOptionsHash();

  @$internal
  @override
  $FutureProviderElement<List<ChapterIgOption>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ChapterIgOption>> create(Ref ref) {
    return chapterIgOptions(ref);
  }
}

String _$chapterIgOptionsHash() => r'047e1497317ab110855a35e4be335fd756c2daf7';

/// Create, edit and remove: one notifier for one busy / error state. Each
/// success refreshes the chapters. Returns the backend's message, or null on
/// failure (the error is in [state]).

@ProviderFor(CampusChapterActions)
final campusChapterActionsProvider = CampusChapterActionsProvider._();

/// Create, edit and remove: one notifier for one busy / error state. Each
/// success refreshes the chapters. Returns the backend's message, or null on
/// failure (the error is in [state]).
final class CampusChapterActionsProvider
    extends $AsyncNotifierProvider<CampusChapterActions, void> {
  /// Create, edit and remove: one notifier for one busy / error state. Each
  /// success refreshes the chapters. Returns the backend's message, or null on
  /// failure (the error is in [state]).
  CampusChapterActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campusChapterActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusChapterActionsHash();

  @$internal
  @override
  CampusChapterActions create() => CampusChapterActions();
}

String _$campusChapterActionsHash() =>
    r'37bd95a9ce7cc23cd37fdbf55999f32fca055795';

/// Create, edit and remove: one notifier for one busy / error state. Each
/// success refreshes the chapters. Returns the backend's message, or null on
/// failure (the error is in [state]).

abstract class _$CampusChapterActions extends $AsyncNotifier<void> {
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
