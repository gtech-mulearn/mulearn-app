import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/presentation/providers/welcome_providers.dart';
import 'package:mulearn_app/features/auth/presentation/screens/arrival_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

Map<String, dynamic> _ok(Object response) => {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': response,
};

void main() {
  late FakeHttpAdapter adapter;
  late FakeSecureStorage storage;

  setUp(() {
    storage = FakeSecureStorage();
    adapter = FakeHttpAdapter({
      'GET /api/v1/public/global-count/': (_) => FakeResponse(
        200,
        _ok({
          'members': 73953,
          'org_type_counts': [
            {'org_type': 'College', 'org_count': 1949},
            {'org_type': 'Company', 'org_count': 291},
          ],
          'enablers_mentors_count': [
            {'role__title': 'Mentor', 'role_count': 492},
          ],
          'ig_count': 23,
          'learning_circle_count': 2338,
        }),
      ),
      'GET /api/v1/public/ig/list/': (_) => FakeResponse(
        200,
        _ok({
          'interestGroups': [
            {'id': 'ig-comics', 'name': 'Comics'},
            {'id': 'ig-web', 'name': 'Web Development'},
          ],
        }),
      ),
      'GET /api/v1/public/events/featured/': (_) => FakeResponse(
        200,
        _ok({
          'data': [
            {
              'id': 'ev1',
              'title': 'Learning Fest 2026',
              'start_datetime': '2026-09-14T04:30:00Z',
              'end_datetime': '2026-11-30T12:00:00Z',
              'venue': {'venue_type': 'online'},
              'interest_count': 92,
            },
          ],
        }),
      ),
    });
  });

  Future<GoRouter> pump(WidgetTester tester, String start) async {
    final container = ProviderContainer(
      retry: (_, __) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        secureStorageProvider.overrideWithValue(storage),
        cacheStoreProvider.overrideWithValue(MemCacheStore()),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: start,
      routes: [
        GoRoute(path: '/welcome', builder: (_, __) => const ArrivalScreen()),
        GoRoute(
          path: '/sign-in',
          builder: (_, __) => const Text('sign in screen'),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 2400);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    return router;
  }

  testWidgets('the arrival states real numbers, in the site voice', (
    tester,
  ) async {
    await pump(tester, '/welcome');
    expect(find.text('73,953 LEARNERS · 1,949 CAMPUSES'), findsOneWidget);
    expect(
      find.textContaining('peer-led growth', findRichText: true),
      findsOneWidget,
    );
    expect(find.text('Tap the ring'), findsOneWidget);
  });

  testWidgets('tapping the ring breaks it into the real groups', (
    tester,
  ) async {
    await pump(tester, '/welcome');
    await tester.tap(
      find.bySemanticsLabel(
        'Tap to break the ring and see every Interest Group',
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('23 Interest Groups. Pick any.'), findsOneWidget);
    expect(find.text('Comics'), findsOneWidget);
  });

  Future<void> frames(WidgetTester tester) async {
    for (var i = 0; i < 12; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets(
    'Next walks the four steps; Get started on the last opens sign-in',
    (tester) async {
      final router = await pump(tester, '/welcome');
      for (final step in [
        'peer-led growth',
        'Prove it.',
        'Mentor those behind.',
      ]) {
        expect(find.textContaining(step, findRichText: true), findsOneWidget);
        expect(find.text('Get started'), findsNothing);
        await tester.tap(find.text('Next'));
        await frames(tester);
      }
      expect(
        find.textContaining('to capable', findRichText: true),
        findsOneWidget,
      );
      expect(
        router.state.uri.path,
        '/welcome',
        reason: 'Next never skips to sign-in',
      );

      await tester.tap(find.text('Get started'));
      await frames(tester);
      expect(router.state.uri.path, '/sign-in');
      expect(await storage.read(key: 'arrival_seen'), '1');
    },
  );

  testWidgets('Skip goes to sign-in from any step', (tester) async {
    final router = await pump(tester, '/welcome');
    await tester.tap(find.bySemanticsLabel('Skip to sign in'));
    await frames(tester);
    expect(router.state.uri.path, '/sign-in');
    expect(await storage.read(key: 'arrival_seen'), '1');
  });

  test('arrival-seen reads and writes the device flag', () async {
    final storage = FakeSecureStorage();
    final c = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(c.dispose);
    expect(await c.read(arrivalSeenProvider.future), isFalse);
    await c.read(arrivalSeenProvider.notifier).markSeen();
    expect(c.read(arrivalSeenProvider).value, isTrue);
    expect(await storage.read(key: 'arrival_seen'), '1');
  });
}
