import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/models/event_organizer.dart';
import 'package:mulearn_app/core/models/event_venue.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/domain/entities/event_page.dart';
import 'package:mulearn_app/features/events/domain/repositories/events_repository.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';

class MockEventsRepository extends Mock implements EventsRepository {}

Event event(String id) => Event(
      id: id,
      title: 'Event $id',
      slug: 'event-$id',
      status: 'published',
      eventScope: 'coder',
      eventType: 'workshop',
      startDatetime: '2026-11-20T10:00:00Z',
      endDatetime: '2026-11-20T12:00:00Z',
      venue: const EventVenue(venueType: 'online'),
      organizer: const EventOrganizer(organiserType: 'admin'),
      isFeatured: false,
      isCollaboration: false,
      interestCount: 0,
      viewerInterestStatus: 'none',
    );

EventPage page(List<String> ids, {required bool hasNext}) =>
    EventPage(events: ids.map(event).toList(), hasNext: hasNext, totalPages: 2);

void main() {
  late MockEventsRepository repo;

  setUp(() => repo = MockEventsRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [eventsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    container.listen(eventsListControllerProvider(const EventFilter()), (_, __) {});
    return container;
  }

  List<String> ids(ProviderContainer c) =>
      c.read(eventsListControllerProvider(const EventFilter())).requireValue.items.map((e) => e.id).toList();

  test('build loads page 1', () async {
    when(() => repo.getEvents(pageIndex: 1))
        .thenAnswer((_) async => page(['a', 'b'], hasNext: true));
    final c = makeContainer();

    final state = await c.read(eventsListControllerProvider(const EventFilter()).future);

    expect(state.items.map((e) => e.id), ['a', 'b']);
    expect(state.hasMore, isTrue);
    verify(() => repo.getEvents(pageIndex: 1)).called(1);
  });

  test('loadMore appends page 2 without duplicates', () async {
    when(() => repo.getEvents(pageIndex: 1))
        .thenAnswer((_) async => page(['a', 'b'], hasNext: true));
    when(() => repo.getEvents(pageIndex: 2))
        .thenAnswer((_) async => page(['b', 'c'], hasNext: false));
    final c = makeContainer();
    await c.read(eventsListControllerProvider(const EventFilter()).future);

    await c.read(eventsListControllerProvider(const EventFilter()).notifier).loadMore();

    expect(ids(c), ['a', 'b', 'c']);
    expect(c.read(eventsListControllerProvider(const EventFilter())).requireValue.hasMore, isFalse);
  });

  test('loadMore error keeps items and a retry asks for the same page', () async {
    when(() => repo.getEvents(pageIndex: 1))
        .thenAnswer((_) async => page(['a', 'b'], hasNext: true));
    when(() => repo.getEvents(pageIndex: 2)).thenThrow(Exception('offline'));
    final c = makeContainer();
    await c.read(eventsListControllerProvider(const EventFilter()).future);

    await c.read(eventsListControllerProvider(const EventFilter()).notifier).loadMore();

    final state = c.read(eventsListControllerProvider(const EventFilter())).requireValue;
    expect(state.items.map((e) => e.id), ['a', 'b']);
    expect(state.loadMoreError, isNotNull);
    expect(state.isLoadingMore, isFalse);
    expect(state.hasMore, isTrue);

    await c.read(eventsListControllerProvider(const EventFilter()).notifier).loadMore();
    verify(() => repo.getEvents(pageIndex: 2)).called(2);
  });

  test('concurrent loadMore issues one request', () async {
    final pending = Completer<EventPage>();
    when(() => repo.getEvents(pageIndex: 1))
        .thenAnswer((_) async => page(['a'], hasNext: true));
    when(() => repo.getEvents(pageIndex: 2)).thenAnswer((_) => pending.future);
    final c = makeContainer();
    await c.read(eventsListControllerProvider(const EventFilter()).future);

    final notifier = c.read(eventsListControllerProvider(const EventFilter()).notifier);
    final first = notifier.loadMore();
    final second = notifier.loadMore();
    expect(c.read(eventsListControllerProvider(const EventFilter())).requireValue.isLoadingMore, isTrue);
    pending.complete(page(['b'], hasNext: false));
    await Future.wait([first, second]);

    verify(() => repo.getEvents(pageIndex: 2)).called(1);
    expect(ids(c), ['a', 'b']);
  });

  test('empty first page shows no items and requests nothing more', () async {
    when(() => repo.getEvents(pageIndex: 1))
        .thenAnswer((_) async => const EventPage(events: [], hasNext: false, totalPages: 1));
    final c = makeContainer();
    await c.read(eventsListControllerProvider(const EventFilter()).future);

    await c.read(eventsListControllerProvider(const EventFilter()).notifier).loadMore();

    expect(ids(c), isEmpty);
    expect(c.read(eventsListControllerProvider(const EventFilter())).requireValue.hasMore, isFalse);
    verifyNever(() => repo.getEvents(pageIndex: 2));
  });
}
