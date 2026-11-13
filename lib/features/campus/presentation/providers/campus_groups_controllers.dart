import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/campus/data/campus_repository_provider.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_groups.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_groups_controllers.g.dart';

/// The campus's circles for a search, page by page.
@Riverpod(retry: noRetry)
class CampusCirclesController extends _$CampusCirclesController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<CampusCircle>> build(String search) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(campusRepositoryProvider).getCircles(pageIndex: 1, search: search);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  Future<void> loadMore() => _inFlight ??= _next().whenComplete(() => _inFlight = null);

  Future<void> _next() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    try {
      final page = await ref.read(campusRepositoryProvider).getCircles(pageIndex: _pageIndex + 1, search: search);
      if (!ref.mounted) return;
      _pageIndex++;
      state = AsyncData(PagedState(items: mergeUniqueBy(current.items, page.items, (c) => c.id), hasMore: page.hasNext));
    } on Object catch (e, st) {
      appLogger.w('Loading more circles failed', error: e, stackTrace: st);
      if (ref.mounted) state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// Interest groups for a search, page by page.
@Riverpod(retry: noRetry)
class CampusIgsController extends _$CampusIgsController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<CampusIg>> build(String search) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(campusRepositoryProvider).getIgs(pageIndex: 1, search: search);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  Future<void> loadMore() => _inFlight ??= _next().whenComplete(() => _inFlight = null);

  Future<void> _next() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    try {
      final page = await ref.read(campusRepositoryProvider).getIgs(pageIndex: _pageIndex + 1, search: search);
      if (!ref.mounted) return;
      _pageIndex++;
      state = AsyncData(PagedState(items: mergeUniqueBy(current.items, page.items, (g) => g.id), hasMore: page.hasNext));
    } on Object catch (e, st) {
      appLogger.w('Loading more groups failed', error: e, stackTrace: st);
      if (ref.mounted) state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}
