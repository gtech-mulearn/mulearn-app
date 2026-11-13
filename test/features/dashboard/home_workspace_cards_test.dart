import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/widgets/workspace_links.dart';
import 'package:mulearn_app/features/dashboard/presentation/screens/home_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _overview = 'GET /api/v1/dashboard/mentor/overview/';

/// Plan 4, Task 2 (UX-01): role workspaces open from Home and Profile, not
/// new tabs (spec §8.2 item 5).
void main() {
  late FakeHttpAdapter adapter;

  FakeHttpAdapter adapterFor({required String userInfo, required String profile}) => FakeHttpAdapter({
        'GET /api/v1/dashboard/user/info/': (_) => FakeResponse(200, loadFixture(userInfo)),
        'GET /api/v1/dashboard/mentor/status/': (_) => FakeResponse(200, loadFixture('dev/mentor_status')),
        'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture(profile)),
        'GET /api/v1/dashboard/home/learner/summary/': (_) => FakeResponse(200, loadFixture('dev/learner_summary')),
        'GET /api/v1/leaderboard/students/': (_) => FakeResponse(200, loadFixture('dev/leaderboard_students')),
        'GET /api/v1/dashboard/events/featured/': (_) => FakeResponse(200, loadFixture('dev/events_featured')),
        _overview: (_) => FakeResponse(200, loadFixture('dev/mentor_overview')),
        'GET /api/v1/dashboard/campus/home-summary/': (_) => FakeResponse(200, loadFixture('dev/campus_home_summary')),
        'GET /api/v1/notification/unread-count/': (_) => const FakeResponse(200, {
              'hasError': false,
              'statusCode': 200,
              'message': {'general': <String>[]},
              'response': {'unread_count': 0},
            }),
      });

  Future<GoRouter> pump(WidgetTester tester, Widget screen) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      discordAuthUriProvider.overrideWithValue(Uri.parse('https://discord.com/oauth2/authorize?client_id=1')),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/s', routes: [
      GoRoute(path: '/s', builder: (_, __) => screen),
      GoRoute(path: '/mentor', builder: (_, __) => const Text('mentor hub')),
      GoRoute(path: '/campus', builder: (_, __) => const Text('campus overview')),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    return router;
  }

  testWidgets('Home shows an approved mentor their workspace with the upcoming count', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info_mentor', profile: 'dev/user_profile_mentor');
    await pump(tester, const HomeScreen());

    expect(find.text('Mentor workspace'), findsOneWidget);
    expect(find.text('2 upcoming sessions'), findsOneWidget);

    await tester.tap(find.text('Mentor workspace'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('mentor hub'), findsOneWidget);
  });

  testWidgets('the card stays when its count fails to load', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info_mentor', profile: 'dev/user_profile_mentor');
    adapter.routes[_overview] = (_) => const FakeResponse(-1, null);
    await pump(tester, const HomeScreen());

    expect(find.text('Mentor workspace'), findsOneWidget);
    expect(find.text('Sessions, requests and availability'), findsOneWidget);
  });

  testWidgets('a learner has no workspace card and Home makes no mentor call', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info', profile: 'dev/user_profile');
    await pump(tester, const HomeScreen());

    expect(find.text('Mentor workspace'), findsNothing);
    expect(adapter.requests.where((r) => r.uri.path.startsWith('/api/v1/dashboard/mentor/overview')), isEmpty);
  });

  testWidgets('Home shows a verified campus lead their campus with its headline', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info_campuslead', profile: 'dev/user_profile_campuslead');
    await pump(tester, const HomeScreen());

    expect(find.text('Campus workspace'), findsOneWidget);
    expect(find.text('SJC · Active members 16'), findsOneWidget);
    expect(find.text('Mentor workspace'), findsNothing);

    await tester.tap(find.text('Campus workspace'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('campus overview'), findsOneWidget);
  });

  testWidgets('Profile lists the campus workspace for an enabler', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info_enabler', profile: 'dev/user_profile_enabler');
    await pump(tester, const Scaffold(body: WorkspaceLinks()));

    expect(find.text('Campus workspace'), findsOneWidget);
    expect(find.text('My campuses'), findsOneWidget, reason: 'enablers review their campuses');
  });

  // User, 2026-11-13: "remember a user can have multiple roles".
  group('one person with several roles', () {
    Map<String, dynamic> withRoles(String fixture, List<String> roles, {List<Map<String, Object>>? verification}) {
      final body = loadFixture(fixture);
      final response = Map<String, dynamic>.of(body['response'] as Map<String, dynamic>);
      if (fixture.contains('user_info')) response['roles'] = roles;
      if (verification != null) response['role_verification'] = verification;
      return {...body, 'response': response};
    }

    FakeHttpAdapter everyRole({bool enablerVerified = true}) {
      final a = adapterFor(userInfo: 'dev/user_info_campuslead', profile: 'dev/user_profile_campuslead');
      a.routes['GET /api/v1/dashboard/user/info/'] =
          (_) => FakeResponse(200, withRoles('dev/user_info_campuslead', ['Student', 'Mentor', 'Campus Lead', 'Enabler']));
      a.routes['GET /api/v1/dashboard/profile/user-profile/'] = (_) => FakeResponse(
            200,
            withRoles('dev/user_profile_campuslead', const [], verification: [
              {'role': 'Student', 'is_verified': true},
              {'role': 'Mentor', 'is_verified': false},
              {'role': 'Campus Lead', 'is_verified': true},
              {'role': 'Enabler', 'is_verified': enablerVerified},
            ]),
          );
      return a;
    }

    testWidgets('Home shows both the mentor and the campus workspace', (tester) async {
      adapter = everyRole();
      await pump(tester, const HomeScreen());

      expect(find.text('Mentor workspace'), findsOneWidget);
      expect(find.text('Campus workspace'), findsOneWidget);
    });

    testWidgets('Profile lists every workspace the person has', (tester) async {
      adapter = everyRole();
      await pump(tester, const Scaffold(body: WorkspaceLinks()));

      expect(find.text('Mentor workspace'), findsOneWidget);
      expect(find.text('Campus workspace'), findsOneWidget);
      expect(find.text('My campuses'), findsOneWidget);
    });
  });

  testWidgets('Profile lists the mentor workspace under Workspaces', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info_mentor', profile: 'dev/user_profile_mentor');
    await pump(tester, const Scaffold(body: WorkspaceLinks()));

    expect(find.text('WORKSPACES'), findsOneWidget);
    await tester.tap(find.text('Mentor workspace'));
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('mentor hub'), findsOneWidget);
  });

  testWidgets('Profile lists nothing for a learner', (tester) async {
    adapter = adapterFor(userInfo: 'dev/user_info', profile: 'dev/user_profile');
    await pump(tester, const Scaffold(body: WorkspaceLinks()));

    expect(find.text('WORKSPACES'), findsNothing);
  });
}
