import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/mentor/data/dtos/student_request_dto.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/request_review.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _requests = '$mentorBase/session/student-requests/';
const _requestId = 'fa6356a5-b601-491f-9172-7a73e9f1cabe';
const _verify = '$mentorBase/session/student-requests/$_requestId/verify/';

/// Plan 4, Task 5 (M4): learners' session requests — approve as proposed or
/// with changes, or reject.
void main() {
  late FakeHttpAdapter adapter;

  Map<String, dynamic> recordedRequest() =>
      ((loadFixtureResponse('dev/mentor_student_requests_one')! as Map)['data'] as List).first as Map<String, dynamic>;

  setUp(() {
    adapter = mentorAdapter();
    adapter.routes['GET $_requests'] = (_) => FakeResponse(200, loadFixture('dev/mentor_student_requests_one'));
  });

  Map<String, dynamic> bodyOf(String method, String path) {
    final r = adapter.requests.lastWhere((RequestOptions r) => r.method == method && r.uri.path == path);
    return (r.data is String ? jsonDecode(r.data as String) : r.data) as Map<String, dynamic>;
  }

  Future<void> drainToast(WidgetTester tester) => tester.pump(const Duration(seconds: 4));

  test('a request parses with who asked', () {
    final r = StudentRequestDto.fromJson(recordedRequest()).toDomain();
    expect(r.id, _requestId);
    expect(r.title, '[QA] Help with my first Flutter widget test');
    expect(r.requesterName, 'Fixture User');
    expect(r.requesterMuid, 'qastudentone@mulearn');
    expect(r.scopeName, 'Web Development');
    expect(r.mode, SessionMode.online);
    expect(r.startsAt, DateTime.utc(2026, 11, 16, 12, 30));
    expect(r.meetingLink, isNull, reason: 'an empty link is no link');
  });

  group('verify body', () {
    final original = StudentRequestDto.fromJson({
      'id': 'r1',
      'title': 'T',
      'mode': 'ONLINE',
      'starts_at': '2026-11-16T12:30:00Z',
      'ends_at': '2026-11-16T13:15:00Z',
    }).toDomain();

    test('approving as proposed sends only the status', () {
      expect(verifyBody(original, approve: true), {'status': 'APPROVED'});
    });

    test('approving with changes sends only what changed', () {
      final later = original.startsAt.add(const Duration(hours: 2)).toLocal();
      expect(
        verifyBody(original, approve: true, startsLocal: later, meetingLink: ' https://meet.example/x '),
        {'status': 'APPROVED', 'starts_at': later.toUtc().toIso8601String(), 'meeting_link': 'https://meet.example/x'},
      );
      expect(verifyBody(original, approve: true, mode: SessionMode.online), {'status': 'APPROVED'});
    });

    test('rejecting sends only the status', () {
      expect(verifyBody(original, approve: false, meetingLink: 'https://x'), {'status': 'REJECTED'});
    });
  });

  testWidgets('a request shows who asked, what and when, with Approve and Reject', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/requests');

    expect(find.text('Fixture User'), findsOneWidget);
    expect(find.text('[QA] Help with my first Flutter widget test'), findsOneWidget);
    expect(find.text('Approve'), findsOneWidget);
    expect(find.text('Reject'), findsOneWidget);
  });

  testWidgets('approve as proposed schedules it and removes the row', (tester) async {
    adapter.routes['PATCH $_verify'] = (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Session approved and scheduled.'));
    await pumpMentor(tester, adapter, '/mentor/requests');

    await tester.tap(find.text('Approve'));
    await settleMentor(tester);
    expect(find.text('Approve session request'), findsOneWidget);
    expect(find.textContaining('Add a meeting link so'), findsOneWidget, reason: 'online with no link');
    await tester.tap(find.text('Approve & Schedule'));
    await settleMentor(tester);

    expect(bodyOf('PATCH', _verify), {'status': 'APPROVED'});
    expect(find.text('[QA] Help with my first Flutter widget test'), findsNothing);
    expect(find.textContaining('Scheduled for'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('a link added while approving is sent with it', (tester) async {
    adapter.routes['PATCH $_verify'] = (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}));
    await pumpMentor(tester, adapter, '/mentor/requests');

    await tester.tap(find.text('Approve'));
    await settleMentor(tester);
    await tester.enterText(find.widgetWithText(TextFormField, 'Meeting link'), 'https://meet.example/help');
    await tester.tap(find.text('Approve & Schedule'));
    await settleMentor(tester);

    expect(bodyOf('PATCH', _verify), {'status': 'APPROVED', 'meeting_link': 'https://meet.example/help'});
    await drainToast(tester);
  });

  testWidgets('reject asks first', (tester) async {
    adapter.routes['PATCH $_verify'] = (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Session request rejected.'));
    await pumpMentor(tester, adapter, '/mentor/requests');

    await tester.tap(find.text('Reject'));
    await settleMentor(tester);
    expect(find.text('Reject this request?'), findsOneWidget);
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.widgetWithText(TextButton, 'Reject')));
    await settleMentor(tester);

    expect(bodyOf('PATCH', _verify), {'status': 'REJECTED'});
    expect(find.text('Session request rejected.'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('a request someone already handled says so and refreshes', (tester) async {
    // Recorded on dev: HTTP 400 with the envelope's statusCode 404.
    adapter.routes['PATCH $_verify'] = (_) => const FakeResponse(400, {
          'hasError': true,
          'statusCode': 404,
          'message': {'general': ['Session request not found or is not in REQUESTED status.']},
          'response': <String, dynamic>{},
        });
    await pumpMentor(tester, adapter, '/mentor/requests');
    final loads = queriesTo(adapter, _requests).length;

    await tester.tap(find.text('Reject'));
    await settleMentor(tester);
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.widgetWithText(TextButton, 'Reject')));
    await settleMentor(tester);

    expect(find.text('Session request not found or is not in REQUESTED status.'), findsOneWidget);
    expect(queriesTo(adapter, _requests).length, greaterThan(loads));
    await drainToast(tester);
  });

  testWidgets('no requests shows the illustrated empty state', (tester) async {
    adapter.routes['GET $_requests'] = (_) => FakeResponse(200, loadFixture('dev/mentor_student_requests'));
    await pumpMentor(tester, adapter, '/mentor/requests');

    expect(find.byType(MuStateDisplay), findsOneWidget);
    expect(find.text('No incoming session requests found.'), findsOneWidget);
  });

  testWidgets('the hub opens the requests with their count', (tester) async {
    await pumpMentor(tester, adapter, '/mentor');

    expect(find.text('1 waiting'), findsOneWidget);
    await tester.tap(find.text('Session requests'));
    await settleMentor(tester);
    expect(find.text('Approve'), findsOneWidget);
  });
}
