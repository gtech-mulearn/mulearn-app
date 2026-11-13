import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_groups_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_overview_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/campus';

/// Plan 4, Task 10 (K3): the campus's circles and interest groups. Rows open
/// the existing circle and group pages; the `<id>/members/` endpoints (500 on
/// dev) are never called.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_base/learning-circles/': (_) => FakeResponse(200, loadFixture('dev/campus_circles_page1')),
      'GET $_base/igs/': (_) => FakeResponse(200, loadFixture('dev/campus_igs_page1')),
      'GET $_base/home-summary/': (_) => FakeResponse(200, loadFixture('dev/campus_home_summary')),
      'GET $_base/weekly-karma/': (_) => FakeResponse(200, loadFixture('dev/campus_weekly_karma')),
      'GET $_base/student-details/': (_) => FakeResponse(200, loadFixture('dev/campus_students_top')),
    });
  });

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  List<Map<String, dynamic>> queries(String path) => [
        for (final r in adapter.requests)
          if (r.uri.path == path) Map.of(r.uri.queryParameters),
      ];

  Future<void> pump(WidgetTester tester, String location) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 13, 9)),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: location, routes: [
      GoRoute(path: '/campus', builder: (_, __) => const CampusOverviewScreen()),
      GoRoute(path: '/campus/groups', builder: (_, __) => const CampusGroupsScreen()),
      GoRoute(path: '/circles/:id', builder: (_, s) => Text('circle ${s.pathParameters['id']}')),
      GoRoute(path: '/interest-groups/:id', builder: (_, s) => Text('group ${s.pathParameters['id']}')),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    await settle(tester);
  }

  testWidgets('circles show members, meetings and when they meet, most members first', (tester) async {
    await pump(tester, '/campus/groups');

    expect(find.text('Full-Stack Fridays'), findsOneWidget);
    expect(find.text('Web Development · 4 members · 1 meeting'), findsOneWidget);
    expect(find.textContaining('Next meets'), findsWidgets, reason: 'a future meeting is "next", not "last"');
    expect(queries('$_base/learning-circles/').first['sortBy'], '-member_count');
  });

  testWidgets('a circle opens its page', (tester) async {
    await pump(tester, '/campus/groups');

    await tester.tap(find.text('Full-Stack Fridays'));
    await tester.pumpAndSettle();
    expect(find.text('circle 40a52b79-a820-4dfa-9a12-0bb960567a55'), findsOneWidget);
  });

  testWidgets('interest groups show members from this campus and open their page', (tester) async {
    await pump(tester, '/campus/groups');

    await tester.tap(find.text('Interest groups'));
    await settle(tester);
    expect(find.text('6 members from your campus'), findsOneWidget);
    expect(find.text('WEBDEV'), findsOneWidget);

    await tester.tap(find.text('Web Development'));
    await tester.pumpAndSettle();
    expect(find.text('group 4ff0a5e5-d1ef-44dd-ac13-9a2f9e7717e3'), findsOneWidget);
  });

  testWidgets('search asks the backend once after a pause', (tester) async {
    await pump(tester, '/campus/groups');

    await tester.enterText(find.byType(TextField), 'Flut');
    await tester.pump(const Duration(milliseconds: 350));
    await settle(tester);

    expect(queries('$_base/learning-circles/').last['search'], 'Flut');
  });

  testWidgets('no request goes to the failing members endpoints', (tester) async {
    await pump(tester, '/campus/groups');
    await tester.tap(find.text('Interest groups'));
    await settle(tester);

    expect(adapter.requests.where((r) => r.uri.path.contains('/members/')), isEmpty);
  });

  testWidgets('the overview links to the circles and groups', (tester) async {
    await pump(tester, '/campus');

    await tester.tap(find.text('All circles and groups'));
    await settle(tester);
    expect(find.byType(CampusGroupsScreen), findsOneWidget);
  });
}
