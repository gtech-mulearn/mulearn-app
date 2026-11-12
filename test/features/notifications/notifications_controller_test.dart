import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/notifications_controller.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/unread_notifications.dart';

import '../../support/fake_http_adapter.dart';
import 'notifications_test_support.dart';

/// The inbox: page/page_size paging (NotificationListView), `PATCH <id>/read/`,
/// `PATCH read-all/`, `PATCH <id>/archive/` (notification_view.py).
void main() {
  late List<Map<String, dynamic>> page1;
  late List<Map<String, dynamic>> page2;

  setUp(() {
    page1 = [for (var i = 0; i < 20; i++) item('n$i', read: i.isEven)];
    page2 = [item('n19', read: true), item('n20'), item('n21')]; // n19 repeats
  });

  FakeHttpAdapter adapterWith(Map<String, FakeResponse Function(RequestOptions)> extra, {bool page2Fails = false}) =>
      FakeHttpAdapter({
        'GET $feedPath': (o) {
          final page = o.queryParameters['page'];
          if (page == 2) return page2Fails ? const FakeResponse(-1, null) : feedPage(page2, page: 2, count: 23);
          return feedPage(page1, page: 1, count: 23);
        },
        'GET $unreadPath': (_) => unread(10),
        ...extra,
      });

  test('loads page 1, then appends page 2 without duplicates', () async {
    final adapter = adapterWith({});
    final c = await signedInContainer(adapter);
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});

    final first = await c.read(notificationsControllerProvider.future);
    expect(first.items, hasLength(20));
    expect(first.hasMore, isTrue);
    expect(adapter.requests.first.queryParameters, {'page': 1, 'page_size': 20});

    await c.read(notificationsControllerProvider.notifier).loadMore();

    final state = c.read(notificationsControllerProvider).value!;
    expect(state.items.map((n) => n.id), [for (var i = 0; i < 22; i++) 'n$i']);
    expect(state.hasMore, isFalse);
    expect(adapter.requests.last.queryParameters, {'page': 2, 'page_size': 20});
  });

  test('a failed load-more keeps the loaded items and records the error', () async {
    final c = await signedInContainer(adapterWith({}, page2Fails: true));
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);

    await c.read(notificationsControllerProvider.notifier).loadMore();

    final state = c.read(notificationsControllerProvider).value!;
    expect(state.items, hasLength(20));
    expect(state.loadMoreError, isNotNull);
  });

  test('markRead flips the item at once and sends PATCH <id>/read/', () async {
    final adapter = adapterWith({'PATCH ${readPath('n1')}': (_) => okEnvelope});
    final c = await signedInContainer(adapter);
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);

    final pending = c.read(notificationsControllerProvider.notifier).markRead('n1');
    expect(c.read(notificationsControllerProvider).value!.items[1].read, isTrue, reason: 'optimistic');
    await pending;

    expect(callsTo(adapter, 'PATCH', readPath('n1')), 1);
  });

  test('marking an already-read item sends nothing', () async {
    final adapter = adapterWith({});
    final c = await signedInContainer(adapter);
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);

    await c.read(notificationsControllerProvider.notifier).markRead('n0');

    expect(adapter.requests.where((r) => r.method == 'PATCH'), isEmpty);
  });

  test('a failed markRead restores the item and surfaces the backend message', () async {
    final c = await signedInContainer(adapterWith({
      'PATCH ${readPath('n1')}': (_) => failure('Notification not found', status: 404),
    }));
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);

    await expectLater(
      c.read(notificationsControllerProvider.notifier).markRead('n1'),
      throwsA(isA<ApiException>().having((e) => e.message, 'message', 'Notification not found')),
    );
    expect(c.read(notificationsControllerProvider).value!.items[1].read, isFalse);
  });

  test('archive removes the item at once and puts it back on failure', () async {
    final c = await signedInContainer(adapterWith({
      'PATCH ${archivePath('n3')}': (_) => const FakeResponse(-1, null),
    }));
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);

    final pending = c.read(notificationsControllerProvider.notifier).archive('n3');
    expect(c.read(notificationsControllerProvider).value!.items.map((n) => n.id), isNot(contains('n3')));
    await expectLater(pending, throwsA(isA<ApiException>()));

    expect(c.read(notificationsControllerProvider).value!.items[3].id, 'n3', reason: 'restored at its index');
  });

  test('markAllRead sends PATCH read-all/ and marks every loaded item read', () async {
    final adapter = adapterWith({'PATCH $readAllPath': (_) => okEnvelope});
    final c = await signedInContainer(adapter);
    addTearDown(c.dispose);
    c.listen(notificationsControllerProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);

    await c.read(notificationsControllerProvider.notifier).markAllRead();

    expect(callsTo(adapter, 'PATCH', readAllPath), 1);
    expect(c.read(notificationsControllerProvider).value!.items.every((n) => n.read), isTrue);
  });

  test("the inbox's own actions update the badge without asking the server again", () async {
    final adapter = adapterWith({
      'PATCH ${readPath('n1')}': (_) => okEnvelope,
      'PATCH ${archivePath('n3')}': (_) => okEnvelope,
      'PATCH $readAllPath': (_) => okEnvelope,
    });
    final c = await signedInContainer(adapter);
    addTearDown(c.dispose);
    c
      ..listen(notificationsControllerProvider, (_, __) {})
      ..listen(unreadNotificationsProvider, (_, __) {});
    await c.read(notificationsControllerProvider.future);
    expect(await c.read(unreadNotificationsProvider.future), 10);
    final notifier = c.read(notificationsControllerProvider.notifier);

    await notifier.markRead('n1');
    expect(c.read(unreadNotificationsProvider).value, 9);
    await notifier.archive('n3');
    expect(c.read(unreadNotificationsProvider).value, 8);
    await notifier.markAllRead();
    expect(c.read(unreadNotificationsProvider).value, 0);

    expect(callsTo(adapter, 'GET', unreadPath), 1, reason: 'only the first load');
  });
}
