import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_groups_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_overview_screen.dart';
import 'package:mulearn_app/features/campus/presentation/widgets/campus_chapter_widgets.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/campus';

// Dev had no IG chapters on 2026-11-16 (campus_ig_chapters_empty.json), so
// these rows are SYNTHETIC, field for field from CampusIGChapterListSerializer
// (api/dashboard/campus/serializers.py, origin/dev).
Map<String, dynamic> _chapter(
  String id,
  String ig,
  String code, {
  required int members,
  String? lead,
  String? coLead,
  bool active = true,
}) => {
  'id': id,
  'ig_id': 'ig-$id',
  'ig_name': ig,
  'ig_code': code,
  'ig_icon': null,
  'ig_cover_image': null,
  'ig_icon_image': null,
  'lead_id': lead == null ? null : 'lead-$id',
  'lead_name': lead,
  'co_lead_id': coLead == null ? null : 'co-$id',
  'co_lead_name': coLead,
  'description': 'Builds things together',
  'icon_link': null,
  'is_active': active,
  'campus_ig_member_count': members,
};

Map<String, dynamic> _ok(Object? response, [String message = '']) => {
  'hasError': false,
  'statusCode': 200,
  'message': {
    'general': [if (message.isNotEmpty) message],
  },
  'response': response,
};

/// Plan 4, Task 10 (K3): the campus's circles and IG chapters. Chapters are
/// the campus's own (`ig-chapters/`, as on the dashboard's Campus Manage IG
/// tab), never the global interest groups (`campus/igs/`).
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_base/learning-circles/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_circles_page1')),
      'GET $_base/ig-chapters/': (_) => FakeResponse(
        200,
        _ok([
          _chapter('c2', 'Ui Ux', 'UIUX', members: 2, active: false),
          _chapter(
            'c1',
            'Web Development',
            'WEBDEV',
            members: 6,
            lead: 'Asha Menon',
            coLead: 'Ravi K',
          ),
        ]),
      ),
      'GET $_base/execom/search/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_execom_search')),
      'GET /api/v1/dashboard/ig/list/': (_) => FakeResponse(
        200,
        _ok({
          'interestGroup': [
            {'id': 'ig-c1', 'name': 'Web Development'},
            {'id': 'ig-ai', 'name': 'AI'},
          ],
        }),
      ),
      'POST $_base/ig-chapters/': (_) =>
          FakeResponse(200, _ok(null, 'IG Chapter created successfully')),
      'PATCH $_base/ig-chapters/c1/': (_) =>
          FakeResponse(200, _ok(null, 'IG Chapter updated successfully')),
      'DELETE $_base/ig-chapters/c1/': (_) =>
          FakeResponse(200, _ok(null, 'IG Chapter deleted successfully')),
      'GET $_base/home-summary/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_home_summary')),
      'GET $_base/weekly-karma/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_weekly_karma')),
      'GET $_base/student-details/': (_) =>
          FakeResponse(200, loadFixture('dev/campus_students_top')),
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

  Future<void> pump(
    WidgetTester tester,
    String location, {
    bool canManage = false,
  }) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, __) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 13, 9)),
        workspaceAccessProvider.overrideWith(
          (ref) async => WorkspaceAccess(
            mentor: WorkspaceState.hidden,
            campus: WorkspaceState.open,
            enablerCampuses: WorkspaceState.hidden,
            campusLead: canManage,
            campusChapters: canManage,
          ),
        ),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: location,
      routes: [
        GoRoute(
          path: '/campus',
          builder: (_, __) => const CampusOverviewScreen(),
        ),
        GoRoute(
          path: '/campus/groups',
          builder: (_, __) => const CampusGroupsScreen(),
        ),
        GoRoute(
          path: '/circles/:id',
          builder: (_, s) => Text('circle ${s.pathParameters['id']}'),
        ),
        GoRoute(
          path: '/interest-groups/:id',
          builder: (_, s) => Text('group ${s.pathParameters['id']}'),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await settle(tester);
  }

  testWidgets(
    'circles show members, meetings and when they meet, most members first',
    (tester) async {
      await pump(tester, '/campus/groups');

      expect(find.text('Full-Stack Fridays'), findsOneWidget);
      expect(
        find.text('Web Development · 4 members · 1 meeting'),
        findsOneWidget,
      );
      expect(
        find.textContaining('Next meets'),
        findsWidgets,
        reason: 'a future meeting is "next", not "last"',
      );
      expect(
        queries('$_base/learning-circles/').first['sortBy'],
        '-member_count',
      );
    },
  );

  testWidgets('a circle opens its page', (tester) async {
    await pump(tester, '/campus/groups');

    await tester.tap(find.text('Full-Stack Fridays'));
    await tester.pumpAndSettle();
    expect(
      find.text('circle 40a52b79-a820-4dfa-9a12-0bb960567a55'),
      findsOneWidget,
    );
  });

  testWidgets(
    "chapters are the campus's own, with leads and members, active first",
    (tester) async {
      await pump(tester, '/campus/groups');

      await tester.tap(find.text('IG chapters'));
      await settle(tester);
      expect(
        find.text('6 members · Lead: Asha Menon · Co-lead: Ravi K'),
        findsOneWidget,
      );
      expect(find.text('2 members · No lead yet'), findsOneWidget);
      expect(find.text('Inactive'), findsOneWidget);
      expect(
        tester.getTopLeft(find.text('Web Development')).dy,
        lessThan(tester.getTopLeft(find.text('Ui Ux')).dy),
        reason: 'active chapters first',
      );
      expect(
        adapter.requests.where((r) => r.uri.path == '$_base/igs/'),
        isEmpty,
        reason: 'never the global IGs',
      );
      expect(
        find.text('Start a chapter'),
        findsNothing,
        reason: 'only the Campus Lead and Lead Enabler manage chapters',
      );

      await tester.tap(find.text('Web Development'));
      await settle(tester);
      expect(find.text('Web Development chapter'), findsOneWidget);
      expect(find.text('Edit chapter'), findsNothing);
      await tester.tap(find.text('Open the interest group'));
      await tester.pumpAndSettle();
      expect(find.text('group ig-c1'), findsOneWidget);
    },
  );

  testWidgets(
    'the Campus Lead starts a chapter for an IG without one, with a lead from the campus',
    (tester) async {
      await pump(tester, '/campus/groups', canManage: true);
      await tester.tap(find.text('IG chapters'));
      await settle(tester);

      await tester.tap(find.text('Start a chapter'));
      await settle(tester);
      await tester.tap(find.text('Pick an interest group'));
      await settle(tester);
      expect(find.text('Web Development'), findsWidgets);
      expect(find.text('AI'), findsOneWidget);
      await tester.tap(find.text('AI'));
      await settle(tester);

      await tester.enterText(
        find.descendant(
          of: find.byType(CampusLeadPicker),
          matching: find.byType(TextField),
        ),
        'qa',
      );
      await tester.pump(const Duration(milliseconds: 400));
      await settle(tester);
      await tester.tap(find.widgetWithText(MuButton, 'Pick').first);
      await settle(tester);
      await tester.tap(find.widgetWithText(MuButton, 'Start chapter'));
      await settle(tester);

      final post = adapter.requests.lastWhere((r) => r.method == 'POST');
      expect(post.data, {'ig': 'ig-ai', 'lead': 'qacampusleadone@mulearn'});
      expect(find.text('IG Chapter created successfully'), findsOneWidget);
    },
  );

  testWidgets(
    'editing keeps the lead unless a new one is picked; removing asks first',
    (tester) async {
      await pump(tester, '/campus/groups', canManage: true);
      await tester.tap(find.text('IG chapters'));
      await settle(tester);
      await tester.tap(find.text('Web Development'));
      await settle(tester);
      await tester.tap(find.text('Edit chapter'));
      await settle(tester);

      expect(find.text('Now: Asha Menon. Search to change.'), findsOneWidget);
      await tester.tap(find.widgetWithText(MuButton, 'Save chapter'));
      await settle(tester);
      final patch = adapter.requests.lastWhere((r) => r.method == 'PATCH');
      expect(
        patch.data,
        {'description': 'Builds things together', 'is_active': true},
        reason:
            'no lead key: the backend wants a muid, and the list only has a name',
      );

      await tester.tap(find.text('Web Development'));
      await settle(tester);
      await tester.tap(find.text('Edit chapter'));
      await settle(tester);
      await tester.ensureVisible(
        find.widgetWithText(MuButton, 'Remove chapter'),
      );
      await tester.tap(find.widgetWithText(MuButton, 'Remove chapter'));
      await settle(tester);
      await tester.tap(find.widgetWithText(MuButton, 'Remove').last);
      await settle(tester);
      expect(adapter.requests.where((r) => r.method == 'DELETE'), hasLength(1));
    },
  );

  testWidgets('search asks the backend once after a pause', (tester) async {
    await pump(tester, '/campus/groups');

    await tester.enterText(find.byType(TextField), 'Flut');
    await tester.pump(const Duration(milliseconds: 350));
    await settle(tester);

    expect(queries('$_base/learning-circles/').last['search'], 'Flut');
  });

  testWidgets('no request goes to the failing members endpoints', (
    tester,
  ) async {
    await pump(tester, '/campus/groups');
    await tester.tap(find.text('IG chapters'));
    await settle(tester);

    expect(
      adapter.requests.where((r) => r.uri.path.contains('/members/')),
      isEmpty,
    );
  });

  testWidgets('the overview links to the circles and groups', (tester) async {
    await pump(tester, '/campus');

    await tester.tap(find.text('All circles and groups'));
    await settle(tester);
    expect(find.byType(CampusGroupsScreen), findsOneWidget);
  });
}
