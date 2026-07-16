import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/search/data/datasources/search_remote_datasource.dart';
import 'package:mulearn_app/features/search/data/repositories/search_repository_impl.dart';
import 'package:mulearn_app/features/search/domain/entities/user_search_result.dart';
import 'package:mulearn_app/features/search/domain/repositories/search_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_controller.g.dart';

@riverpod
SearchRemoteDataSource searchRemoteDataSource(Ref ref) =>
    SearchRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [SearchRepository] contract (rules.md §2/§5).
@riverpod
SearchRepository searchRepository(Ref ref) =>
    SearchRepositoryImpl(ref.watch(searchRemoteDataSourceProvider));

/// Accumulates search results across pages ("load more") for a given query
/// + role filter — matches the reference dashboard's infinite-scroll search
/// UX, adapted to Riverpod's `AsyncNotifier` pattern.
@riverpod
class SearchController extends _$SearchController {
  String _query = '';
  String? _role;
  int _pageIndex = 1;
  bool _hasMore = false;

  bool get hasMore => _hasMore;

  @override
  Future<List<UserSearchResult>> build() async => [];

  /// Starts a fresh search, replacing any existing results.
  Future<void> search(String query, {String? role}) async {
    _query = query;
    _role = role;
    _pageIndex = 1;
    if (query.trim().isEmpty) {
      _hasMore = false;
      state = const AsyncData([]);
      return;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final page = await ref
          .read(searchRepositoryProvider)
          .searchUsers(query: query, role: role, pageIndex: _pageIndex);
      _hasMore = page.hasMore;
      return page.results;
    });
  }

  /// Appends the next page of results for the current query/role.
  Future<void> loadMore() async {
    if (!_hasMore || _query.trim().isEmpty) return;
    final current = state.value ?? [];
    final nextPage = _pageIndex + 1;
    try {
      final page = await ref.read(searchRepositoryProvider).searchUsers(
            query: _query,
            role: _role,
            pageIndex: nextPage,
          );
      if (!ref.mounted) return;
      _pageIndex = nextPage;
      _hasMore = page.hasMore;
      state = AsyncData([...current, ...page.results]);
    } on Object catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
