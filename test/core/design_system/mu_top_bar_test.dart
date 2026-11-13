import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/input/mu_icon_button.dart';
import 'package:mulearn_app/core/design_system/navigation/mu_top_bar.dart';

void main() {
  testWidgets('greeting shows both lines and its tools', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MuTopBar.greeting(
            greeting: 'Hey Aysha',
            subtitle: 'Thursday, 13 Nov · Level 4',
            actions: [MuIconButton(icon: LucideIcons.search, onPressed: () {}, tooltip: 'Search')],
          ),
        ),
      ),
    );
    expect(find.text('Hey Aysha'), findsOneWidget);
    expect(find.text('Thursday, 13 Nov · Level 4'), findsOneWidget);
    expect(find.bySemanticsLabel('Search'), findsOneWidget);
  });

  testWidgets('detail bar backs out of a pushed screen', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => TextButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const Scaffold(body: MuTopBar.detail(title: 'Learning Fest 2026')),
              ),
            ),
            child: const Text('open'),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Learning Fest 2026'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    expect(find.text('open'), findsOneWidget);
  });

  testWidgets('a root screen has no back button', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: MuTopBar.detail(title: 'Events')),
      ),
    );
    expect(find.bySemanticsLabel('Back'), findsNothing);
  });

  testWidgets('glass bar blurs, and ignores taps while hidden', (tester) async {
    var backs = 0;
    Widget bar(double v) => MaterialApp(
      home: Scaffold(
        body: MuGlassBar(title: 'Web Development', visibility: v, onBack: () => backs++),
      ),
    );
    await tester.pumpWidget(bar(1));
    expect(tester.widget<BackdropFilter>(find.byType(BackdropFilter)).filter, isA<ImageFilter>());
    await tester.tap(find.bySemanticsLabel('Back'));
    await tester.pumpAndSettle();
    expect(backs, 1);

    await tester.pumpWidget(bar(0));
    await tester.tap(find.byType(MuGlassBar), warnIfMissed: false);
    await tester.pumpAndSettle();
    expect(backs, 1);
  });
}
