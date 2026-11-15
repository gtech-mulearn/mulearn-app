import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/content/mu_task_card.dart';
import 'package:mulearn_app/core/design_system/input/mu_filter_chip.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(
    body: Center(child: SizedBox(width: 320, child: child)),
  ),
);

void main() {
  testWidgets('task card prints the hashtag on its tab and opens', (
    tester,
  ) async {
    var opened = 0;
    await tester.pumpWidget(
      _host(
        MuTaskCard(
          title: 'Build a React to-do list',
          karma: 150,
          hashtag: '#cl-react-todo',
          eyebrow: 'Level 3 · Web Development',
          description: 'Use hooks and push it to a public repo.',
          onTap: () => opened++,
        ),
      ),
    );
    expect(find.text('#cl-react-todo'), findsOneWidget);
    expect(find.text('LEVEL 3 · WEB DEVELOPMENT'), findsOneWidget);
    expect(find.text('+150'), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        'Build a React to-do list, #cl-react-todo, 150 karma',
      ),
      findsOneWidget,
    );
    await tester.tap(find.byType(MuTaskCard));
    await tester.pumpAndSettle();
    expect(opened, 1);
  });

  testWidgets('a done task says it was earned, in words', (tester) async {
    await tester.pumpWidget(
      _host(
        const MuTaskCard(
          title: 'Self Introduction',
          karma: 20,
          hashtag: '#ge-self-intro',
          state: MuTaskState.done,
        ),
      ),
    );
    expect(find.text('+20 earned'), findsOneWidget);
    final tab = tester
        .widgetList<Container>(
          find.descendant(
            of: find.byType(MuTaskCard),
            matching: find.byType(Container),
          ),
        )
        .map((c) => (c.decoration as BoxDecoration?)?.color)
        .toList();
    expect(tab, contains(MuPalette.light.success));
  });

  testWidgets(
    'a missing hashtag prints "task" and a long title does not overflow',
    (tester) async {
      await tester.pumpWidget(
        _host(
          const MuTaskCard(
            title:
                'A very long task title that keeps going well past two lines on a narrow phone screen',
            karma: 1200,
          ),
        ),
      );
      expect(find.text('task'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('filter chip reports selection to screen readers and taps', (
    tester,
  ) async {
    var taps = 0;
    await tester.pumpWidget(
      _host(MuFilterChip(label: 'All', selected: true, onTap: () => taps++)),
    );
    expect(
      tester.getSemantics(find.byType(MuFilterChip)),
      isSemantics(isSelected: true, isButton: true, label: 'All'),
    );
    await tester.tap(find.byType(MuFilterChip));
    await tester.pumpAndSettle();
    expect(taps, 1);
    expect(
      tester.getSize(find.byType(MuFilterChip)).height,
      greaterThanOrEqualTo(MuSizes.touchMin),
    );
  });
}
