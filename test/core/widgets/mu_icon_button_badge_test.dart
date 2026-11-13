import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';

void main() {
  Future<void> pump(WidgetTester tester, int count) => tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MuIconButton(
            icon: LucideIcons.bell,
            onPressed: () {},
            tooltip: count == 0 ? 'Notifications' : 'Notifications, $count unread',
            badgeCount: count,
          ),
        ),
      ));

  testWidgets('shows the count, hides it at zero, caps at 99+', (tester) async {
    await pump(tester, 3);
    expect(find.text('3'), findsOneWidget);

    await pump(tester, 0);
    expect(find.text('0'), findsNothing);

    await pump(tester, 140);
    expect(find.text('99+'), findsOneWidget);
  });

  testWidgets('is announced by its tooltip', (tester) async {
    await pump(tester, 3);

    expect(find.bySemanticsLabel('Notifications, 3 unread'), findsOneWidget);
  });
}
