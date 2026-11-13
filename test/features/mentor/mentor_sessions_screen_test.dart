import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _list = '$mentorBase/session/list/';
const _sessionId = '282426eb-7650-45da-bbf1-905fe1835115';

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

  testWidgets('delete asks first, then removes the session', (tester) async {
    adapter.routes['DELETE $mentorBase/session/update/$_sessionId/'] =
        (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Session deleted successfully.'));
    await pumpMentor(tester, adapter, '/mentor/sessions');
    final before = queriesTo(adapter, _list).length;

    await tester.tap(find.byTooltip('Session actions').first);
    await settleMentor(tester);
    await tester.tap(find.text('Delete'));
    await settleMentor(tester);
    expect(find.text('Delete this session?'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await settleMentor(tester);

    expect(adapter.requests.where((RequestOptions r) => r.method == 'DELETE'), hasLength(1));
    expect(queriesTo(adapter, _list).length, greaterThan(before), reason: 'the list refetches');
    await tester.pump(const Duration(seconds: 4)); // let the toast go
  });
}
