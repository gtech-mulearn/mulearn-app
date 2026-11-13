import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';
import 'package:mulearn_app/features/events/presentation/screens/events_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'events_test_support.dart';

const _events = '/api/v1/dashboard/events/';

/// L14 — EventListAPI (_public_events_queryset, events/public_views.py):
/// search, event_type, ig_id, start_date (YYYY-MM-DD), eligible_only=true.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_events': (o) => FakeResponse(
            200,
            loadFixture(o.queryParameters.length > 2 ? 'dev/events_filtered' : 'dev/events_page1'),
          ),
      'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
    });
  });

  List<Map<String, dynamic>> queries() => [
        for (final r in adapter.requests)
          if (r.uri.path == _events) Map.of(r.queryParameters),
      ];

  test('only the filters that are set are sent', () {
    expect(const EventFilter().query, isEmpty);
    expect(
      EventFilter(search: ' git ', eventType: 'workshop', igId: 'ig1', from: DateTime(2026, 11, 5), eligibleOnly: true).query,
      {'search': 'git', 'event_type': 'workshop', 'ig_id': 'ig1', 'start_date': '2026-11-05', 'eligible_only': 'true'},
    );
  });

  test('the list asks for page 1 of the filtered events', () async {
    final c = await eventsContainer(adapter);
    const f = EventFilter(eventType: 'workshop', eligibleOnly: true);
    c.listen(eventsListControllerProvider(f), (_, __) {});

    final page = await c.read(eventsListControllerProvider(f).future);

    expect(queries().single, {'pageIndex': 1, 'perPage': 20, 'event_type': 'workshop', 'eligible_only': 'true'});
    expect(page.items, isNotEmpty);
  });

  test('every backend event type has a label', () {
    expect(eventTypeLabels.keys, containsAll(['hackathon', 'workshop', 'networking_event', 'cultural_event']));
    expect(eventTypeLabels['networking_event'], 'Networking Event');
    expect(eventTypeLabels, hasLength(14));
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    final c = await eventsContainer(adapter);
    await tester.pumpWidget(UncontrolledProviderScope(container: c, child: const MaterialApp(home: EventsScreen())));
    await settle(tester);
  }

  testWidgets('typing searches once, after a pause', (tester) async {
    await pumpScreen(tester);
    final before = queries().length;

    await tester.enterText(find.byType(TextField), 'gi');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'git');
    await tester.pump(const Duration(milliseconds: 350));
    await settle(tester);

    final after = queries().skip(before).toList();
    expect(after, hasLength(1));
    expect(after.single['search'], 'git');
  });

  testWidgets('"Only events I can join" filters on the server', (tester) async {
    await pumpScreen(tester);

    await tester.tap(find.text('Filters'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(SwitchListTile, 'Only events I can join'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Apply'));
    await tester.pumpAndSettle();
    await settle(tester);

    expect(queries().last['eligible_only'], 'true');
    expect(find.text('Filters (1)'), findsOneWidget);
  });
}
