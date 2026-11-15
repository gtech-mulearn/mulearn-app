import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/weekly_twitches/data/weekly_twitches_data.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/repositories/weekly_twitches_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weekly_twitches_providers.g.dart';

@riverpod
WeeklyTwitchesRepository weeklyTwitchesRepository(Ref ref) =>
    WeeklyTwitchesRepositoryImpl(WeeklyTwitchesRemoteDataSource(ref.watch(dioProvider)));

/// Today's and upcoming episodes of [show], soonest first. A show announces
/// a handful a month, so one page of 50 covers it.
@Riverpod(retry: noRetry)
Future<List<TwitchEpisode>> twitchesComingUp(Ref ref, TwitchShow show) async {
  final page = await ref
      .watch(weeklyTwitchesRepositoryProvider)
      .episodes(show, statuses: {TwitchStatus.upcoming, TwitchStatus.ongoing}, perPage: 50);
  return [...page.items]..sort((a, b) => a.startsAt.compareTo(b.startsAt));
}

/// Past episodes of [show], newest first, page by page.
@Riverpod(retry: noRetry)
class TwitchesPast extends _$TwitchesPast {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<TwitchEpisode>> build(TwitchShow show) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(weeklyTwitchesRepositoryProvider).episodes(show, statuses: {TwitchStatus.completed});
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  /// Loads the next page (or retries it); concurrent calls share one request.
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref
          .read(weeklyTwitchesRepositoryProvider)
          .episodes(show, statuses: {TwitchStatus.completed}, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(
        PagedState(items: mergeUniqueBy(current.items, page.items, (e) => e.id), hasMore: page.hasNext),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more past episodes failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// One episode (from a notification or a list row).
@Riverpod(retry: noRetry)
Future<TwitchEpisode> twitchEpisode(Ref ref, TwitchShow show, String id) =>
    ref.watch(weeklyTwitchesRepositoryProvider).episode(show, id);
