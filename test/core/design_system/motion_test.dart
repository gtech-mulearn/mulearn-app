import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/motion/mu_spring.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

double _scaleOf(WidgetTester tester) {
  final transform = tester.widget<Transform>(
    find.descendant(
      of: find.byType(MuPressable),
      matching: find.byType(Transform),
    ),
  );
  return transform
      .transform
      .storage[0]; // x scale (z stays 1 under Transform.scale)
}

void main() {
  group('springs', () {
    test('response sets stiffness, damping ratio sets damping', () {
      final s = muSpring(1, 0.35);
      final k = math.pow(2 * math.pi / 0.35, 2);
      expect(s.stiffness, closeTo(k, 1e-6));
      expect(s.damping, closeTo(2 * math.sqrt(k), 1e-6)); // critical
      expect(
        MuSprings.sheet.description.damping,
        lessThan(2 * math.sqrt(MuSprings.sheet.description.stiffness)),
      );
    });

    test('projection follows exponential deceleration', () {
      expect(project(1000), closeTo(499, 1e-9));
      expect(project(-1000), closeTo(-499, 1e-9));
      expect(project(0), 0);
    });

    test('rubberband resists more the further it goes', () {
      expect(rubberband(0, 300), 0);
      final a = rubberband(50, 300);
      final b = rubberband(200, 300);
      expect(a, lessThan(50));
      expect(b - a, lessThan(150));
      expect(rubberband(-50, 300), -a);
    });
  });

  group('MuPressable', () {
    Widget host({VoidCallback? onTap, bool reduceMotion = false}) =>
        MaterialApp(
          home: MediaQuery(
            data: MediaQueryData(disableAnimations: reduceMotion),
            child: Center(
              child: MuPressable(
                onTap: onTap,
                child: const SizedBox(width: 100, height: 50),
              ),
            ),
          ),
        );

    testWidgets('scales on press, springs back, taps on release', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(host(onTap: () => taps++));
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(MuPressable)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 120));
      expect(_scaleOf(tester), lessThan(0.99));
      expect(taps, 0);
      await gesture.up();
      await tester.pumpAndSettle();
      expect(taps, 1);
      expect(_scaleOf(tester), closeTo(1, 0.001));
    });

    testWidgets('disabled does nothing', (tester) async {
      await tester.pumpWidget(host());
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(MuPressable)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 120));
      expect(_scaleOf(tester), 1);
      await gesture.up();
    });

    testWidgets('a press held while the widget leaves the tree is harmless', (
      tester,
    ) async {
      await tester.pumpWidget(host(onTap: () {}));
      await tester.startGesture(tester.getCenter(find.byType(MuPressable)));
      await tester.pump();
      await tester.pumpWidget(const SizedBox());
      expect(tester.takeException(), isNull);
    });

    testWidgets('reduced motion skips the scale but still taps', (
      tester,
    ) async {
      var taps = 0;
      await tester.pumpWidget(host(onTap: () => taps++, reduceMotion: true));
      final gesture = await tester.startGesture(
        tester.getCenter(find.byType(MuPressable)),
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 120));
      expect(_scaleOf(tester), 1);
      await gesture.up();
      await tester.pump();
      expect(taps, 1);
    });
  });
}
