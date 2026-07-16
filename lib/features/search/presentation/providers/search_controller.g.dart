// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchRemoteDataSource)
const searchRemoteDataSourceProvider = SearchRemoteDataSourceProvider._();

final class SearchRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SearchRemoteDataSource,
          SearchRemoteDataSource,
          SearchRemoteDataSource
        >
    with $Provider<SearchRemoteDataSource> {
  const SearchRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<SearchRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchRemoteDataSource create(Ref ref) {
    return searchRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRemoteDataSource>(value),
    );
  }
}

String _$searchRemoteDataSourceHash() =>
    r'25327ee05e04411d5322eea245a1e853c9f065c6';

/// Presentation depends on the [SearchRepository] contract (rules.md §2/§5).

@ProviderFor(searchRepository)
const searchRepositoryProvider = SearchRepositoryProvider._();

/// Presentation depends on the [SearchRepository] contract (rules.md §2/§5).

final class SearchRepositoryProvider
    extends
        $FunctionalProvider<
          SearchRepository,
          SearchRepository,
          SearchRepository
        >
    with $Provider<SearchRepository> {
  /// Presentation depends on the [SearchRepository] contract (rules.md §2/§5).
  const SearchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SearchRepository create(Ref ref) {
    return searchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchRepository>(value),
    );
  }
}

String _$searchRepositoryHash() => r'f14ca810804bec88f67d6b2cffb39fb21c05544e';

/// Accumulates search results across pages ("load more") for a given query
/// + role filter — matches the reference dashboard's infinite-scroll search
/// UX, adapted to Riverpod's `AsyncNotifier` pattern.

@ProviderFor(SearchController)
const searchControllerProvider = SearchControllerProvider._();

/// Accumulates search results across pages ("load more") for a given query
/// + role filter — matches the reference dashboard's infinite-scroll search
/// UX, adapted to Riverpod's `AsyncNotifier` pattern.
final class SearchControllerProvider
    extends $AsyncNotifierProvider<SearchController, List<UserSearchResult>> {
  /// Accumulates search results across pages ("load more") for a given query
  /// + role filter — matches the reference dashboard's infinite-scroll search
  /// UX, adapted to Riverpod's `AsyncNotifier` pattern.
  const SearchControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchControllerHash();

  @$internal
  @override
  SearchController create() => SearchController();
}

String _$searchControllerHash() => r'1dbe1273b6ae4eb11d96569322eb076f44adf296';

/// Accumulates search results across pages ("load more") for a given query
/// + role filter — matches the reference dashboard's infinite-scroll search
/// UX, adapted to Riverpod's `AsyncNotifier` pattern.

abstract class _$SearchController
    extends $AsyncNotifier<List<UserSearchResult>> {
  FutureOr<List<UserSearchResult>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<UserSearchResult>>, List<UserSearchResult>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<UserSearchResult>>,
                List<UserSearchResult>
              >,
              AsyncValue<List<UserSearchResult>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
