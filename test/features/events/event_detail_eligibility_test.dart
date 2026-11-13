import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/features/events/data/dtos/event_dto.dart';
import 'package:mulearn_app/features/events/presentation/screens/event_detail_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'events_test_support.dart';

/// L15 / UX-07 — EventDetailSerializer: viewer_can_access_registration,
/// viewer_access_blocked_reason (cancelled, completed, draft, karma gate),
/// linked_tasks (LinkedTaskSerializer).
void main() {
  Map<String, dynamic> withActiveTask() {
    final body = loadFixture('dev/event_detail_linked_tasks');
    final response = Map<String, dynamic>.of(body['response'] as Map<String, dynamic>);
    response['linked_tasks'] = [
      for (final t in (response['linked_tasks'] as List<dynamic>).cast<Map<String, dynamic>>()) {...t, 'active': true},
    ];
    return {...body, 'response': response};
  }

  test('a completed event carries its reason and no registration', () {
    final e = EventDto.fromJson(loadFixtureResponse('dev/event_detail_blocked')! as Map<String, dynamic>).toDomain();

    expect(e.canRegister, isFalse);
    expect(e.blockedReason, 'This event has already completed.');
  });

  test('only live linked tasks are listed', () {
    final pending = EventDto.fromJson(loadFixtureResponse('dev/event_detail_linked_tasks')! as Map<String, dynamic>).toDomain();
    final live = EventDto.fromJson(withActiveTask()['response'] as Map<String, dynamic>).toDomain();

    expect(pending.linkedTasks, isEmpty, reason: 'the seeded task awaits admin approval (active: false)');
    expect(live.linkedTasks.single.hashtag, '#wit-takeaway');
    expect(live.linkedTasks.single.karma, 50);
    expect(live.canRegister, isTrue);
    expect(live.blockedReason, isNull);
  });

  Future<void> pumpDetail(WidgetTester tester, String id, Map<String, dynamic> body) async {
    final adapter = FakeHttpAdapter({'GET /api/v1/dashboard/events/$id/': (_) => FakeResponse(200, body)});
    final c = await eventsContainer(adapter);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: c, child: MaterialApp(home: EventDetailScreen(eventId: id))));
    await settle(tester);
  }

  testWidgets('blocked events show the reason and disable registration', (tester) async {
    await pumpDetail(tester, '01882a2e-2501-409a-8e15-440903a9c036', loadFixture('dev/event_detail_blocked'));

    expect(find.text('This event has already completed.'), findsOneWidget);
    final interested = tester.widget<MuPrimaryButton>(find.byType(MuPrimaryButton));
    expect(interested.onPressed, isNull);
    for (final ghost in tester.widgetList<MuGhostButton>(find.byType(MuGhostButton))) {
      expect(ghost.onPressed, isNull, reason: 'Register is disabled too');
    }
  });

  testWidgets("an event's live tasks are listed with their hashtag and karma", (tester) async {
    await pumpDetail(tester, '3d2eba4f-915d-40b9-bc28-dc04c98ed4a9', withActiveTask());

    expect(find.text('TASKS FOR THIS EVENT'), findsOneWidget);
    expect(find.text('Share one takeaway from the evening'), findsOneWidget);
    expect(find.text('#wit-takeaway'), findsOneWidget);
    expect(find.text('+50 karma'), findsOneWidget);
  });

  testWidgets('no live tasks, no tasks section', (tester) async {
    await pumpDetail(tester, '3d2eba4f-915d-40b9-bc28-dc04c98ed4a9', loadFixture('dev/event_detail_linked_tasks'));

    expect(find.text('TASKS FOR THIS EVENT'), findsNothing);
  });
}
