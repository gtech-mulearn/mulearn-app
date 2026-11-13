import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_hub_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/mentor';

/// Plan 4, Task 2 (M1): the mentor hub, laid out like audit 06 "M1 Mentor
/// home": next sessions, requests, profile completion, totals, scopes.
void main() {
  late FakeHttpAdapter adapter;
  late List<Uri> opened;

  setUpAll(() => FlavorConfig.initialize(Flavor.dev));

  setUp(() {
    opened = [];
    adapter = FakeHttpAdapter({
      'GET $_base/overview/': (_) => FakeResponse(200, loadFixture('dev/mentor_overview')),
      'GET $_base/analytics/personal/': (_) => FakeResponse(200, loadFixture('dev/mentor_analytics')),
      'GET $_base/profile/completion/': (_) => FakeResponse(200, loadFixture('dev/mentor_profile_completion')),
      'GET $_base/session/list/': (_) => FakeResponse(200, loadFixture('dev/mentor_sessions_scheduled')),
      'GET $_base/session/student-requests/': (_) => FakeResponse(200, loadFixture('dev/mentor_student_requests')),
    });
  });

  Future<void> pumpHub(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 13, 9)),
      openExternalProvider.overrideWithValue((uri) async {
        opened.add(uri);
        return true;
      }),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/mentor', routes: [
      GoRoute(path: '/mentor', builder: (_, __) => const MentorHubScreen()),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('the hub shows the next sessions, requests, completion, totals and scopes', (tester) async {
    await pumpHub(tester);

    expect(find.text('NEXT UP'), findsOneWidget);
    expect(find.text('Office hours: debugging your first Flutter app'), findsWidgets);
    expect(find.text('Session requests'), findsOneWidget);
    expect(find.text('None waiting'), findsOneWidget);
    expect(find.text('Profile 75% complete'), findsOneWidget);
    expect(find.text('Missing: LinkedIn'), findsOneWidget);
    expect(find.text('SESSIONS COMPLETED'), findsOneWidget);
    expect(find.text('NO RATINGS YET'), findsOneWidget);
    expect(find.text('Web Development'), findsWidgets);
    expect(find.text('IG mentor'), findsOneWidget);
    expect(find.text('6 learners · 6 active · 2 upcoming sessions · 3 circles'), findsOneWidget);
  });

  testWidgets('the next sessions ask for scheduled sessions, soonest first', (tester) async {
    await pumpHub(tester);

    final q = adapter.requests.firstWhere((r) => r.uri.path == '$_base/session/list/').queryParameters;
    expect(q['status'], 'SCHEDULED');
    expect(q['sortBy'], 'starts_at');
  });

  testWidgets('a session that already ended is not "next up"', (tester) async {
    final body = loadFixture('dev/mentor_sessions_scheduled');
    final response = Map<String, dynamic>.of(body['response'] as Map<String, dynamic>);
    response['data'] = [
      for (final row in response['data'] as List)
        {...row as Map<String, dynamic>, 'starts_at': '2026-11-01T10:00:00Z', 'ends_at': '2026-11-01T11:00:00Z'},
    ];
    adapter.routes['GET $_base/session/list/'] = (_) => FakeResponse(200, {...body, 'response': response});
    await pumpHub(tester);

    expect(find.text('No upcoming sessions.'), findsOneWidget);
  });

  testWidgets('"Finish on web" opens the dashboard profile', (tester) async {
    await pumpHub(tester);

    await tester.tap(find.text('Finish on web'));
    await tester.pump();

    expect(opened.single.toString(), '${FlavorConfig.instance.dashboardUrl}/dashboard/profile');
  });

  testWidgets('a mentor with no scope is told so', (tester) async {
    adapter.routes['GET $_base/overview/'] = (_) => const FakeResponse(200, {
          'hasError': false,
          'statusCode': 200,
          'message': {'general': <String>[]},
          'response': {'scopes': <Object>[]},
        });
    await pumpHub(tester);

    expect(find.text('No mentoring scope yet'), findsOneWidget);
  });
}
