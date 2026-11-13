import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_filter.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/screens/learning_circles_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _list = '/api/v1/dashboard/learningcircle/list/';

/// L7 discovery filters — LearningCircleView.get (learningcircle_views.py:58):
/// `status` ∈ joined | pending | not_joined, `ig`, `search` (title), paged.
void main() {
  late FakeHttpAdapter adapter;

  FakeResponse empty() => const FakeResponse(200, {
        'hasError': false,
        'statusCode': 200,
        'message': {'general': <String>[]},
        'response': {
          'data': <Object>[],
          'pagination': {'count': 0, 'totalPages': 1, 'isNext': false, 'isPrev': false, 'nextPage': null},
        },
      });

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_list': (o) => o.queryParameters['search'] == 'nothing-matches'
          ? empty()
          : o.queryParameters.containsKey('search')
              ? FakeResponse(200, loadFixture('dev/circles_filtered'))
              : FakeResponse(200, loadFixture('dev/circles_page1')),
      'GET /api/v1/dashboard/learningcircle/user-circles/': (_) => FakeResponse(200, loadFixture('dev/user_circles')),
      'GET /api/v1/dashboard/learningcircle/invite/status/': (_) => FakeResponse(200, loadFixture('dev/my_invites')),
      'GET /api/v1/dashboard/ig/list/': (_) => FakeResponse(200, loadFixture('dev/ig_list')),
    });
  });

  Future<ProviderContainer> container() async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  List<Map<String, dynamic>> listQueries() => [
        for (final r in adapter.requests)
          if (r.uri.path == _list) Map.of(r.queryParameters),
      ];

  test('the query carries only the filters that are set', () async {
    final c = await container();
    c.listen(circlesListControllerProvider(const CircleFilter()), (_, __) {});
    await c.read(circlesListControllerProvider(const CircleFilter()).future);
    const filtered = CircleFilter(status: 'not_joined', igId: 'ig1', search: 'Club');
    c.listen(circlesListControllerProvider(filtered), (_, __) {});
    await c.read(circlesListControllerProvider(filtered).future);

    expect(listQueries().first, {'pageIndex': 1, 'perPage': 20});
    expect(listQueries().last, {'pageIndex': 1, 'perPage': 20, 'status': 'not_joined', 'ig': 'ig1', 'search': 'Club'});
  });

  test('a blank search is not sent', () async {
    final c = await container();
    const f = CircleFilter(search: '   ');
    c.listen(circlesListControllerProvider(f), (_, __) {});
    await c.read(circlesListControllerProvider(f).future);

    expect(listQueries().single.containsKey('search'), isFalse);
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    final c = await container();
    tester.view.physicalSize = const Size(1080, 5000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: c, child: const MaterialApp(home: LearningCirclesScreen())));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    // The filters sit below the user's circles and invitations.
    await tester.scrollUntilVisible(find.byType(TextField), 300, scrollable: find.byType(Scrollable).first);
    await tester.pump();
  }

  testWidgets('discovery starts on circles the user has not joined', (tester) async {
    await pumpScreen(tester);

    expect(listQueries().first['status'], 'not_joined');
  });

  testWidgets('typing searches once, after a pause', (tester) async {
    await pumpScreen(tester);
    final before = listQueries().length;

    await tester.enterText(find.byType(TextField), 'C');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'Cl');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'Club');
    await tester.pump(const Duration(milliseconds: 350));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    final searches = listQueries().skip(before).toList();
    expect(searches, hasLength(1));
    expect(searches.single['search'], 'Club');
    expect(find.text('LLM Paper Reading Club'), findsWidgets);
  });

  testWidgets('a status chip filters on the server', (tester) async {
    await pumpScreen(tester);

    final pending = find.widgetWithText(MuFilterChip, 'Pending');
    await tester.ensureVisible(pending);
    await tester.pump();
    await tester.tap(pending);
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(listQueries().last['status'], 'pending');
  });

  testWidgets('no match says so and offers to clear the filters', (tester) async {
    await pumpScreen(tester);

    await tester.enterText(find.byType(TextField), 'nothing-matches');
    await tester.pump(const Duration(milliseconds: 350));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('No circles match these filters'), findsOneWidget);

    await tester.tap(find.text('Clear filters'));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(listQueries().last['status'], 'not_joined');
    expect(listQueries().last.containsKey('search'), isFalse);
    expect(adapter.requests.where((RequestOptions r) => r.uri.path == _list).isNotEmpty, isTrue);
  });
}
