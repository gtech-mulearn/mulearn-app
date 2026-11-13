import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/core/notifications/unread_refresh_triggers.dart';

import '../../features/notifications/notifications_test_support.dart';
import '../../support/fake_http_adapter.dart';

/// App resume refreshes the badge only when it's stale; nothing polls.
void main() {
  testWidgets('a resume after the staleness window refetches once; an early one does not', (tester) async {
    var now = DateTime.utc(2026, 11, 13, 10);
    final adapter = FakeHttpAdapter({'GET $unreadPath': (_) => unread(2)});
    final container = await signedInContainer(adapter, now: () => now);
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: const MaterialApp(home: UnreadRefreshTriggers(child: SizedBox())),
    ));
    await tester.runAsync(() => container.read(unreadNotificationsProvider.future));
    expect(callsTo(adapter, 'GET', unreadPath), 1);

    // The request a resume starts runs on Dio's real async path, so the
    // lifecycle changes happen inside runAsync.
    Future<void> resume() => tester.runAsync(() async {
          // Background, then foreground, through every state in between
          // (AppLifecycleListener reports a resume only from inactive).
          for (final state in const [
            AppLifecycleState.inactive,
            AppLifecycleState.hidden,
            AppLifecycleState.paused,
            AppLifecycleState.hidden,
            AppLifecycleState.inactive,
            AppLifecycleState.resumed,
          ]) {
            tester.binding.handleAppLifecycleStateChanged(state);
          }
          await Future<void>.delayed(const Duration(milliseconds: 50));
        });

    now = now.add(const Duration(minutes: 2));
    await resume();
    expect(callsTo(adapter, 'GET', unreadPath), 1);

    now = now.add(const Duration(minutes: 10));
    await resume();
    expect(callsTo(adapter, 'GET', unreadPath), 2);
  });
}
