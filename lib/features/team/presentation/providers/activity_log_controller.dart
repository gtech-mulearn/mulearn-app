import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'activity_log_controller.g.dart';

/// The team activity log, page by page, for one [action] filter (`null` is
/// every action). Loads on open, on pull-to-refresh and on scroll-to-end;
/// nothing polls.
@Riverpod(retry: noRetry)
class ActivityLogController extends _$ActivityLogController {
  int _page = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<ActivityEntry>> build(String? action) async {
    _page = 1;
    _inFlight = null;
    final page = await ref
        .watch(teamRepositoryProvider)
        .activity(1, action: action);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  /// Refetches page 1. On failure the loaded items stay and the error is
  /// rethrown (pull-to-refresh shows it as a toast).
  Future<void> refresh() async {
    final page = await ref
        .read(teamRepositoryProvider)
        .activity(1, action: action);
    if (!ref.mounted) return;
    _page = 1;
    state = AsyncData(PagedState(items: page.items, hasMore: page.hasNext));
  }

  /// Loads the next page, or retries it after a failure. Calls made while a
  /// page is in flight share that request.
  Future<void> loadMore() =>
      _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(
      current.copyWith(isLoadingMore: true, loadMoreError: null),
    );
    final next = _page + 1;
    try {
      final page = await ref
          .read(teamRepositoryProvider)
          .activity(next, action: action);
      if (!ref.mounted) return;
      _page = next;
      state = AsyncData(
        PagedState(
          items: mergeUniqueBy(current.items, page.items, (e) => e.id),
          hasMore: page.hasNext,
        ),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more activity failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(
        current.copyWith(isLoadingMore: false, loadMoreError: e),
      );
    }
  }
}
