import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _list = '$mentorBase/session/list/';

/// Plan 4, Task 3 (M2): the mentor's sessions with filters, paging, delete.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() => adapter = mentorAdapter());

  Map<String, dynamic> recordedRow() =>
      ((loadFixtureResponse('dev/mentor_sessions_scheduled')! as Map)['data'] as List).first as Map<String, dynamic>;

  testWidgets('each filter chip asks for its status and order', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions');
    expect(queriesTo(adapter, _list).last, containsPair('status', 'SCHEDULED'));
    expect(queriesTo(adapter, _list).last, containsPair('sortBy', 'starts_at'));

    await tester.ensureVisible(find.text('Completed', skipOffstage: false));
    await tester.pump();
    await tester.tap(find.text('Completed'));
    await settleMentor(tester);
    expect(queriesTo(adapter, _list).last, containsPair('status', 'COMPLETED'));
    expect(queriesTo(adapter, _list).last, containsPair('sortBy', '-starts_at'));

    await tester.ensureVisible(find.text('All', skipOffstage: false));
    await tester.pump();
    await tester.tap(find.text('All'));
    await settleMentor(tester);
    expect(queriesTo(adapter, _list).last.containsKey('status'), isFalse);
  });

  testWidgets('sessions group under their local day', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions');

    final day = DateTime.parse(recordedRow()['starts_at'] as String).toLocal();
    const weekdays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    expect(find.textContaining('${weekdays[day.weekday - 1]} ${day.day}'), findsOneWidget);
    expect(find.text('Office hours: debugging your first Flutter app'), findsOneWidget);
  });

  testWidgets('scrolling to the end loads the next page and appends it', (tester) async {
    final row = recordedRow();
    adapter.routes['GET $_list'] = (o) => '${o.queryParameters['pageIndex']}' == '2'
        ? FakeResponse(200, pagedEnvelope([
            {...row, 'id': 'second', 'title': 'Second page session'},
          ]))
        : FakeResponse(200, pagedEnvelope([row], isNext: true));
    await pumpMentor(tester, adapter, '/mentor/sessions');

    await tester.fling(find.byType(ListView).last, const Offset(0, -2000), 3000);
    await settleMentor(tester);

    expect(find.text('Second page session'), findsOneWidget);
    expect(find.text('Office hours: debugging your first Flutter app'), findsOneWidget);
  });

  testWidgets('no sessions shows the dashboard no-results state', (tester) async {
    adapter.routes['GET $_list'] = (_) => FakeResponse(200, pagedEnvelope(const []));
    await pumpMentor(tester, adapter, '/mentor/sessions');

    expect(tester.widget<MuStateDisplay>(find.byType(MuStateDisplay)).variant, MuStateVariant.noResults);
    expect(find.text('Nothing here. Yet.'), findsOneWidget);
  });

  testWidgets('a session about to start can be joined from its row', (tester) async {
    final opened = <Uri>[];
    await pumpMentor(tester, adapter, '/mentor/sessions',
        opened: opened, now: recordedStart.subtract(const Duration(minutes: 10)));

    expect(find.text('TODAY'), findsOneWidget, reason: 'the 20 Nov session is today on the 20th');
    await tester.tap(find.text('Join'));
    await settleMentor(tester);

    expect(opened.single.toString(), startsWith('https://meet.google.com/'));
    expect(find.text('PARTICIPANTS (1)'), findsNothing, reason: 'Join opens the link, not the detail');
  });

  testWidgets('rows show no menu; edit and delete live in the detail', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions');

    expect(find.byTooltip('Session actions'), findsNothing);
    expect(find.text('Join'), findsNothing, reason: 'a week away: not joinable yet');
  });
}
