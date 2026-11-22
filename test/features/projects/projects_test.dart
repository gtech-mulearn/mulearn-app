import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:mulearn_app/core/moderation/blocked_users_storage.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/projects/data/projects_data.dart';
import 'package:mulearn_app/features/projects/domain/entities/project.dart';
import 'package:mulearn_app/features/projects/presentation/screens/project_detail_screen.dart';
import 'package:mulearn_app/features/projects/presentation/screens/project_form_screen.dart';
import 'package:mulearn_app/features/projects/presentation/screens/projects_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _p = '/api/v1/dashboard/projects';
const _me =
    '04afe242-e329-4491-af58-d555abd82e5f'; // QA Student One (dev/user_profile)

// Dev had no projects on 2026-11-15 (see projects_feed.json), so this row is
// SYNTHETIC, built field for field from `ProjectSerializer`
// (api/dashboard/projects/projects_serializer.py, origin/dev).
Map<String, dynamic> _project({
  String owner = _me,
  List<Map<String, dynamic>> votes = const [],
}) => {
  'id': 'p1',
  'title': 'Campus Bus Tracker',
  'description':
      'Live bus positions for the campus shuttle, built with Flutter and a tiny Django API.',
  'status': 'published',
  'logo': null,
  'images': <Object>[],
  'links': [
    {
      'id': 'l2',
      'label': 'Demo',
      'url': 'https://bus.example.org',
      'position': 1,
    },
    {
      'id': 'l1',
      'label': 'GitHub',
      'url': 'https://github.com/qa/bus',
      'position': 0,
    },
  ],
  'skills': [
    {'id': 's1', 'name': 'Flutter', 'code': 'flutter', 'icon': null},
  ],
  'members': [
    {
      'id': 'm1',
      'is_linked': false,
      'user_id': null,
      'muid': null,
      'full_name': 'Ravi (design)',
      'profile_pic': null,
      'external_name': 'Ravi (design)',
      'role': 'Design',
      'created_at': '2026-11-10T10:00:00Z',
    },
  ],
  'votes': votes,
  'comments': [
    {
      'id': 'c1',
      'comment': 'Love the map view!',
      'project': 'p1',
      'user': 'Dev Admin',
      'user_id': 'someone-else',
      'created_at': '2026-11-12T10:00:00Z',
      'updated_at': '2026-11-12T10:00:00Z',
    },
  ],
  'created_by': 'QA Student One',
  'created_by_id': owner,
  'created_by_muid': 'qastudentone@mulearn',
  'updated_by': 'QA Student One',
  'created_at': '2026-11-10T10:00:00Z',
  'updated_at': '2026-11-10T10:00:00Z',
};

/// A blocked list that starts with [saved] and keeps nothing.
class _Stored implements BlockedUsersStorage {
  const _Stored(this.saved);

  final List<BlockedUser> saved;

  @override
  Future<List<BlockedUser>> read() async => saved;

  @override
  Future<void> write(List<BlockedUser> users) async {}
}

Map<String, dynamic> _env(Object? response) => {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': response,
};

void main() {
  test('a project parses links in order, team, votes and comments', () {
    final p = ProjectsRepositoryImpl.parse(
      _project(
        votes: [
          {
            'id': 'v1',
            'vote': 'upvote',
            'project': 'p1',
            'user_id': _me,
            'created_at': '',
            'updated_at': '',
          },
        ],
      ),
    )!;
    expect(p.links.map((l) => l.label), ['GitHub', 'Demo']);
    expect(
      p.members.single.muid,
      isNull,
      reason: 'an outsider has no profile to open',
    );
    expect(p.upvotes, 1);
    expect(p.upvoteBy(_me)?.id, 'v1');
    expect(p.comments.single.authorName, 'Dev Admin');

    final empty = ProjectsRepositoryImpl.parsePage(
      loadFixtureResponse('dev/projects_feed')! as Map<String, dynamic>,
    );
    expect(empty.items, isEmpty);

    final people = ProjectsRepositoryImpl.parsePeople(
      loadFixtureResponse('dev/user_search_default_p1')!
          as Map<String, dynamic>,
    );
    expect(people, hasLength(30));
    expect(people.first.muid, isNotNull);
  });

  late FakeHttpAdapter adapter;
  late Map<String, dynamic> current;

  setUp(() {
    current = _project();
    adapter = FakeHttpAdapter({
      'GET $_p/': (_) => FakeResponse(
        200,
        _env({
          'data': {
            'Projects': [current],
          },
          'pagination': {
            'count': 1,
            'totalPages': 1,
            'isNext': false,
            'isPrev': false,
            'nextPage': null,
          },
        }),
      ),
      'GET $_p/p1/': (_) => FakeResponse(200, _env({'Project': current})),
      'POST $_p/vote/': (_) {
        current = _project(
          votes: [
            {
              'id': 'v9',
              'vote': 'upvote',
              'project': 'p1',
              'user_id': _me,
              'created_at': '',
              'updated_at': '',
            },
          ],
        );
        return FakeResponse(200, _env({'Vote': <String, Object>{}}));
      },
      'DELETE $_p/vote/v9/': (_) {
        current = _project();
        return FakeResponse(200, _env(null));
      },
      'GET /api/v1/dashboard/user/search/': (_) =>
          FakeResponse(200, loadFixture('dev/user_search_default_p1')),
      'POST $_p/p1/members/': (_) =>
          FakeResponse(200, _env({'Member': <String, Object>{}})),
      'GET /api/v1/dashboard/skill/': (_) => FakeResponse(
        200,
        _env({
          'skills': [
            {'id': 's1', 'name': 'Flutter'},
          ],
        }),
      ),
      'POST $_p/': (_) => FakeResponse(200, _env({'Project': _project()})),
    });
  });

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> pump(
    WidgetTester tester,
    String start, {
    List<BlockedUser> blocked = const [],
  }) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        blockedUsersStorageProvider.overrideWithValue(_Stored(blocked)),
        myProfilePayloadProvider.overrideWith(
          (ref) async =>
              loadFixtureResponse('dev/user_profile')! as Map<String, dynamic>,
        ),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: start,
      routes: [
        GoRoute(path: '/projects', builder: (_, _) => const ProjectsScreen()),
        GoRoute(
          path: '/projects/new',
          builder: (_, _) => const ProjectFormScreen(),
        ),
        GoRoute(
          path: '/projects/:id',
          builder: (_, s) => ProjectDetailScreen(id: s.pathParameters['id']!),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: MuThemeData.light(),
          routerConfig: router,
        ),
      ),
    );
    await settle(tester);
  }

  testWidgets(
    'a blocked person\'s comment is hidden and others offer report or block',
    (tester) async {
      await pump(tester, '/projects/p1');
      expect(find.text('Love the map view!'), findsOneWidget);
      expect(find.byTooltip('Report or block'), findsWidgets);

      await pump(
        tester,
        '/projects/p1',
        blocked: const [BlockedUser(id: 'someone-else', name: 'Dev Admin')],
      );

      expect(find.text('Love the map view!'), findsNothing);
      expect(find.text('COMMENTS · 0'), findsOneWidget);
    },
  );

  testWidgets('a blocked owner\'s project is hidden from explore', (
    tester,
  ) async {
    await pump(
      tester,
      '/projects',
      blocked: const [BlockedUser(id: _me, name: 'QA Student One')],
    );

    expect(find.text('Campus Bus Tracker'), findsNothing);
  });

  testWidgets('explore shows the card; upvote and take it back', (
    tester,
  ) async {
    await pump(tester, '/projects');
    expect(find.text('Campus Bus Tracker'), findsOneWidget);

    await tester.tap(find.text('Campus Bus Tracker'));
    await settle(tester);
    expect(find.text('Love the map view!'), findsOneWidget);
    await tester.tap(find.widgetWithText(MuButton, 'Upvote · 0'));
    await settle(tester);
    expect(find.widgetWithText(MuButton, 'Upvoted · 1'), findsOneWidget);
    await tester.tap(find.widgetWithText(MuButton, 'Upvoted · 1'));
    await settle(tester);
    expect(
      adapter.requests.where(
        (RequestOptions r) =>
            r.method == 'DELETE' && r.path.endsWith('/vote/v9/'),
      ),
      hasLength(1),
    );
    expect(find.widgetWithText(MuButton, 'Upvote · 0'), findsOneWidget);
  });

  testWidgets('the owner adds teammates by searching members, or by name', (
    tester,
  ) async {
    await pump(tester, '/projects/p1');
    await tester.tap(find.text('Add'));
    await settle(tester);
    await tester.enterText(
      find.descendant(
        of: find.byType(MuSearchField),
        matching: find.byType(TextField),
      ),
      'af',
    );
    await tester.pump(const Duration(milliseconds: 400));
    await settle(tester);
    final searched = adapter.requests.lastWhere(
      (RequestOptions r) => r.path.endsWith('/user/search/'),
    );
    expect(searched.queryParameters['search'], 'af');
    expect(find.text('afif shoufeer'), findsOneWidget);
    final inSheet = find.byType(MuFormSheet);
    expect(
      find.descendant(of: inSheet, matching: find.text('qamentorone@mulearn')),
      findsOneWidget,
    );
    expect(
      find.descendant(of: inSheet, matching: find.text('qastudentone@mulearn')),
      findsNothing,
      reason: 'the owner is already on the team',
    );

    final add = find
        .descendant(of: inSheet, matching: find.widgetWithText(MuButton, 'Add'))
        .first;
    await tester.ensureVisible(add);
    await tester.pump();
    await tester.tap(add);
    await settle(tester);
    final added = adapter.requests.lastWhere(
      (RequestOptions r) => r.method == 'POST' && r.path.endsWith('/members/'),
    );
    expect((added.data as Map)['muid'], isNotNull);
    expect((added.data as Map).containsKey('external_name'), isFalse);
  });

  testWidgets('a new project needs a real description and two links', (
    tester,
  ) async {
    await pump(tester, '/projects/new');
    await tester.enterText(find.byType(TextField).at(0), 'Bus Tracker');
    await tester.enterText(find.byType(TextField).at(1), 'Too short');
    await tester.tap(find.widgetWithText(MuButton, 'Save draft'));
    await settle(tester);
    expect(find.textContaining('at least 50 characters'), findsOneWidget);
    expect(find.textContaining('Add at least two links'), findsOneWidget);
    expect(
      adapter.requests.where((RequestOptions r) => r.method == 'POST'),
      isEmpty,
    );

    await tester.enterText(
      find.byType(TextField).at(1),
      'Live bus positions for the campus shuttle, built with Flutter and Django.',
    );
    await tester.enterText(find.byType(TextField).at(3), 'github.com/qa/bus');
    await tester.enterText(find.byType(TextField).at(5), 'bus.example.org');
    await tester.tap(find.text('Flutter'));
    await tester.tap(find.widgetWithText(MuButton, 'Save draft'));
    await settle(tester);
    final post = adapter.requests.lastWhere(
      (RequestOptions r) => r.method == 'POST' && r.path == '$_p/',
    );
    final fields = {
      for (final f in (post.data as FormData).fields) f.key: f.value,
    };
    expect(fields['status'], 'draft');
    expect(fields['links_json'], contains('https://github.com/qa/bus'));
    expect(fields['skill_ids_json'], '["s1"]');
    expect(find.byType(ProjectDetailScreen), findsOneWidget);
  });

  test('a draft with no picked pictures sends no files', () {
    final form = ProjectsRepositoryImpl.form(
      const ProjectDraft(
        title: 't',
        description: 'd',
        status: ProjectStatus.published,
        links: [(label: 'a', url: 'https://a.org')],
        skillIds: [],
      ),
    );
    expect(form.files, isEmpty);
  });
}
