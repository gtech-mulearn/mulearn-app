import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
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

/// One page size for every search list, as on the dashboard.
const searchPerPage = 30;

/// People (or, with `role: 'mentor'`, mentors) matching [query], page by
/// page; an empty query lists everyone, like the dashboard's search pages.
/// Each query is its own list, kept for a while once seen
/// ([KeepRecentResults]), so going back to a query or tab costs no request;
/// concurrent "load more" calls share one request.
@Riverpod(retry: noRetry)
class UserSearch extends _$UserSearch {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<UserSearchResult>> build(String query, String? role) async {
    ref.keepRecent();
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(searchRepositoryProvider).searchUsers(query: query, role: role);
    return PagedState(items: page.results, hasMore: page.hasMore);
  }

  /// Loads the next page (or retries it).
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref.read(searchRepositoryProvider).searchUsers(query: query, role: role, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(
        PagedState(items: mergeUniqueBy(current.items, page.results, (u) => u.muid), hasMore: page.hasMore),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more people failed', error: e, stackTrace: st);
      if (ref.mounted) state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// Colleges and schools matching [query] (all of them when empty), page by
/// page, with the same caching as [UserSearch].
@Riverpod(retry: noRetry)
class CampusSearch extends _$CampusSearch {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<CampusSearchResult>> build(String query) async {
    ref.keepRecent();
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(searchRepositoryProvider).searchCampuses(query: query, perPage: searchPerPage);
    return PagedState(items: page.results, hasMore: page.hasMore);
  }

  /// Loads the next page (or retries it).
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref
          .read(searchRepositoryProvider)
          .searchCampuses(query: query, pageIndex: next, perPage: searchPerPage);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(
        PagedState(
          items: mergeUniqueBy(current.items, page.results, (c) => '${c.isSchool}-${c.id}'),
          hasMore: page.hasMore,
        ),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more campuses failed', error: e, stackTrace: st);
      if (ref.mounted) state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}
