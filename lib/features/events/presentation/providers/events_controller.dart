import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/events/data/datasources/events_remote_datasource.dart';
import 'package:mulearn_app/features/events/data/repositories/events_repository_impl.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/domain/repositories/events_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_controller.g.dart';

@riverpod
EventsRemoteDataSource eventsRemoteDataSource(Ref ref) =>
    EventsRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [EventsRepository] contract (rules.md §2/§5).
@riverpod
EventsRepository eventsRepository(Ref ref) =>
    EventsRepositoryImpl(ref.watch(eventsRemoteDataSourceProvider));

@riverpod
Future<Event> eventDetail(Ref ref, String id) =>
    ref.watch(eventsRepositoryProvider).getEventDetail(id);

/// Accumulates event pages across "load more", one list per [EventFilter]
/// (a new filter starts again at page 1). A failed page keeps the events
/// already shown and records the error for an inline retry.
@riverpod
class EventsListController extends _$EventsListController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<Event>> build(EventFilter filter) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(eventsRepositoryProvider).getEvents(pageIndex: 1, filter: filter);
    return PagedState(items: page.events, hasMore: page.hasNext);
  }

  /// Loads the next page, or retries it after a failure. Calls made while a
  /// page is in flight (a scroll listener firing every frame) share that one
  /// request.
  Future<void> loadMore() =>
      _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref.read(eventsRepositoryProvider).getEvents(pageIndex: next, filter: filter);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(PagedState(
        items: mergeUniqueBy(current.items, page.events, (e) => e.id),
        hasMore: page.hasNext,
      ));
    } on Object catch (e, st) {
      appLogger.w('Loading more events failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// Toggles interest for a single event, then invalidates the detail and
/// list providers so both reflect the new `viewerInterestStatus`.
@riverpod
class EventInterestController extends _$EventInterestController {
  @override
  Future<void> build() async {}

  Future<void> toggle(String eventId, {required bool interested}) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(() async {
      await ref
          .read(eventsRepositoryProvider)
          .setInterested(eventId, interested: interested);
      ref
        ..invalidate(eventDetailProvider(eventId))
        ..invalidate(eventsListControllerProvider);
    });
    if (ref.mounted) state = result;
  }
}
