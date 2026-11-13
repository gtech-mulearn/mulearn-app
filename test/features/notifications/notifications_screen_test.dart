import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/features/notifications/presentation/screens/notifications_screen.dart';

import '../../support/fake_http_adapter.dart';
import 'notifications_test_support.dart';

Future<void> settleRequests(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
}

/// The inbox (L16): Today/Earlier, unread dots, tap-through, swipe to
/// archive, mark all read, retry rows.
void main() {
  setUpAll(() => FlavorConfig.initialize(Flavor.dev));
  final now = DateTime.now();
  String iso(DateTime d) => d.toUtc().toIso8601String();

  late FakeHttpAdapter adapter;
  late List<Map<String, dynamic>> items;

  setUp(() {
    items = [
      {...item('t1'), 'created_at': iso(now.subtract(const Duration(minutes: 5))), 'entity_id': 'c1'},
      {...item('old', read: true), 'created_at': iso(now.subtract(const Duration(days: 3)))},
    ];
    adapter = FakeHttpAdapter({
      'GET $feedPath': (_) => feedPage(items, page: 1, count: items.length),
      'GET $unreadPath': (_) => unread(1),
      'PATCH ${readPath('t1')}': (_) => okEnvelope,
      'PATCH ${archivePath('t1')}': (_) => okEnvelope,
      'PATCH $readAllPath': (_) => okEnvelope,
    });
  });

  Future<GoRouter> pumpInbox(WidgetTester tester) async {
    final container = await signedInContainer(adapter);
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: '/notifications',
      routes: [
        GoRoute(path: '/notifications', builder: (_, __) => const NotificationsScreen()),
        GoRoute(path: '/circles/:id', builder: (_, s) => Text('circle ${s.pathParameters['id']}')),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ));
    await tester.pumpAndSettle();
    return router;
  }

  testWidgets('groups items under Today and Earlier and marks unread ones', (tester) async {
    await pumpInbox(tester);

    expect(find.text('Today'), findsOneWidget);
    expect(find.text('Earlier'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('^Unread')), findsOneWidget);
  });

  testWidgets('opening the inbox refreshes the badge once', (tester) async {
    await pumpInbox(tester);

    expect(callsTo(adapter, 'GET', unreadPath), 1);
  });

  testWidgets('tapping marks it read and opens its circle', (tester) async {
    await pumpInbox(tester);

    await tester.tap(find.text('Title t1'));
    await tester.pumpAndSettle();

    expect(callsTo(adapter, 'PATCH', readPath('t1')), 1);
    expect(find.text('circle c1'), findsOneWidget);
  });

  testWidgets('swiping archives with a toast', (tester) async {
    await pumpInbox(tester);

    await tester.drag(find.text('Title t1'), const Offset(-600, 0));
    await tester.pumpAndSettle();
    await settleRequests(tester);

    expect(callsTo(adapter, 'PATCH', archivePath('t1')), 1);
    expect(find.text('Notification archived'), findsOneWidget);
    expect(find.text('Title t1'), findsNothing);
    await tester.pump(const Duration(seconds: 4)); // let the toast go
    await tester.pumpAndSettle();
  });

  testWidgets('mark all read', (tester) async {
    await pumpInbox(tester);

    await tester.tap(find.text('Mark all read'));
    await tester.pumpAndSettle();

    expect(callsTo(adapter, 'PATCH', readAllPath), 1);
    expect(find.text('All notifications marked as read'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('^Unread')), findsNothing);
    await tester.pump(const Duration(seconds: 4)); // let the toast go
    await tester.pumpAndSettle();
  });

  testWidgets("an empty inbox says you're all caught up", (tester) async {
    items = [];
    await pumpInbox(tester);

    expect(find.text("You're all caught up"), findsOneWidget);
  });

  testWidgets('a failed first load offers retry', (tester) async {
    adapter.routes['GET $feedPath'] = (_) => const FakeResponse(-1, null);
    await pumpInbox(tester);

    expect(find.text('Retry'), findsOneWidget);
  });

  test('the badge provider is the core one (Home reads it)', () {
    expect(unreadNotificationsProvider, isNotNull);
  });
}
