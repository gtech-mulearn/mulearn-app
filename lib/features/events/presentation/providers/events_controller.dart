import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/events/data/datasources/events_remote_datasource.dart';
import 'package:mulearn_app/features/events/data/repositories/events_repository_impl.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
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

/// Accumulates event pages across "load more" — mirrors [SearchController]'s
/// infinite-scroll pattern.
@riverpod
class EventsListController extends _$EventsListController {
  int _page = 1;
  bool _hasMore = false;
  bool _loadingMore = false;

  bool get hasMore => _hasMore;

  @override
  Future<List<Event>> build() async {
    _page = 1;
    _loadingMore = false;
    final page = await ref.watch(eventsRepositoryProvider).getEvents();
    _hasMore = page.hasNext;
    return page.events;
  }

  Future<void> loadMore() async {
    // Guards against a scroll listener re-firing (e.g. near-bottom on every
    // frame for a short list) before the in-flight page request settles,
    // which would otherwise dispatch the same page repeatedly.
    if (!_hasMore || _loadingMore) return;
    _loadingMore = true;
    final current = state.value ?? [];
    final nextPage = _page + 1;
    try {
      final page = await ref
          .read(eventsRepositoryProvider)
          .getEvents(page: nextPage);
      if (!ref.mounted) return;
      _page = nextPage;
      _hasMore = page.hasNext;
      state = AsyncData([...current, ...page.events]);
    } on Object catch (e, st) {
      state = AsyncError(e, st);
    } finally {
      _loadingMore = false;
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
    state = await AsyncValue.guard(() async {
      await ref
          .read(eventsRepositoryProvider)
          .setInterested(eventId, interested: interested);
      ref
        ..invalidate(eventDetailProvider(eventId))
        ..invalidate(eventsListControllerProvider);
    });
  }
}
