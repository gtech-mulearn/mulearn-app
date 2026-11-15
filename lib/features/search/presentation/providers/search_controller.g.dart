// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchRemoteDataSource)
final searchRemoteDataSourceProvider = SearchRemoteDataSourceProvider._();

final class SearchRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          SearchRemoteDataSource,
          SearchRemoteDataSource,
          SearchRemoteDataSource
        >
    with $Provider<SearchRemoteDataSource> {
  SearchRemoteDataSourceProvider._()
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
final searchRepositoryProvider = SearchRepositoryProvider._();

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
  SearchRepositoryProvider._()
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

/// People (or, with `role: 'mentor'`, mentors) matching [query], page by
/// page; an empty query lists everyone, like the dashboard's search pages.
/// Each query is its own list, kept for a while once seen
/// ([KeepRecentResults]), so going back to a query or tab costs no request;
/// concurrent "load more" calls share one request.

@ProviderFor(UserSearch)
final userSearchProvider = UserSearchFamily._();

/// People (or, with `role: 'mentor'`, mentors) matching [query], page by
/// page; an empty query lists everyone, like the dashboard's search pages.
/// Each query is its own list, kept for a while once seen
/// ([KeepRecentResults]), so going back to a query or tab costs no request;
/// concurrent "load more" calls share one request.
final class UserSearchProvider
    extends $AsyncNotifierProvider<UserSearch, PagedState<UserSearchResult>> {
  /// People (or, with `role: 'mentor'`, mentors) matching [query], page by
  /// page; an empty query lists everyone, like the dashboard's search pages.
  /// Each query is its own list, kept for a while once seen
  /// ([KeepRecentResults]), so going back to a query or tab costs no request;
  /// concurrent "load more" calls share one request.
  UserSearchProvider._({
    required UserSearchFamily super.from,
    required (String, String?) super.argument,
  }) : super(
         retry: noRetry,
         name: r'userSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSearchHash();

  @override
  String toString() {
    return r'userSearchProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  UserSearch create() => UserSearch();

  @override
  bool operator ==(Object other) {
    return other is UserSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSearchHash() => r'92508238cebfc6a4ceb53cfed958c3225f1edcae';

/// People (or, with `role: 'mentor'`, mentors) matching [query], page by
/// page; an empty query lists everyone, like the dashboard's search pages.
/// Each query is its own list, kept for a while once seen
/// ([KeepRecentResults]), so going back to a query or tab costs no request;
/// concurrent "load more" calls share one request.

final class UserSearchFamily extends $Family
    with
        $ClassFamilyOverride<
          UserSearch,
          AsyncValue<PagedState<UserSearchResult>>,
          PagedState<UserSearchResult>,
          FutureOr<PagedState<UserSearchResult>>,
          (String, String?)
        > {
  UserSearchFamily._()
    : super(
        retry: noRetry,
        name: r'userSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// People (or, with `role: 'mentor'`, mentors) matching [query], page by
  /// page; an empty query lists everyone, like the dashboard's search pages.
  /// Each query is its own list, kept for a while once seen
  /// ([KeepRecentResults]), so going back to a query or tab costs no request;
  /// concurrent "load more" calls share one request.

  UserSearchProvider call(String query, String? role) =>
      UserSearchProvider._(argument: (query, role), from: this);

  @override
  String toString() => r'userSearchProvider';
}

/// People (or, with `role: 'mentor'`, mentors) matching [query], page by
/// page; an empty query lists everyone, like the dashboard's search pages.
/// Each query is its own list, kept for a while once seen
/// ([KeepRecentResults]), so going back to a query or tab costs no request;
/// concurrent "load more" calls share one request.

abstract class _$UserSearch
    extends $AsyncNotifier<PagedState<UserSearchResult>> {
  late final _$args = ref.$arg as (String, String?);
  String get query => _$args.$1;
  String? get role => _$args.$2;

  FutureOr<PagedState<UserSearchResult>> build(String query, String? role);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<UserSearchResult>>,
              PagedState<UserSearchResult>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<UserSearchResult>>,
                PagedState<UserSearchResult>
              >,
              AsyncValue<PagedState<UserSearchResult>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

/// Colleges and schools matching [query] (all of them when empty), page by
/// page, with the same caching as [UserSearch].

@ProviderFor(CampusSearch)
final campusSearchProvider = CampusSearchFamily._();

/// Colleges and schools matching [query] (all of them when empty), page by
/// page, with the same caching as [UserSearch].
final class CampusSearchProvider
    extends
        $AsyncNotifierProvider<CampusSearch, PagedState<CampusSearchResult>> {
  /// Colleges and schools matching [query] (all of them when empty), page by
  /// page, with the same caching as [UserSearch].
  CampusSearchProvider._({
    required CampusSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'campusSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$campusSearchHash();

  @override
  String toString() {
    return r'campusSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CampusSearch create() => CampusSearch();

  @override
  bool operator ==(Object other) {
    return other is CampusSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$campusSearchHash() => r'f0c040d363bc67a3651df5f74af9849ed9ef8bec';

/// Colleges and schools matching [query] (all of them when empty), page by
/// page, with the same caching as [UserSearch].

final class CampusSearchFamily extends $Family
    with
        $ClassFamilyOverride<
          CampusSearch,
          AsyncValue<PagedState<CampusSearchResult>>,
          PagedState<CampusSearchResult>,
          FutureOr<PagedState<CampusSearchResult>>,
          String
        > {
  CampusSearchFamily._()
    : super(
        retry: noRetry,
        name: r'campusSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Colleges and schools matching [query] (all of them when empty), page by
  /// page, with the same caching as [UserSearch].

  CampusSearchProvider call(String query) =>
      CampusSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'campusSearchProvider';
}

/// Colleges and schools matching [query] (all of them when empty), page by
/// page, with the same caching as [UserSearch].

abstract class _$CampusSearch
    extends $AsyncNotifier<PagedState<CampusSearchResult>> {
  late final _$args = ref.$arg as String;
  String get query => _$args;

  FutureOr<PagedState<CampusSearchResult>> build(String query);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<CampusSearchResult>>,
              PagedState<CampusSearchResult>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<CampusSearchResult>>,
                PagedState<CampusSearchResult>
              >,
              AsyncValue<PagedState<CampusSearchResult>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
