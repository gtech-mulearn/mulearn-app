import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/recent_results.dart';
import 'package:mulearn_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:mulearn_app/features/search/data/repositories/search_repository_impl.dart';
import 'package:mulearn_app/features/search/domain/entities/campus_search_result.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';
import 'package:mulearn_app/features/search/domain/repositories/search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

@riverpod
SearchRemoteDataSource searchRemoteDataSource(Ref ref) => SearchRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [SearchRepository] contract (rules.md §2/§5).
@riverpod
SearchRepository searchRepository(Ref ref) => SearchRepositoryImpl(ref.watch(searchRemoteDataSourceProvider));

/// Results already fetched for a query, so going back to it (backspacing,
/// switching People / Mentors / Campuses) needs no request. Holds the newest
/// [_max] queries for [recentResultsTtl].
class _RecentPages<T> {
  static const _max = 12;
  final _hits = <String, ({List<T> results, int page, bool hasMore, DateTime at})>{};

  ({List<T> results, int page, bool hasMore, DateTime at})? fresh(String key) {
    final hit = _hits[key];
    if (hit == null || DateTime.now().difference(hit.at) > recentResultsTtl) return null;
    return hit;
  }

  void put(String key, List<T> results, int page, {required bool hasMore}) {
    _hits
      ..remove(key)
      ..[key] = (results: results, page: page, hasMore: hasMore, at: DateTime.now());
    if (_hits.length > _max) _hits.remove(_hits.keys.first);
  }
}

/// Accumulates search results across pages ("load more") for a given query
/// + role filter, like the dashboard's infinite-scroll search. Each search
/// supersedes the one before: a slower, older answer never replaces a newer
/// one, and concurrent "load more" calls share one request.
@riverpod
class SearchController extends _$SearchController {
  final _recent = _RecentPages<UserSearchResult>();
  String _query = '';
  String? _role;
  int _pageIndex = 1;
  bool _hasMore = false;
  int _seq = 0;
  Future<void>? _inFlight;

  bool get hasMore => _hasMore;

  String get _key => '${_role ?? ''}|${_query.toLowerCase()}';

  @override
  Future<List<UserSearchResult>> build() async => [];

  /// Starts a fresh search, replacing any existing results.
  Future<void> search(String query, {String? role}) async {
    final seq = ++_seq;
    _inFlight = null;
    _query = query.trim();
    _role = role;
    _pageIndex = 1;
    _hasMore = false;
    if (_query.isEmpty) {
      state = const AsyncData([]);
      return;
    }
    final hit = _recent.fresh(_key);
    if (hit != null) {
      _pageIndex = hit.page;
      _hasMore = hit.hasMore;
      state = AsyncData(hit.results);
      return;
    }
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(searchRepositoryProvider).searchUsers(query: _query, role: role),
    );
    if (!ref.mounted || seq != _seq) return;
    final page = result.value;
    if (page != null) {
      _hasMore = page.hasMore;
      _recent.put(_key, page.results, 1, hasMore: page.hasMore);
    }
    state = result.whenData((p) => p.results);
  }

  /// Appends the next page of results for the current query/role.
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    if (!_hasMore || _query.isEmpty) return;
    final seq = _seq;
    final current = state.value ?? [];
    final nextPage = _pageIndex + 1;
    try {
      final page = await ref
          .read(searchRepositoryProvider)
          .searchUsers(query: _query, role: _role, pageIndex: nextPage);
      if (!ref.mounted || seq != _seq) return;
      _pageIndex = nextPage;
      _hasMore = page.hasMore;
      final all = [...current, ...page.results];
      _recent.put(_key, all, nextPage, hasMore: page.hasMore);
      state = AsyncData(all);
    } on Object catch (e, st) {
      if (ref.mounted && seq == _seq) state = AsyncError(e, st);
    }
  }
}

/// Campus search (colleges and schools), page by page ("load more"), with
/// the same superseding and recent-results rules as [SearchController].
@riverpod
class CampusSearchController extends _$CampusSearchController {
  final _recent = _RecentPages<CampusSearchResult>();
  String _query = '';
  int _pageIndex = 1;
  bool _hasMore = false;
  int _seq = 0;
  Future<void>? _inFlight;

  bool get hasMore => _hasMore;

  @override
  Future<List<CampusSearchResult>> build() async => [];

  /// Starts a fresh search, replacing any results.
  Future<void> search(String query) async {
    final seq = ++_seq;
    _inFlight = null;
    _query = query.trim();
    _pageIndex = 1;
    _hasMore = false;
    if (_query.isEmpty) {
      state = const AsyncData([]);
      return;
    }
    final key = _query.toLowerCase();
    final hit = _recent.fresh(key);
    if (hit != null) {
      _pageIndex = hit.page;
      _hasMore = hit.hasMore;
      state = AsyncData(hit.results);
      return;
    }
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() => ref.read(searchRepositoryProvider).searchCampuses(query: _query));
    if (!ref.mounted || seq != _seq) return;
    final page = result.value;
    if (page != null) {
      _hasMore = page.hasMore;
      _recent.put(key, page.results, 1, hasMore: page.hasMore);
    }
    state = result.whenData((p) => p.results);
  }

  /// Appends the next page for the current query.
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    if (!_hasMore || _query.isEmpty) return;
    final seq = _seq;
    final current = state.value ?? [];
    final next = _pageIndex + 1;
    try {
      final page = await ref.read(searchRepositoryProvider).searchCampuses(query: _query, pageIndex: next);
      if (!ref.mounted || seq != _seq) return;
      _pageIndex = next;
      _hasMore = page.hasMore;
      final all = mergeUniqueBy(current, page.results, (c) => '${c.isSchool}-${c.id}');
      _recent.put(_query.toLowerCase(), all, next, hasMore: page.hasMore);
      state = AsyncData(all);
    } on Object catch (e, st) {
      if (ref.mounted && seq == _seq) state = AsyncError(e, st);
    }
  }
}
