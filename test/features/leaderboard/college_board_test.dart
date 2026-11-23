import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/leaderboard/presentation/screens/leaderboard_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

Map<String, dynamic> _ok(Object response) => {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': response,
};

/// The fixture user's college (dev/user_profile `college_id`, code SJC).
const _mine = 'ad3a3793-d780-4ec1-b03e-fac92e0faa0d';

const _allTime = [
  {
    'id': 'c1',
    'code': 'MBT',
    'title': 'Mar Baselios College of Engineering and Technology',
    'total_karma': 4200413,
    'total_students': 2671,
  },
  {
    'id': _mine,
    'code': 'SJC',
    'title': 'ST JOSEPHS COLLEGE OF ENGINEERING AND TECHNOLOGY PALAI',
    'total_karma': 3027145,
    'total_students': 2469,
  },
  {
    'id': 'c3',
    'code': 'MCE',
    'title': 'MARIAN ENGINEERING COLLEGE',
    'total_karma': 1249700,
    'total_students': 1947,
  },
  {
    'id': 'c4',
    'code': 'AWH',
    'title': 'AWH ENGINEERING COLLEGE',
    'total_karma': 894306,
    'total_students': 1240,
  },
  {
    'code': 'PEC',
    'title': 'COLLEGE OF ENGINEERING PATHANAPURAM',
    'total_karma': 778307,
    'total_students': 1,
  },
];

/// The Colleges tab (layout A, 2026-11-23): whole names, every college
/// opens its campus page, the viewer's college is tagged.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/profile/user-profile/': (_) =>
          FakeResponse(200, loadFixture('dev/user_profile')),
      'GET /api/v1/dashboard/user/info/': (_) =>
          FakeResponse(200, loadFixture('dev/user_info')),
      'GET ${ApiPaths.studentLeaderboard}': (_) =>
          FakeResponse(200, _ok(<Object>[])),
      'GET ${ApiPaths.studentLeaderboardMonthly}': (_) =>
          FakeResponse(200, _ok(<Object>[])),
      'GET ${ApiPaths.collegeLeaderboard}': (_) =>
          FakeResponse(200, _ok(_allTime)),
      'GET ${ApiPaths.collegeLeaderboardMonthly}': (_) => FakeResponse(
        200,
        _ok([
          {
            'id': 'm1',
            'code': 'CHN',
            'title': 'COLLEGE OF ENGINEERING CHENGANNUR',
            'total_karma': 21145,
            'students': 18,
          },
        ]),
      ),
    });
  });

  Future<GoRouter> pump(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, __) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        cacheStoreProvider.overrideWithValue(MemCacheStore()),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/s',
      routes: [
        GoRoute(path: '/s', builder: (_, __) => const LeaderboardScreen()),
        GoRoute(
          path: '/campuses/:id',
          builder: (_, state) => Text('campus ${state.pathParameters['id']}'),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await settle(tester);
    await tester.tap(find.text('Colleges'));
    await settle(tester);
    return router;
  }

  testWidgets('college names show in full and normal case', (tester) async {
    await pump(tester);

    final name = find.text(
      'St Josephs College of Engineering and Technology Palai',
    );
    expect(name, findsOneWidget);
    expect(tester.widget<Text>(name).maxLines, isNull);
    expect(
      find.text('ST JOSEPHS COLLEGE OF ENGINEERING AND TECHNOLOGY PALAI'),
      findsNothing,
    );
  });

  testWidgets('tapping a college opens its campus page', (tester) async {
    await pump(tester);
    await tester.tap(find.text('AWH Engineering College'));
    await settle(tester);

    expect(find.text('campus c4'), findsOneWidget);
  });

  testWidgets('a college without an id does not open', (tester) async {
    final router = await pump(tester);
    expect(
      find.text('778,307 karma · 1 learner', findRichText: true),
      findsOneWidget,
    );
    await tester.tap(find.text('College of Engineering Pathanapuram'));
    await settle(tester);

    expect(router.routerDelegate.currentConfiguration.uri.path, '/s');
  });

  testWidgets('your campus is tagged', (tester) async {
    await pump(tester);

    expect(find.text('Your campus'), findsOneWidget);
  });

  testWidgets('this month counts active learners', (tester) async {
    await pump(tester);
    await tester.tap(find.text('This month'));
    await settle(tester);

    expect(
      find.textContaining('18 active learners', findRichText: true),
      findsOneWidget,
    );
  });
}

/// Network replies and route pushes without waiting on endless spinners.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}
