import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/tab_navigation.dart';

/// Home used to `push` shell branch roots (/tasks, /leaderboard, /profile,
/// /journey), stacking a second copy over the shell and desyncing the
/// bottom bar (UX-09/REL-06).
void main() {
  testWidgets('opening a tab switches branch without stacking a page', (tester) async {
    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (_, __, shell) => Scaffold(body: shell),
          branches: [
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/home',
                builder: (context, __) => TextButton(
                  onPressed: () => context.openTab('/tasks'),
                  child: const Text('Find a task'),
                ),
              ),
            ]),
            StatefulShellBranch(routes: [
              GoRoute(path: '/tasks', builder: (_, __) => const Text('Tasks tab')),
            ]),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(MaterialApp.router(routerConfig: router));

    await tester.tap(find.text('Find a task'));
    await tester.pumpAndSettle();

    expect(router.routerDelegate.currentConfiguration.uri.path, '/tasks');
    expect(router.canPop(), isFalse, reason: 'switched branch, nothing pushed');
    expect(find.text('Tasks tab'), findsOneWidget);
  });
}
