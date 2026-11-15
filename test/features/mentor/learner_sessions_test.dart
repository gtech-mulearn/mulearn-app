import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/mentor/data/learner_sessions_data.dart';
import 'package:mulearn_app/features/mentor/domain/entities/learner_sessions.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/learner_sessions_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _m = '/api/v1/dashboard/mentor/session';
const _flutterClinic = '282426eb-7650-45da-bbf1-905fe1835115'; // available, 20 Nov
const _attended = 'plan 4 attendance check';

/// The learner's side of mentor sessions, recorded on dev 2026-11-15 as the
/// QA student: 2 available sessions, 2 requests (1 waiting, 1 declined), 4
/// history rows (1 attended). Writes are faked.
void main() {
  test('available, history and requests parse from dev', () {
    final available = LearnerSessionsRepositoryImpl.parseAvailable(
      loadFixtureResponse('dev/learner_sessions_available')! as Map<String, dynamic>,
    );
    expect(available, hasLength(2));
    expect(available.first.mentorName, 'QA Mentor One');
    expect(available.first.session.startsAt.isBefore(available.last.session.startsAt), isTrue);

    final history = LearnerSessionsRepositoryImpl.parseHistory(
      loadFixtureResponse('dev/learner_session_history')! as Map<String, dynamic>,
    );
    expect(history, hasLength(4));
    final attended = history.firstWhere((r) => r.session.title.contains(_attended));
    expect(attended.attendance, LearnerAttendance.attended);
    expect(attended.canGiveFeedback, isTrue);

    final requests = LearnerSessionsRepositoryImpl.parseRequests(
      loadFixtureResponse('dev/learner_session_requests')! as Map<String, dynamic>,
    );
    expect(requests.map((r) => r.status), containsAll([SessionStatus.requested, SessionStatus.rejected]));
  });

  test('a request sends only what its mode allows, in UTC', () {
    final json = SessionRequestDraft(
      igId: 'ig',
      title: 'Hooks',
      description: 'Stuck on effects',
      mode: SessionMode.online,
      startsAt: DateTime.utc(2026, 11, 20, 12),
      endsAt: DateTime.utc(2026, 11, 20, 13),
      venue: 'Lab 2',
    ).toJson();
    expect(json['session_type'], 'IG_SESSION');
    expect(json['mode'], 'ONLINE');
    expect(json.containsKey('venue'), isFalse, reason: 'the backend refuses a venue online');
    expect(json.containsKey('meeting_link'), isFalse, reason: 'optional; the mentor adds it');
    expect(json['starts_at'], '2026-11-20T12:00:00.000Z');
  });

  late FakeHttpAdapter adapter;
  late Map<String, dynamic> history;

  Map<String, dynamic> envelope(Object? response, [String message = '']) => {
    'hasError': false,
    'statusCode': 200,
    'message': {
      'general': [if (message.isNotEmpty) message],
    },
    'response': response,
  };

  setUp(() {
    history = jsonDecode(jsonEncode(loadFixtureResponse('dev/learner_session_history'))) as Map<String, dynamic>;
    adapter = FakeHttpAdapter({
      'GET $_m/available/': (_) => FakeResponse(200, loadFixture('dev/learner_sessions_available')),
      'GET $_m/participant/history/': (_) => FakeResponse(200, envelope(history)),
      'GET $_m/student/my-requests/': (_) => FakeResponse(200, loadFixture('dev/learner_session_requests')),
      'POST $_m/participation/join/$_flutterClinic/': (_) {
        final available =
            (loadFixtureResponse('dev/learner_sessions_available')! as Map<String, dynamic>)['data'] as List;
        final s = available.cast<Map<String, dynamic>>().firstWhere((r) => r['id'] == _flutterClinic);
        (history['data'] as List).add({
          'id': 'new-link',
          'session_id': _flutterClinic,
          'attendance_status': 'INVITED',
          'feedback': null,
          'session_title': s['title'],
          'session_starts_at': s['starts_at'],
          'session_ends_at': s['ends_at'],
          'session_mode': s['mode'],
          'session_status': 'SCHEDULED',
          'session_meeting_link': s['meeting_link'],
        });
        return FakeResponse(200, envelope(<String, Object>{}, 'Successfully joined the session.'));
      },
      'PATCH $_m/participant/feedback/': (_) => FakeResponse(200, envelope(null, 'Feedback submitted successfully.')),
      'POST $_m/student/request/': (_) => FakeResponse(200, envelope(<String, Object>{}, 'Session request sent.')),
    });
  });

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> pump(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 15, 6)),
        myProfilePayloadProvider.overrideWith(
          (ref) async => loadFixtureResponse('dev/user_profile')! as Map<String, dynamic>,
        ),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/sessions',
      routes: [GoRoute(path: '/sessions', builder: (_, _) => const LearnerSessionsScreen())],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 5000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: MuThemeData.light(), routerConfig: router),
      ),
    );
    await settle(tester);
  }

  testWidgets('join an open session; it shows as joined', (tester) async {
    await pump(tester);
    expect(find.text('Office hours: debugging your first Flutter app'), findsOneWidget);
    expect(find.text('Portfolio review: web projects'), findsOneWidget);
    expect(find.textContaining('QA Mentor One'), findsWidgets);

    await tester.tap(find.widgetWithText(MuButton, 'Join').first);
    await settle(tester);
    expect(adapter.requests.where((RequestOptions r) => r.path.contains('/participation/join/')), hasLength(1));
    expect(find.text('Successfully joined the session.'), findsOneWidget);
    expect(find.widgetWithText(MuPill, 'Joined'), findsOneWidget);
  });

  testWidgets('requests show where they stand; history asks for feedback on attended ones', (tester) async {
    await pump(tester);
    await tester.tap(find.text('Requests'));
    await settle(tester);
    expect(find.text('Waiting for a mentor'), findsOneWidget);
    expect(find.text('Declined'), findsOneWidget);

    await tester.tap(find.text('History'));
    await settle(tester);
    expect(find.text('Attended'), findsOneWidget);
    await tester.tap(find.widgetWithText(MuButton, 'Rate it'));
    await settle(tester);
    await tester.tap(find.bySemanticsLabel('Rate 4 out of 5'));
    await tester.tap(find.widgetWithText(MuButton, 'Send feedback'));
    await settle(tester);
    final patch = adapter.requests.lastWhere((RequestOptions r) => r.method == 'PATCH');
    expect(patch.data, {'rating': 4});
  });

  testWidgets('ask for a session in one of your groups', (tester) async {
    await pump(tester);
    await tester.tap(find.widgetWithText(MuButton, 'Ask for a session'));
    await settle(tester);

    await tester.tap(find.widgetWithText(MuButton, 'Send request'));
    await settle(tester);
    expect(find.text('Pick the group to ask in.'), findsOneWidget);

    await tester.tap(find.text('Pick one of yours'));
    await settle(tester);
    await tester.tap(find.text('Web Development').last);
    await settle(tester);
    await tester.enterText(find.byType(TextField).at(0), 'Getting started with hooks');
    await tester.enterText(find.byType(TextField).at(1), 'I can render, but effects confuse me.');
    await tester.tap(find.widgetWithText(MuButton, 'Send request'));
    await settle(tester);

    final post = adapter.requests.lastWhere((RequestOptions r) => r.method == 'POST');
    final body = post.data as Map;
    expect(body['entity_id'], '4ff0a5e5-d1ef-44dd-ac13-9a2f9e7717e3');
    expect(body['mode'], 'ONLINE');
    expect(body['title'], 'Getting started with hooks');
    expect(find.text('Session request sent.'), findsOneWidget);
  });
}
