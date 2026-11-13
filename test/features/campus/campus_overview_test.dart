import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/campus/data/dtos/campus_dtos.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_overview_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/campus';

/// Plan 4, Task 8 (K1): the campus overview for Campus Leads, Lead Enablers
/// and Enablers, from `campus/home-summary/`, `weekly-karma/` and the top of
/// `student-details/`.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_base/home-summary/': (_) => FakeResponse(200, loadFixture('dev/campus_home_summary')),
      'GET $_base/weekly-karma/': (_) => FakeResponse(200, loadFixture('dev/campus_weekly_karma')),
      'GET $_base/student-details/': (_) => FakeResponse(200, loadFixture('dev/campus_students_top')),
    });
  });

  Future<GoRouter> pump(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 13, 9)),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/campus', routes: [
      GoRoute(path: '/campus', builder: (_, __) => const CampusOverviewScreen()),
      GoRoute(path: '/circles/:id', builder: (_, s) => Text('circle ${s.pathParameters['id']}')),
      GoRoute(path: '/u/:muid', builder: (_, s) => Text('profile ${s.pathParameters['muid']}')),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    return router;
  }

  group('parsing the recorded campus', () {
    test('the summary: campus, stats, funnel, circle health, activity', () {
      final s = parseCampusSummary(loadFixtureResponse('dev/campus_home_summary')! as Map<String, dynamic>);
      expect(s.collegeName, 'St. Josephs Colege of Engineering and Technology');
      expect((s.campusCode, s.zone), ('SJC', 'Central Zone'));
      expect(s.stats.map((c) => c.label), ['Active members', 'Karma', 'Circles', 'Campus rank']);
      expect(s.stats.first.value, 16);
      expect(s.stats.last.value, isNull, reason: 'rank can be null');
      expect(s.funnel.map((f) => f.label), contains('Level 2+'));
      expect(s.circleHealth, hasLength(14));
      expect(s.circleHealth.map((c) => c.status).toSet(), {'active', 'inactive', 'slow'});
      expect(s.recentActivity, isNotEmpty);
      expect(s.recentActivity.first.createdAt.isUtc, isTrue);
    });

    test('weekly karma keeps the days in order and ignores the college name', () {
      final week = parseWeeklyKarma(loadFixtureResponse('dev/campus_weekly_karma')! as Map<String, dynamic>);
      expect(week, hasLength(7));
      expect(week.first.day, DateTime(2026, 11, 7));
      expect(week.last.day, DateTime(2026, 11, 13));
    });

    test('a student row parses, join dates with a space included', () {
      final rows = (loadFixtureResponse('dev/campus_students_top')! as Map)['data'] as List;
      final s = CampusStudentDto.fromJson(rows.first as Map<String, dynamic>).toDomain();
      expect(s.level, 'lvl1');
      expect(s.igCount, 3);
      expect(s.joinedAt, DateTime.utc(2026, 11, 12, 15, 18, 39));
    });
  });

  test('ages read the way people say them', () {
    final now = DateTime(2026, 11, 13, 9);
    expect(formatAgo(now.subtract(const Duration(seconds: 20)), now), 'Just now');
    expect(formatAgo(now.subtract(const Duration(minutes: 5)), now), '5 min ago');
    expect(formatAgo(now.subtract(const Duration(hours: 3)), now), '3h ago');
    expect(formatAgo(DateTime(2026, 11, 12, 20), now), 'Yesterday');
    expect(formatAgo(DateTime(2026, 11, 2, 9), now), 'Mon 2 Nov');
  });

  testWidgets('the overview shows the campus, its numbers and what needs attention', (tester) async {
    await pump(tester);

    expect(find.text('St. Josephs Colege of Engineering and Technology'), findsOneWidget);
    expect(find.text('SJC · Central Zone'), findsOneWidget);
    expect(find.text('ACTIVE MEMBERS'), findsOneWidget);
    expect(find.text('16'), findsWidgets);
    expect(find.text('+16 in 30 days'), findsOneWidget);
    expect(find.text('—'), findsOneWidget, reason: 'a null rank');
    expect(find.text('Level 2+'), findsOneWidget);
    expect(find.textContaining('slow'), findsWidgets);
    expect(find.text('No karma earned this week yet.'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Quantum Computing Basics created'), 400);
    expect(find.text('Quantum Computing Basics created'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('TOP STUDENTS'), 400);
    expect(find.text('TOP STUDENTS'), findsOneWidget);
    await tester.pump(const Duration(seconds: 2)); // the scroll settles
  });

  testWidgets('a circle that needs attention opens its page', (tester) async {
    await pump(tester);

    await tester.tap(find.text('Blender: Donut to Diorama'));
    await tester.pumpAndSettle();
    expect(find.text('circle 217cd8ca-d6a3-4e75-9621-036c057f7ecd'), findsOneWidget);
  });

  testWidgets('a top student opens their profile', (tester) async {
    await pump(tester);

    await tester.scrollUntilVisible(find.text('qastudentone@mulearn'), 400);
    await tester.ensureVisible(find.text('qastudentone@mulearn'));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('qastudentone@mulearn'));
    await tester.pumpAndSettle();
    expect(find.text('profile qastudentone@mulearn'), findsOneWidget);
  });
}
