import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/domain/task_submission.dart';
import 'package:mulearn_app/features/tasks/presentation/screens/tasks_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

Map<String, dynamic> _task(
  String title,
  String hashtag,
  String? level, {
  String? ig,
  bool done = false,
}) => {
  'id': hashtag,
  'hashtag': hashtag,
  'title': title,
  'description': 'Brief',
  'karma': 100,
  'channel': 'task-dropbox',
  'discord_id': null,
  'type': 'Hashtag Task',
  'variable_karma': false,
  'level': level,
  'ig': ig,
  'event': null,
  'event_id': null,
  'company_name': null,
  'completed': done,
};

void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/profile/user-profile/': (_) =>
          FakeResponse(200, loadFixture('dev/user_profile')),
      'GET /api/v1/dashboard/user/info/': (_) =>
          FakeResponse(200, loadFixture('dev/user_info')),
      'GET /api/v1/dashboard/task/list/': (_) => FakeResponse(200, {
        'hasError': false,
        'statusCode': 200,
        'message': {'general': <String>[]},
        'response': {
          'start_journey': [
            _task('Introduce yourself', '#seed-gen-l1-1', 'lvl1', done: true),
            _task('Join a learning circle', '#seed-gen-l2-2', 'lvl2'),
            _task('Lead a campus initiative', '#seed-gen-l7-1', 'lvl7'),
          ],
          'become_expert': [
            _task(
              'Build a React to-do list',
              '#seed-web-l2-1',
              'lvl2',
              ig: 'Web Development',
            ),
            _task('Explain AI vs ML', '#seed-ai-l1-1', 'lvl1', ig: 'AI'),
          ],
          'events': <Object>[],
        },
      }),
    });
  });

  Future<void> pump(WidgetTester tester) async {
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
      routes: [GoRoute(path: '/s', builder: (_, __) => const TasksScreen())],
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
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('titles with the user level and groups by level, none locked', (
    tester,
  ) async {
    await pump(tester);

    expect(find.textContaining('Level 1', findRichText: true), findsWidgets);
    expect(find.text('Level 2'), findsOneWidget);
    expect(find.text('Level 7'), findsOneWidget);
    expect(find.text("You're here"), findsOneWidget);
    final states = tester
        .widgetList<MuTaskCard>(find.byType(MuTaskCard))
        .map((c) => c.state);
    expect(states, isNot(contains(MuTaskState.locked)));
  });

  testWidgets('search matches title, hashtag and level like the dashboard', (
    tester,
  ) async {
    await pump(tester);

    await tester.enterText(find.byType(TextField), 'circle');
    await tester.pump();
    expect(find.byType(MuTaskCard), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'level 7');
    await tester.pump();
    expect(find.text('Lead a campus initiative'), findsOneWidget);
    expect(find.byType(MuTaskCard), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'zzz');
    await tester.pump();
    expect(find.text('Clear filters'), findsOneWidget);
  });

  testWidgets('completed filter and IG chips on Become expert', (tester) async {
    await pump(tester);

    await tester.tap(find.text('Completed'));
    await tester.pump();
    expect(find.byType(MuTaskCard), findsOneWidget);

    await tester.tap(find.text('All'));
    await tester.tap(find.text('Become expert'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.byType(MuTaskCard), findsNWidgets(2));

    final ai = find.byWidgetPredicate(
      (w) => w is MuFilterChip && w.label == 'AI',
      skipOffstage: false,
    );
    await tester.ensureVisible(ai);
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(ai);
    await tester.pump();
    expect(find.byType(MuTaskCard), findsOneWidget);
    expect(find.text('Explain AI vs ML'), findsOneWidget);
  });

  test(
    'Discord link is the dashboard one, with the default channel fallback',
    () {
      const task = TaskCatalogItem(
        id: 'x',
        title: 't',
        karma: 1,
        completed: false,
        category: TaskCategory.startJourney,
      );
      expect(
        taskDiscordUri(task).toString(),
        'https://discord.com/channels/771670169691881483/782353185552465951',
      );
      expect(
        taskDiscordUri(task.copyWith(discordId: '123')).toString(),
        'https://discord.com/channels/771670169691881483/123',
      );
    },
  );
}
