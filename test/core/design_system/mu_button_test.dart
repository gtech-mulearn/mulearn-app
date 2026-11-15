import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/input/mu_button.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme_data.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

Widget _host(Widget child, {double width = 360}) => MaterialApp(
  theme: MuThemeData.light(),
  home: Scaffold(
    body: Center(
      child: SizedBox(width: width, child: child),
    ),
  ),
);

void main() {
  testWidgets('taps call onPressed and the label is the semantics label', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(MuButton(label: 'Register', onPressed: () => taps++)),
    );
    await tester.tap(find.byType(MuButton));
    await tester.pumpAndSettle();
    expect(taps, 1);
    expect(find.bySemanticsLabel('Register'), findsOneWidget);
  });

  testWidgets('loading shows its label and blocks taps', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(
        MuButton(
          label: 'Sign in',
          loadingLabel: 'Signing in',
          loading: true,
          onPressed: () => taps++,
        ),
      ),
    );
    await tester.tap(find.byType(MuButton));
    await tester.pump();
    expect(taps, 0);
    expect(find.text('Signing in'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('a null onPressed is disabled and dimmed', (tester) async {
    await tester.pumpWidget(
      _host(const MuButton(label: 'Register', onPressed: null)),
    );
    final opacity = tester.widget<Opacity>(
      find
          .descendant(of: find.byType(MuButton), matching: find.byType(Opacity))
          .first,
    );
    expect(opacity.opacity, MuOpacity.disabled);
    expect(
      tester.getSemantics(find.byType(MuButton)),
      matchesSemantics(
        isButton: true,
        label: 'Register',
        hasEnabledState: true,
      ),
    );
  });

  testWidgets(
    'ink variant fills with night; the knob is μLearn blue, never volt',
    (tester) async {
      await tester.pumpWidget(
        _host(
          MuButton(
            label: 'Get started',
            variant: MuButtonVariant.ink,
            knob: true,
            block: true,
            onPressed: () {},
          ),
        ),
      );
      final fills = tester
          .widgetList<Container>(
            find.descendant(
              of: find.byType(MuButton),
              matching: find.byType(Container),
            ),
          )
          .map((c) => (c.decoration as BoxDecoration?)?.color)
          .toList();
      expect(
        fills,
        containsAll([MuPalette.light.night, MuPalette.light.cobalt]),
      );
      expect(fills, isNot(contains(MuPalette.light.volt)));
    },
  );

  testWidgets('a blue button with a knob gets a white knob', (tester) async {
    await tester.pumpWidget(
      _host(MuButton(label: 'Next', knob: true, onPressed: () {})),
    );
    final fills = tester
        .widgetList<Container>(
          find.descendant(
            of: find.byType(MuButton),
            matching: find.byType(Container),
          ),
        )
        .map((c) => (c.decoration as BoxDecoration?)?.color)
        .toList();
    expect(
      fills,
      containsAll([MuPalette.light.cobalt, MuPalette.light.onCobalt]),
    );
  });

  testWidgets('small buttons keep a 48dp hit area', (tester) async {
    await tester.pumpWidget(
      _host(
        MuButton(label: 'Details', size: MuButtonSize.small, onPressed: () {}),
      ),
    );
    expect(
      tester.getSize(find.byType(MuButton)).height,
      greaterThanOrEqualTo(MuSizes.touchMin),
    );
  });

  testWidgets('a long label ellipsizes at 360dp instead of overflowing', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        MuButton(
          label: 'Copy the hashtag and open the Discord channel for this task',
          variant: MuButtonVariant.ink,
          knob: true,
          block: true,
          onPressed: () {},
        ),
        width: 328,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('Enter activates a focused button', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(MuButton(label: 'Register', onPressed: () => taps++)),
    );
    Focus.of(tester.element(find.text('Register'))).requestFocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    expect(taps, 1);
  });
}
