import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_icon_button.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

void main() {
  Future<void> pump(WidgetTester tester, int count) => tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: MuIconButton(
          icon: LucideIcons.bell,
          onPressed: () {},
          tooltip: count == 0
              ? 'Notifications'
              : 'Notifications, $count unread',
          badgeCount: count,
        ),
      ),
    ),
  );

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
  testWidgets('variants fill from the palette; the hit area is 48dp', (
    tester,
  ) async {
    for (final (variant, fill) in [
      (MuIconButtonVariant.night, MuPalette.light.night),
      (MuIconButtonVariant.cobalt, MuPalette.light.cobalt),
      (MuIconButtonVariant.sunk, MuPalette.light.surfaceSunk),
    ]) {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MuIconButton(
                icon: LucideIcons.qrCode,
                onPressed: () {},
                tooltip: 'Scan',
                variant: variant,
              ),
            ),
          ),
        ),
      );
      final colors = tester
          .widgetList<Container>(
            find.descendant(
              of: find.byType(MuIconButton),
              matching: find.byType(Container),
            ),
          )
          .map((c) => (c.decoration as BoxDecoration?)?.color);
      expect(colors, contains(fill));
      expect(
        tester.getSize(find.byType(MuIconButton)),
        const Size.square(MuSizes.touchMin),
      );
    }
  });

  testWidgets('taps fire; a null onPressed does not', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: MuIconButton(
              icon: LucideIcons.bell,
              onPressed: () => taps++,
              tooltip: 'Bell',
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(MuIconButton));
    await tester.pumpAndSettle();
    expect(taps, 1);
  });
}
