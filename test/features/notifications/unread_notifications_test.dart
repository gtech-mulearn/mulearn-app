import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/unread_notifications.dart';

import '../../support/fake_http_adapter.dart';
import 'notifications_test_support.dart';

/// GET /api/v1/notification/unread-count/ (UnreadCountView) — personal,
/// unread, non-archived rows only. Refreshed on user-driven triggers, never on
/// a timer: ~70k members share one backend (user, 2026-11-13).
void main() {
  late DateTime now;
  late FakeHttpAdapter adapter;
  var count = 4;

  setUp(() {
    now = DateTime.utc(2026, 11, 13, 10);
    count = 4;
    adapter = FakeHttpAdapter({'GET $unreadPath': (_) => unread(count)});
  });

  int fetches() => callsTo(adapter, 'GET', unreadPath);

  Future<UnreadNotifications> loaded(ProviderContainer c) async {
    c.listen(unreadNotificationsProvider, (_, __) {});
    await c.read(unreadNotificationsProvider.future);
    return c.read(unreadNotificationsProvider.notifier);
  }

  test('reads unread_count', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);

    expect(await c.read(unreadNotificationsProvider.future), 4);
  });

  test('signed out means 0 and no request', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    await c.read(appAuthControllerProvider.future);
    c.read(appAuthControllerProvider.notifier).setSignedOut();

    expect(await c.read(unreadNotificationsProvider.future), 0);
    expect(fetches(), 0);
  });

  test('no request without a trigger', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    await loaded(c);

    now = now.add(const Duration(minutes: 60));
    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(fetches(), 1, reason: 'only the first load; nothing polls');
  });

  test("resume within the staleness window doesn't refetch", () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    final notifier = await loaded(c);
    final start = now;

    now = start.add(const Duration(minutes: 1));
    await notifier.refreshIfStale();
    now = start.add(const Duration(minutes: 4));
    await notifier.refreshIfStale();
    expect(fetches(), 1);

    count = 7;
    now = start.add(const Duration(minutes: 6));
    await notifier.refreshIfStale();
    expect(fetches(), 2);
    expect(c.read(unreadNotificationsProvider).value, 7);
  });

  test('two simultaneous triggers make one request', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    final notifier = await loaded(c);
    now = now.add(const Duration(minutes: 10));

    await Future.wait([notifier.refreshIfStale(), notifier.refreshIfStale(), notifier.refresh()]);

    expect(fetches(), 2);
  });

  test('pull-to-refresh fetches even when fresh', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    final notifier = await loaded(c);

    await notifier.refresh();

    expect(fetches(), 2);
  });

  test('marking read adjusts the badge locally', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    final notifier = await loaded(c)
      ..onRead(wasUnread: true, isBroadcast: false);
    expect(c.read(unreadNotificationsProvider).value, 3);

    notifier
      ..onRead(wasUnread: true, isBroadcast: true) // broadcasts aren't counted
      ..onRead(wasUnread: false, isBroadcast: false);
    expect(c.read(unreadNotificationsProvider).value, 3);

    notifier.onAllRead();
    expect(c.read(unreadNotificationsProvider).value, 0);
    notifier.onArchived(wasUnread: true, isBroadcast: false);
    expect(c.read(unreadNotificationsProvider).value, 0, reason: 'never below zero');
    expect(fetches(), 1);
  });

  test('a failed refresh keeps the previous count', () async {
    final c = await signedInContainer(adapter, now: () => now);
    addTearDown(c.dispose);
    final notifier = await loaded(c);
    adapter.routes['GET $unreadPath'] = (_) => const FakeResponse(-1, null);

    await notifier.refresh();

    expect(c.read(unreadNotificationsProvider).value, 4);
    expect(c.read(unreadNotificationsProvider).hasError, isFalse);
  });
}
