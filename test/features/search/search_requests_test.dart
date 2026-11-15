import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/search_debouncer.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/features/search/presentation/screens/search_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _college = '/api/v1/dashboard/organisation/institutes/college/';
const _users = '/api/v1/dashboard/user/search/';

/// Search fields must not flood the server: one request per pause in
/// typing, none for one letter or an unchanged query, and none for a query
/// whose results are still in memory.
void main() {
  testWidgets('the debouncer waits for a pause, a second letter and a real change', (tester) async {
    final sent = <String>[];
    final d = SearchDebouncer(sent.add);
    addTearDown(d.dispose);

    d
      ..onChanged('j')
      ..onChanged('jo')
      ..onChanged('jos');
    await tester.pump(const Duration(milliseconds: 200));
    expect(sent, isEmpty, reason: 'still typing');
    await tester.pump(searchDebounce);
    expect(sent, ['jos']);

    d.onChanged('jos  ');
    await tester.pump(searchDebounce);
    expect(sent, ['jos'], reason: 'only spaces changed');

    d.onChanged('j');
    await tester.pump(searchDebounce);
    expect(sent, ['jos'], reason: 'one letter is not worth a request');

    d.onChanged('');
    expect(sent, ['jos', ''], reason: 'clearing applies at once');

    d.submit('j');
    expect(sent, ['jos', '', 'j'], reason: 'the search key always runs');
  });

  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_college': (_) => FakeResponse(200, loadFixture('dev/campus_search_college')),
      'GET /api/v1/dashboard/organisation/institutes/school/': (_) => const FakeResponse(500, {'detail': 'boom'}),
      'GET $_users': (RequestOptions r) => FakeResponse(
        200,
        loadFixture(r.queryParameters['pageIndex'] == 2 ? 'dev/user_search_default_p2' : 'dev/user_search_default_p1'),
      ),
    });
  });

  Future<void> settle(WidgetTester tester) async {
    await tester.pump(searchDebounce);
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('typing searches as you go, and an earlier query comes back from memory', (tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [dioProvider.overrideWithValue(fakeDio(adapter)), tokenStorageProvider.overrideWithValue(tokens)],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/search',
      routes: [GoRoute(path: '/search', builder: (_, _) => const SearchScreen())],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: MuThemeData.light(), routerConfig: router),
      ),
    );
    await tester.pump();
    await tester.tap(find.text('Campuses'));
    await tester.pump();

    List<String?> sent() => [
      for (final RequestOptions r in adapter.requests)
        if (r.uri.path == _college) r.uri.queryParameters['search'],
    ];

    final field = find.byType(TextField);
    await tester.enterText(field, 'J');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(field, 'Jo');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(field, 'Joseph');
    await settle(tester);
    expect(sent(), ['', 'Joseph'], reason: 'the default list, then one request once typing pauses');
    expect(find.text('St. Josephs Colege of Engineering and Technology'), findsOneWidget);

    await tester.enterText(field, 'Josephs');
    await settle(tester);
    await tester.enterText(field, 'Joseph');
    await settle(tester);
    expect(sent(), ['', 'Joseph', 'Josephs'], reason: 'going back to "Joseph" is served from memory');

    await tester.enterText(field, 'J');
    await settle(tester);
    expect(sent(), hasLength(3), reason: 'one letter sends nothing');

    await tester.enterText(field, '');
    await settle(tester);
    expect(sent(), hasLength(3), reason: 'clearing shows the default list from memory');
  });

  testWidgets('People lists everyone before you type, a page at a time, without refetching', (tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [dioProvider.overrideWithValue(fakeDio(adapter)), tokenStorageProvider.overrideWithValue(tokens)],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/search',
      routes: [GoRoute(path: '/search', builder: (_, _) => const SearchScreen())],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: MuThemeData.light(), routerConfig: router),
      ),
    );
    await settle(tester);

    List<Object?> pages() => [
      for (final RequestOptions r in adapter.requests)
        if (r.uri.path == _users && r.queryParameters['role'] == null) r.queryParameters['pageIndex'],
    ];
    expect(find.text('onthmurali'), findsOneWidget, reason: 'the first of the default list');
    expect(pages(), [1]);

    for (var i = 0; i < 6; i++) {
      await tester.fling(find.byType(ListView), const Offset(0, -3000), 3000);
      await settle(tester);
    }
    expect(pages(), [1, 2], reason: 'each page once, however much it scrolls');
    expect(find.byType(MuLoadMoreFooter), findsNothing, reason: 'no more pages after the last');

    await tester.tap(find.text('Mentors'));
    await settle(tester);
    await tester.tap(find.text('People'));
    await settle(tester);
    expect(pages(), [1, 2], reason: 'back on People, the list comes from memory');
  });
}
