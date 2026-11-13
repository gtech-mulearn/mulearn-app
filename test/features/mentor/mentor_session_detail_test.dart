import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/mentor/data/dtos/session_participant_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_session_detail_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _id = '282426eb-7650-45da-bbf1-905fe1835115';
const _detail = '$mentorBase/session/list/$_id/';
const _participants = '$mentorBase/session/participant/list/$_id/';

/// Plan 4, Task 4 (M3): a session's details, attendance, participants and
/// completion.
void main() {
  late FakeHttpAdapter adapter;

  Map<String, dynamic> participantRow() =>
      ((loadFixtureResponse('dev/mentor_session_participants')! as Map)['data'] as List).first as Map<String, dynamic>;

  setUp(() {
    adapter = mentorAdapter();
    adapter.routes['GET $_participants'] = (_) => FakeResponse(200, loadFixture('dev/mentor_session_participants'));
  });

  Map<String, dynamic> bodyOf(String method, String path) {
    final r = adapter.requests.lastWhere((RequestOptions r) => r.method == method && r.uri.path == path);
    return (r.data is String ? jsonDecode(r.data as String) : r.data) as Map<String, dynamic>;
  }

  Future<void> drainToast(WidgetTester tester) => tester.pump(const Duration(seconds: 4));

  test('a participant row parses', () {
    final p = SessionParticipantDto.fromJson(participantRow()).toDomain();
    expect(p.linkId, participantRow()['id']);
    expect(p.attendance, AttendanceStatus.fromWire(participantRow()['attendance_status'] as String?));
    expect(AttendanceStatus.fromWire('ATTENDED'), AttendanceStatus.attended);
    expect(AttendanceStatus.fromWire('LATE'), AttendanceStatus.unknown);
  });

  testWidgets('the detail shows the session and its participants', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');

    expect(find.text('Office hours: debugging your first Flutter app'), findsOneWidget);
    expect(find.text('Web Development'), findsWidgets);
    expect(find.text('PARTICIPANTS (1)'), findsOneWidget);
    expect(find.text('Mark as completed'), findsOneWidget);
  });

  testWidgets('marking attendance saves it and shows it at once', (tester) async {
    final linkId = participantRow()['id'] as String;
    adapter.routes['PATCH $mentorBase/session/participant/update/$linkId/'] =
        (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Participant record updated successfully.'));
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');

    await tester.tap(find.byTooltip('Edit attendance').first);
    await settleMentor(tester);
    await tester.tap(find.text('Attended').last);
    await tester.enterText(find.widgetWithText(TextFormField, 'Minutes'), '30');
    await tester.enterText(find.widgetWithText(TextFormField, 'Progress note'), 'Fixed the bug');
    await tester.tap(find.text('Save'));
    await settleMentor(tester);

    expect(bodyOf('PATCH', '$mentorBase/session/participant/update/$linkId/'),
        {'attendance_status': 'ATTENDED', 'contributed_minutes': 30, 'progress_note': 'Fixed the bug'});
    expect(find.text('Attended'), findsWidgets);
    expect(find.text('30m'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('a refused attendance change is rolled back', (tester) async {
    final linkId = participantRow()['id'] as String;
    final before = participantRow()['attendance_status'] as String;
    adapter.routes['PATCH $mentorBase/session/participant/update/$linkId/'] = (_) => const FakeResponse(403, {
          'hasError': true,
          'statusCode': 403,
          'message': {'general': ["You don't have permission to update participants for this session."]},
          'response': <String, dynamic>{},
        });
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');

    await tester.tap(find.byTooltip('Edit attendance').first);
    await settleMentor(tester);
    await tester.tap(find.text(before == 'ABSENT' ? 'Attended' : 'Absent').last);
    await tester.tap(find.text('Save'));
    await settleMentor(tester);

    expect(find.text("You don't have permission to update participants for this session."), findsOneWidget);
    expect(find.text(before == 'ATTENDED' ? 'Attended' : before == 'ABSENT' ? 'Absent' : 'Invited'), findsWidgets);
    await drainToast(tester);
  });

  testWidgets('zero minutes is refused before any request', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');

    await tester.tap(find.byTooltip('Edit attendance').first);
    await settleMentor(tester);
    await tester.enterText(find.widgetWithText(TextFormField, 'Minutes'), '0');
    await tester.tap(find.text('Save'));
    await settleMentor(tester);

    expect(find.text('Contributed minutes must be greater than zero.'), findsOneWidget);
    expect(adapter.requests.where((RequestOptions r) => r.method == 'PATCH'), isEmpty);
  });

  testWidgets('complete on a non-scheduled session shows the backend message', (tester) async {
    adapter.routes['POST $mentorBase/session/complete/$_id/'] =
        (_) => FakeResponse(400, loadFixture('dev/mentor_session_complete_twice'));
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');
    final detailLoads = adapter.requests.where((RequestOptions r) => r.uri.path == _detail).length;

    await tester.tap(find.text('Mark as completed'));
    await settleMentor(tester);
    expect(find.text('Mark Session as Completed'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Complete'));
    await settleMentor(tester);

    expect(find.textContaining('Only a scheduled session can be marked completed'), findsOneWidget);
    expect(adapter.requests.where((RequestOptions r) => r.uri.path == _detail).length, greaterThan(detailLoads));
    await drainToast(tester);
  });

  testWidgets('a completed session offers no Complete and no Add', (tester) async {
    adapter.routes['GET $_detail'] = (_) {
      final body = loadFixture('dev/mentor_session_detail');
      return FakeResponse(200, {...body, 'response': {...body['response'] as Map<String, dynamic>, 'status': 'COMPLETED'}});
    };
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');

    expect(find.text('Mark as completed'), findsNothing);
    expect(find.text('Add participant'), findsNothing);
  });

  testWidgets('add participant posts the muid', (tester) async {
    adapter.routes['POST $mentorBase/session/participant/add/$_id/'] =
        (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Successfully added participant to the session.'));
    await pumpMentor(tester, adapter, '/mentor/sessions/$_id');

    await tester.tap(find.text('Add participant'));
    await settleMentor(tester);
    await tester.enterText(find.widgetWithText(TextFormField, 'muID'), ' learner@mulearn ');
    await tester.tap(find.widgetWithText(TextButton, 'Add'));
    await settleMentor(tester);

    expect(bodyOf('POST', '$mentorBase/session/participant/add/$_id/'), {'muid': 'learner@mulearn'});
    await drainToast(tester);
  });

  testWidgets('a session in the list opens its detail', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions');

    await tester.tap(find.text('Office hours: debugging your first Flutter app'));
    await settleMentor(tester);

    expect(find.byType(MentorSessionDetailScreen), findsOneWidget);
    expect(find.text('PARTICIPANTS (1)'), findsOneWidget);
  });
}
