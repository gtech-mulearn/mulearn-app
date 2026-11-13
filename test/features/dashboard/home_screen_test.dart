import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/dashboard/presentation/screens/home_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _summaryPath = '/api/v1/dashboard/home/learner/summary/';

/// Home (FEAT-05, L1): the learner summary's week, streak and next meetup,
/// a setup checklist, and readable level names (spec §13).
void main() {
  late FakeHttpAdapter adapter;
  late Map<String, dynamic> summary;
  late List<Uri> opened;

  Map<String, dynamic> withStats({int weekly = 120, int streak = 5}) {
    final body = loadFixture('dev/learner_summary');
    final response = Map<String, dynamic>.of(body['response'] as Map<String, dynamic>);
    response['stats'] = {...response['stats'] as Map<String, dynamic>, 'weekly_karma': weekly, 'streak_days': streak};
    return {...body, 'response': response};
  }

  setUp(() {
    opened = [];
    summary = withStats();
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
      'GET /api/v1/dashboard/user/info/': (_) => FakeResponse(200, loadFixture('dev/user_info')),
      'GET $_summaryPath': (_) => FakeResponse(200, summary),
      'GET /api/v1/leaderboard/students/': (_) => FakeResponse(200, loadFixture('dev/leaderboard_students')),
      'GET /api/v1/dashboard/events/featured/': (_) => FakeResponse(200, loadFixture('dev/events_featured')),
      'GET /api/v1/notification/unread-count/': (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': <String>[]},
            'response': {'unread_count': 0},
          }),
    });
  });

  Future<GoRouter> pumpHome(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      discordAuthUriProvider.overrideWithValue(Uri.parse('https://discord.com/oauth2/authorize?client_id=1')),
      openExternalProvider.overrideWithValue((uri) async {
        opened.add(uri);
        return true;
      }),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/home', routes: [
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
      GoRoute(path: '/meetings/:id', builder: (_, s) => Text('meeting ${s.pathParameters['id']}')),
      GoRoute(path: '/interest-groups', builder: (_, __) => const Text('groups')),
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

  testWidgets('levels read "Level 1", never the raw "lvl1"', (tester) async {
    await pumpHome(tester);

    expect(find.textContaining('Level 1'), findsWidgets);
    expect(find.textContaining('lvl1'), findsNothing);
  });

  testWidgets("this week's karma and the streak come from the learner summary", (tester) async {
    await pumpHome(tester);

    expect(find.text('+120 this week'), findsOneWidget);
    expect(find.text('5-day streak'), findsOneWidget);
  });

  testWidgets('no streak, no streak line', (tester) async {
    summary = withStats(streak: 0);
    await pumpHome(tester);

    expect(find.textContaining('day streak'), findsNothing);
  });

  testWidgets('the next meetup opens its meeting', (tester) async {
    final meeting = (summary['response'] as Map<String, dynamic>)['next_meeting'] as Map<String, dynamic>;
    await pumpHome(tester);

    expect(find.text('NEXT UP'), findsOneWidget);
    expect(find.text(meeting['title'] as String), findsOneWidget);
    expect(find.textContaining(meeting['circle_name'] as String), findsOneWidget);

    await tester.tap(find.text(meeting['title'] as String));
    await tester.pumpAndSettle();
    expect(find.text('meeting ${meeting['id']}'), findsOneWidget);
  });

  testWidgets('no upcoming meeting, no Next up card', (tester) async {
    summary = loadFixture('serializer/learner_summary_no_meeting');
    await pumpHome(tester);

    expect(find.text('NEXT UP'), findsNothing);
  });

  testWidgets('setup lists only what is left: Discord here, interest groups already joined', (tester) async {
    await pumpHome(tester); // dev/user_info: not in the server; dev/user_profile: 3 groups

    expect(find.text('GET SET UP'), findsOneWidget);
    expect(find.text('Connect Discord'), findsOneWidget);
    expect(find.text('Join interest groups'), findsNothing);

    await tester.tap(find.text('Connect Discord'));
    await tester.pump();
    expect(opened.single.host, 'discord.com');
  });

  testWidgets('a failed summary offers a retry and keeps the rest of Home', (tester) async {
    adapter.routes['GET $_summaryPath'] = (_) => const FakeResponse(-1, null);
    await pumpHome(tester);

    expect(find.text("Couldn't load your week"), findsOneWidget);
    expect(find.text('TOTAL KARMA'), findsOneWidget);
    expect(adapter.requests.where((RequestOptions r) => r.uri.path == _summaryPath).length, 1);
  });
}
