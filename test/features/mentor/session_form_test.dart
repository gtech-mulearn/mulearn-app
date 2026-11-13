import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'mentor_test_support.dart';

const _create = '$mentorBase/session/create/';
const _sessionId = '282426eb-7650-45da-bbf1-905fe1835115';

/// Plan 4, Task 3 (M2): creating and editing a session.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = mentorAdapter();
    adapter.routes['POST $_create'] = (_) => FakeResponse(201, okEnvelope(<String, dynamic>{}, message: 'Session created'));
  });

  Map<String, dynamic> bodyOf(String method, String path) {
    final r = adapter.requests.lastWhere((RequestOptions r) => r.method == method && r.uri.path == path);
    return (r.data is String ? jsonDecode(r.data as String) : r.data) as Map<String, dynamic>;
  }

  testWidgets('a new session posts its scope, mode and UTC times, then goes back', (tester) async {
    final router = await pumpMentor(tester, adapter, '/mentor/sessions');
    // push() completes only when the route pops; don't wait on it.
    unawaited(router.push('/mentor/sessions/new'));
    await settleMentor(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Title'), 'Career clinic');
    await tester.enterText(find.widgetWithText(TextFormField, 'Meeting link'), 'https://meet.example/c');
    await tester.tap(find.text('Create session'));
    await settleMentor(tester);

    final body = bodyOf('POST', _create);
    expect(body['session_type'], 'IG_SESSION');
    expect(body['entity_id'], '4ff0a5e5-d1ef-44dd-ac13-9a2f9e7717e3');
    expect(body['title'], 'Career clinic');
    expect(body['mode'], 'ONLINE');
    expect(body['venue'], '');
    expect(body['meeting_link'], 'https://meet.example/c');
    expect(DateTime.parse(body['starts_at'] as String).isUtc, isTrue);
    expect(router.routerDelegate.currentConfiguration.uri.path, '/mentor/sessions');
    await tester.pump(const Duration(seconds: 4)); // let the toast go
  });

  testWidgets("the backend's field error shows under its field", (tester) async {
    // Recorded on dev: {general: [], meeting_link: [...]}.
    adapter.routes['POST $_create'] = (_) => FakeResponse(400, loadFixture('dev/mentor_session_create_bad_mode'));
    await pumpMentor(tester, adapter, '/mentor/sessions/new');

    await tester.enterText(find.widgetWithText(TextFormField, 'Title'), 'Career clinic');
    await tester.enterText(find.widgetWithText(TextFormField, 'Meeting link'), 'https://meet.example/x');
    await tester.tap(find.text('Create session'));
    await settleMentor(tester);

    expect(find.text('Meeting link must not be provided for an offline session.'), findsOneWidget);
  });

  testWidgets('a missing title is refused before any request', (tester) async {
    await pumpMentor(tester, adapter, '/mentor/sessions/new');

    await tester.tap(find.text('Create session'));
    await settleMentor(tester);

    expect(find.text('Title is required.'), findsOneWidget);
    expect(adapter.requests.where((RequestOptions r) => r.method == 'POST'), isEmpty);
  });

  testWidgets('a mentor with nowhere to create is told why', (tester) async {
    adapter.routes['GET $mentorBase/overview/'] = (_) => FakeResponse(200, okEnvelope({'scopes': <Object>[]}));
    await pumpMentor(tester, adapter, '/mentor/sessions/new');

    expect(find.text('No mentoring scope yet'), findsOneWidget);
    expect(tester.widget<MuPrimaryButton>(find.widgetWithText(MuPrimaryButton, 'Create session')).onPressed, isNull);
  });

  testWidgets('a global mentor picks one of their interest groups', (tester) async {
    adapter.routes['GET $mentorBase/overview/'] = (_) => FakeResponse(
          200,
          okEnvelope({
            'scopes': [
              {'scope_type': 'MENTOR', 'scope_id': '', 'scope_name': 'Global', 'metrics': <String, dynamic>{}},
            ],
          }),
        );
    await pumpMentor(tester, adapter, '/mentor/sessions/new');

    expect(find.text('Web Development'), findsOneWidget, reason: 'the IG from tasks/ig-dropdown is the target');
    await tester.enterText(find.widgetWithText(TextFormField, 'Title'), 'AMA');
    await tester.enterText(find.widgetWithText(TextFormField, 'Meeting link'), 'https://meet.example/a');
    await tester.tap(find.text('Create session'));
    await settleMentor(tester);

    expect(bodyOf('POST', _create)['entity_id'], '4ff0a5e5-d1ef-44dd-ac13-9a2f9e7717e3');
    expect(bodyOf('POST', _create)['session_type'], 'IG_SESSION');
    await tester.pump(const Duration(seconds: 4)); // let the toast go
  });

  testWidgets('editing prefills the session and patches only editable fields', (tester) async {
    adapter.routes['PATCH $mentorBase/session/update/$_sessionId/'] =
        (_) => FakeResponse(200, okEnvelope(<String, dynamic>{}, message: 'Session updated'));
    await pumpMentor(tester, adapter, '/mentor/sessions/$_sessionId/edit');

    expect(find.text('Office hours: debugging your first Flutter app'), findsOneWidget);
    await tester.enterText(find.widgetWithText(TextFormField, 'Title'), 'Office hours (moved)');
    await tester.tap(find.text('Save changes'));
    await settleMentor(tester);

    final body = bodyOf('PATCH', '$mentorBase/session/update/$_sessionId/');
    expect(body['title'], 'Office hours (moved)');
    expect(body.containsKey('session_type'), isFalse);
    expect(body.containsKey('is_recurring'), isFalse);
    await tester.pump(const Duration(seconds: 4)); // let the toast go
  });

  testWidgets('the hub opens New session only when there is a scope', (tester) async {
    adapter.routes['GET $mentorBase/overview/'] = (_) => FakeResponse(200, okEnvelope({'scopes': <Object>[]}));
    await pumpMentor(tester, adapter, '/mentor');

    expect(tester.widget<MuPrimaryButton>(find.widgetWithText(MuPrimaryButton, 'New session')).onPressed, isNull);
  });
}
