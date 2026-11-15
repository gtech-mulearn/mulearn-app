import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/campus_profile/data/campus_profile_data.dart';
import 'package:mulearn_app/features/campus_profile/presentation/screens/public_campus_screen.dart';
import 'package:mulearn_app/features/search/presentation/screens/search_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _sjc = 'ad3a3793-d780-4ec1-b03e-fac92e0faa0d';

/// CampusDetailsPublicAPI (`campus/<org_id>/`), WeeklyKarmaAPI
/// (`campus/weekly-karma/<org_id>/`) and InstitutionAPI
/// (`organisation/institutes/<college|school>/`), recorded on dev
/// 2026-11-15 (St. Josephs, SJC).
void main() {
  test('the public campus parses its numbers, people and clusters', () {
    final c = CampusProfileRepositoryImpl.parse(
      _sjc,
      loadFixtureResponse('dev/campus_public_detail')! as Map<String, dynamic>,
    );
    expect(c.name, 'St. Josephs Colege of Engineering and Technology');
    expect(c.code, 'SJC');
    expect(c.members, 24);
    expect(c.activeMembers, 17);
    expect(c.rank, 1);
    expect(c.lead?.fullName, 'QA Campus Lead One');
    expect(c.topLearners, hasLength(10));
    expect(c.clusters.map((x) => x.cluster), containsAll(['coder', 'maker', 'unclustered']));

    final week = CampusProfileRepositoryImpl.parseWeekly(
      loadFixtureResponse('dev/campus_public_weekly_karma')! as Map<String, dynamic>,
    );
    expect(week, hasLength(7));
    expect(week.first.day.isBefore(week.last.day), isTrue, reason: 'oldest first');
  });

  late FakeHttpAdapter adapter;

  Future<void> pump(WidgetTester tester, String start) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [dioProvider.overrideWithValue(fakeDio(adapter)), tokenStorageProvider.overrideWithValue(tokens)],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: start,
      routes: [
        GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
        GoRoute(
          path: '/campuses/:id',
          builder: (_, s) => PublicCampusScreen(campusId: s.pathParameters['id']!),
        ),
        GoRoute(path: '/u/:muid', builder: (_, s) => Text('profile ${s.pathParameters['muid']}')),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 8000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: MuThemeData.light(), routerConfig: router),
      ),
    );
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/campus/$_sjc/': (_) => FakeResponse(200, loadFixture('dev/campus_public_detail')),
      'GET /api/v1/dashboard/campus/weekly-karma/$_sjc/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_public_weekly_karma')),
      'GET /api/v1/dashboard/organisation/institutes/college/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_search_college')),
      'GET /api/v1/dashboard/organisation/institutes/school/': (_) => const FakeResponse(500, {'detail': 'boom'}),
    });
  });

  testWidgets('a campus page shows who it is and opens its learners', (tester) async {
    await pump(tester, '/campuses/$_sjc');

    expect(find.text('St. Josephs Colege of Engineering and Technology'), findsOneWidget);
    expect(find.bySemanticsLabel('Learners, 24'), findsOneWidget);
    expect(find.text('#1 on the campus leaderboard'), findsOneWidget);
    expect(find.text('QA Campus Lead One'), findsOneWidget);
    expect(find.text('No karma earned at this campus this week yet.'), findsOneWidget);

    await tester.tap(find.text('Dev Admin'));
    await tester.pumpAndSettle();
    expect(find.text('profile admin@mulearn'), findsOneWidget);
  });

  testWidgets('campus search finds colleges even when schools fail, and opens the campus', (tester) async {
    await pump(tester, '/search');

    await tester.tap(find.text('Campuses'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Joseph');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    final hits = adapter.requests.map((RequestOptions r) => r.uri.path).toList();
    expect(hits, contains('/api/v1/dashboard/organisation/institutes/college/'));
    expect(hits, contains('/api/v1/dashboard/organisation/institutes/school/'));
    expect(find.text('St. Josephs Colege of Engineering and Technology'), findsOneWidget);

    await tester.tap(find.text('St. Josephs Colege of Engineering and Technology'));
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.byType(PublicCampusScreen), findsOneWidget);
  });
}
