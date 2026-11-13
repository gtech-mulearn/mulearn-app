import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/availability_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_hub_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_session_detail_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_sessions_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/session_form_screen.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/student_requests_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const mentorBase = '/api/v1/dashboard/mentor';

/// 2026-11-13 09:00 UTC: the recorded sessions (20 Nov) are upcoming.
final mentorTestNow = DateTime.utc(2026, 11, 13, 9);

Map<String, dynamic> okEnvelope(Object response, {String message = ''}) => {
      'hasError': false,
      'statusCode': 200,
      'message': {'general': message.isEmpty ? <String>[] : [message]},
      'response': response,
    };

Map<String, dynamic> pagedEnvelope(List<Object> rows, {bool isNext = false}) => okEnvelope({
      'data': rows,
      'pagination': {'count': rows.length, 'totalPages': isNext ? 2 : 1, 'isNext': isNext, 'isPrev': false, 'nextPage': null},
    });

/// The QA mentor's recorded responses for every mentor GET.
FakeHttpAdapter mentorAdapter() => FakeHttpAdapter({
      'GET $mentorBase/overview/': (_) => FakeResponse(200, loadFixture('dev/mentor_overview')),
      'GET $mentorBase/analytics/personal/': (_) => FakeResponse(200, loadFixture('dev/mentor_analytics')),
      'GET $mentorBase/profile/completion/': (_) => FakeResponse(200, loadFixture('dev/mentor_profile_completion')),
      'GET $mentorBase/session/list/': (_) => FakeResponse(200, loadFixture('dev/mentor_sessions_scheduled')),
      'GET $mentorBase/session/list/282426eb-7650-45da-bbf1-905fe1835115/': (_) =>
          FakeResponse(200, loadFixture('dev/mentor_session_detail')),
      'GET $mentorBase/session/student-requests/': (_) => FakeResponse(200, loadFixture('dev/mentor_student_requests')),
      'GET $mentorBase/tasks/ig-dropdown/': (_) => FakeResponse(200, loadFixture('dev/mentor_ig_dropdown')),
    });

/// Pumps the mentor routes at [location] and returns the router.
Future<GoRouter> pumpMentor(
  WidgetTester tester,
  FakeHttpAdapter adapter,
  String location, {
  List<Uri>? opened,
  DateTime? now,
}) async {
  FlavorConfig.initialize(Flavor.dev);
  final tokens = TokenStorage(FakeSecureStorage());
  await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
  final container = ProviderContainer(retry: (_, __) => null, overrides: [
    dioProvider.overrideWithValue(fakeDio(adapter)),
    tokenStorageProvider.overrideWithValue(tokens),
    clockProvider.overrideWithValue(() => now ?? mentorTestNow),
    openExternalProvider.overrideWithValue((uri) async {
      opened?.add(uri);
      return true;
    }),
  ]);
  addTearDown(container.dispose);
  final router = GoRouter(initialLocation: location, routes: [
    GoRoute(path: '/mentor', builder: (_, __) => const MentorHubScreen()),
    GoRoute(path: '/mentor/sessions', builder: (_, __) => const MentorSessionsScreen()),
    GoRoute(path: '/mentor/sessions/new', builder: (_, __) => const SessionFormScreen()),
    GoRoute(path: '/mentor/requests', builder: (_, __) => const StudentRequestsScreen()),
    GoRoute(path: '/mentor/availability', builder: (_, __) => const AvailabilityScreen()),
    GoRoute(path: '/mentor/sessions/:id/edit', builder: (_, s) => SessionFormScreen(sessionId: s.pathParameters['id'])),
    GoRoute(path: '/mentor/sessions/:id', builder: (_, s) => MentorSessionDetailScreen(sessionId: s.pathParameters['id']!)),
  ]);
  addTearDown(router.dispose);
  tester.view.physicalSize = const Size(1080, 4200);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
  await settleMentor(tester);
  return router;
}

Future<void> settleMentor(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

List<Map<String, dynamic>> queriesTo(FakeHttpAdapter adapter, String path) => [
      for (final r in adapter.requests)
        if (r.method == 'GET' && r.uri.path == path) Map.of(r.uri.queryParameters),
    ];

/// The recorded session (20 Nov 12:30–13:30 UTC) with [changes] applied.
Map<String, dynamic> recordedSession([Map<String, dynamic> changes = const {}]) {
  final body = loadFixture('dev/mentor_session_detail');
  return {...body['response'] as Map<String, dynamic>, ...changes};
}

/// The recorded session's start, for clocks relative to it.
final recordedStart = DateTime.utc(2026, 11, 20, 12, 30);

/// Records clipboard writes made through `Clipboard.setData`.
List<String> captureClipboard(WidgetTester tester) {
  final copied = <String>[];
  tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, (call) async {
    if (call.method == 'Clipboard.setData') copied.add((call.arguments as Map)['text'] as String);
    if (call.method == 'Clipboard.getData') return {'text': copied.isEmpty ? null : copied.last};
    return null;
  });
  addTearDown(() => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(SystemChannels.platform, null));
  return copied;
}
