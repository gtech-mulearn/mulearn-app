import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/app/widgets/not_found_screen.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/interest_groups/presentation/screens/interest_groups_screen.dart';
import 'package:mulearn_app/features/leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/public_profile_screen.dart';
import 'package:mulearn_app/features/search/presentation/screens/search_screen.dart';
import 'package:mulearn_app/features/tasks/presentation/screens/task_detail_screen.dart';
import 'package:mulearn_app/features/tasks/presentation/screens/tasks_screen.dart';

import '../support/fake_http_adapter.dart';
import '../support/fake_secure_storage.dart';
import '../support/fixtures.dart';

Map<String, dynamic> _ok(Object response) => {
      'hasError': false,
      'statusCode': 200,
      'message': {'general': <String>[]},
      'response': response,
    };

/// Illustrated empty states use the dashboard's StateDisplay variants and
/// the dashboard's copy for the same screen (user, 2026-11-13).
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
      'GET /api/v1/dashboard/user/info/': (_) => FakeResponse(200, loadFixture('dev/user_info')),
    });
  });

  Future<GoRouter> pump(WidgetTester tester, Widget screen, {double width = 1080}) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      cacheStoreProvider.overrideWithValue(MemCacheStore()),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/s', routes: [
      GoRoute(path: '/s', builder: (_, __) => screen),
      GoRoute(path: '/home', builder: (_, __) => const Text('home')),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = Size(width, 3000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    return router;
  }

  MuStateVariant variantShown(WidgetTester tester) => tester.widget<MuStateDisplay>(find.byType(MuStateDisplay)).variant;

  group('Tasks (the dashboard μJourney rule)', () {
    setUp(() {
      adapter.routes['GET /api/v1/dashboard/task/list/'] =
          (_) => FakeResponse(200, _ok({'start_journey': <Object>[], 'become_expert': <Object>[], 'events': <Object>[]}));
    });

    testWidgets('no tasks at all shows "No tasks available"', (tester) async {
      await pump(tester, const TasksScreen());

      expect(variantShown(tester), MuStateVariant.noTasks);
      expect(find.text('No tasks available'), findsOneWidget);
    });

    testWidgets('a filter with no tasks shows the no-results state', (tester) async {
      await pump(tester, const TasksScreen());
      await tester.tap(find.text('Start your journey'));
      await tester.pump(const Duration(milliseconds: 100));

      expect(variantShown(tester), MuStateVariant.noResults);
      expect(find.text('Nothing here. Yet.'), findsOneWidget);
    });
  });

  testWidgets('an unknown task is a not-found state', (tester) async {
    adapter.routes['GET /api/v1/dashboard/task/list/'] = (_) => FakeResponse(200, loadFixture('dev/task_list'));
    await pump(tester, const TaskDetailScreen(taskId: 'no-such-task'));

    expect(variantShown(tester), MuStateVariant.notFound);
    expect(find.text('Task not found'), findsOneWidget);
  });

  testWidgets('a search with no matches uses the dashboard copy', (tester) async {
    adapter.routes['GET /api/v1/dashboard/user/search/'] = (_) => FakeResponse(
          200,
          _ok({
            'data': <Object>[],
            'pagination': {'count': 0, 'totalPages': 1, 'isNext': false, 'isPrev': false, 'nextPage': null},
          }),
        );
    await pump(tester, const SearchScreen());
    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(variantShown(tester), MuStateVariant.noResults);
    expect(find.text('No members match "zzz". Try a different path and keep exploring.'), findsOneWidget);
  });

  testWidgets('no interest groups says to check back later', (tester) async {
    adapter.routes['GET /api/v1/dashboard/ig/list/'] = (_) => FakeResponse(200, _ok({'interestGroup': <Object>[]}));
    await pump(tester, const InterestGroupsScreen());

    expect(variantShown(tester), MuStateVariant.noResults);
    expect(find.text('Check back later for new groups'), findsOneWidget);
  });

  testWidgets('an empty leaderboard shows the no-results state', (tester) async {
    adapter.routes['GET /api/v1/leaderboard/students/'] = (_) => FakeResponse(200, loadFixture('dev/leaderboard_students'));
    adapter.routes['GET /api/v1/leaderboard/college/'] = (_) => FakeResponse(200, _ok(<Object>[]));
    // 480 dp: the header row's own overflow at 360 dp (test font) is logged
    // separately; this test is about the empty state.
    await pump(tester, const LeaderboardScreen(), width: 1440);

    expect(find.byType(MuStateDisplay), findsWidgets);
    expect(find.text('Nothing here. Yet.'), findsWidgets);
  });

  testWidgets('a private or missing profile uses the dashboard copy', (tester) async {
    adapter.routes['GET /api/v1/dashboard/profile/user-profile/someone@mulearn/'] = (_) => const FakeResponse(400, {
          'hasError': true,
          'statusCode': 400,
          'message': {'general': ['This profile is private']},
          'response': <String, dynamic>{},
        });
    await pump(tester, const PublicProfileScreen(muid: 'someone@mulearn'));

    expect(variantShown(tester), MuStateVariant.notFound);
    expect(find.text('Profile not found'), findsOneWidget);
    expect(find.text('The requested profile could not be found or is private.'), findsOneWidget);
  });

  testWidgets('an unknown route shows the not-found state with a way home', (tester) async {
    await pump(tester, const NotFoundScreen());

    expect(variantShown(tester), MuStateVariant.notFound);
    expect(find.text('Looks like you wandered off the path.'), findsOneWidget);
    await tester.tap(find.text('Back to Home'));
    await tester.pumpAndSettle();
    expect(find.text('home'), findsOneWidget);
  });
}
