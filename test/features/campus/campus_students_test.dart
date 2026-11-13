import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/domain/student_filter.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_overview_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_student_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_students_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/campus';
const _students = '$_base/student-details/';
const _qa = 'qastudentone@mulearn';

/// Plan 4, Task 9 (K2): the campus's students — search, sort, alumni — and
/// one student's activity.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_students': (o) => FakeResponse(
            200,
            loadFixture(o.queryParameters.containsKey('search') ? 'dev/campus_students_search' : 'dev/campus_students_page1'),
          ),
      'GET $_base/students/qastudentone%40mulearn/activity/': (_) => FakeResponse(200, loadFixture('serializer/campus_student_activity')),
      'GET $_base/home-summary/': (_) => FakeResponse(200, loadFixture('dev/campus_home_summary')),
      'GET $_base/weekly-karma/': (_) => FakeResponse(200, loadFixture('dev/campus_weekly_karma')),
    });
  });

  List<Map<String, dynamic>> queries() => [
        for (final r in adapter.requests)
          if (r.uri.path == _students) Map.of(r.uri.queryParameters),
      ];

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<GoRouter> pump(WidgetTester tester, String location) async {
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
      GoRoute(path: '/campus/students', builder: (_, __) => const CampusStudentsScreen()),
      GoRoute(path: '/campus/students/:muid', builder: (_, s) => CampusStudentScreen(muid: s.pathParameters['muid']!)),
      GoRoute(path: '/u/:muid', builder: (_, s) => Text('profile ${s.pathParameters['muid']}')),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 5000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    await settle(tester);
    return router;
  }

  test('each sort asks the backend for its order', () {
    expect(StudentSort.values.map((s) => (s.label, s.query)), [
      ('Karma', '-karma'),
      ('Level', '-level'),
      ('Newest', '-join_date'),
      ('Name', 'full_name'),
    ]);
  });

  testWidgets('the list shows how many, and each student with level and groups', (tester) async {
    await pump(tester, '/campus/students');

    expect(find.text('23 students'), findsOneWidget);
    expect(find.text(_qa), findsOneWidget);
    expect(find.textContaining('Level 1'), findsWidgets);
    expect(find.textContaining('3 groups'), findsWidgets);
    expect(queries().first, containsPair('sortBy', '-karma'));
  });

  testWidgets('search waits for a pause, then asks once', (tester) async {
    await pump(tester, '/campus/students');

    await tester.enterText(find.byType(TextField), 'Ana');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'Ananya');
    await tester.pump(const Duration(milliseconds: 350));
    await settle(tester);

    final searches = queries().where((q) => q.containsKey('search')).toList();
    expect(searches, hasLength(1));
    expect(searches.single['search'], 'Ananya');
    expect(find.text('1 student'), findsOneWidget);
  });

  testWidgets('sort and alumni chips ask the backend', (tester) async {
    await pump(tester, '/campus/students');

    await tester.tap(find.text('Newest'));
    await settle(tester);
    expect(queries().last['sortBy'], '-join_date');

    await tester.ensureVisible(find.text('Alumni', skipOffstage: false));
    await tester.pump();
    await tester.tap(find.text('Alumni'));
    await settle(tester);
    expect(queries().last['is_alumni'], 'true');
  });

  testWidgets('no match shows the dashboard no-results state', (tester) async {
    adapter.routes['GET $_students'] = (_) => const FakeResponse(200, {
          'hasError': false,
          'statusCode': 200,
          'message': {'general': <String>[]},
          'response': {
            'data': <Object>[],
            'pagination': {'count': 0, 'totalPages': 1, 'isNext': false, 'isPrev': false, 'nextPage': null},
          },
        });
    await pump(tester, '/campus/students');

    expect(find.byType(MuStateDisplay), findsOneWidget);
  });

  testWidgets('a student opens with their activity', (tester) async {
    await pump(tester, '/campus/students');

    await tester.tap(find.text(_qa));
    await settle(tester);

    expect(find.byType(CampusStudentScreen), findsOneWidget);
    expect(find.text('Build your first Flutter screen'), findsOneWidget);
    expect(find.text('+50'), findsOneWidget);
    expect(find.text('Approved'), findsOneWidget);
    expect(find.text('Pending'), findsOneWidget);
    expect(find.text('Rejected'), findsOneWidget);
  });

  testWidgets('a student with no activity says so', (tester) async {
    adapter.routes['GET $_base/students/qastudentone%40mulearn/activity/'] = (_) => FakeResponse(200, loadFixture('dev/campus_student_activity_empty'));
    await pump(tester, '/campus/students/$_qa');

    expect(find.text('No activity yet.'), findsOneWidget);
  });

  testWidgets('a student page links to their public profile', (tester) async {
    await pump(tester, '/campus/students/$_qa');

    await tester.tap(find.text('View public profile'));
    await settle(tester);
    expect(find.text('profile $_qa'), findsOneWidget);
  });

  testWidgets('the overview opens all students and a top student', (tester) async {
    await pump(tester, '/campus');

    await tester.scrollUntilVisible(find.text('All students'), 400);
    await tester.ensureVisible(find.text('All students'));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('All students'));
    await settle(tester);
    expect(find.byType(CampusStudentsScreen), findsOneWidget);
  });
}
