import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(
    body: Center(child: SizedBox(width: 340, child: child)),
  ),
);

void main() {
  test('weeks start on Monday', () {
    expect(muWeekStart(DateTime(2026, 11, 15)), DateTime(2026, 11, 9)); // Sunday → Monday before
    expect(muWeekStart(DateTime(2026, 11, 9, 18)), DateTime(2026, 11, 9));
  });

  testWidgets('announces each day with what is on it, and picks a day', (tester) async {
    DateTime? picked;
    final thu = DateTime(2026, 11, 12);
    await tester.pumpWidget(
      _host(MuDateStrip(selected: thu, counts: {thu: 2}, onSelect: (d) => picked = d)),
    );
    expect(find.bySemanticsLabel(RegExp(r'^Thursday 12 November.*2 items$')), findsOneWidget);
    expect(find.text('Thu'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel(RegExp('^Friday 13 November')));
    expect(picked, DateTime(2026, 11, 13));
  });

  testWidgets('swiping moves a week and reports its Monday', (tester) async {
    DateTime? week;
    await tester.pumpWidget(
      _host(MuDateStrip(selected: DateTime(2026, 11, 12), onSelect: (_) {}, onWeekChanged: (w) => week = w)),
    );
    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1500);
    await tester.pumpAndSettle();
    expect(week, DateTime(2026, 11, 16));
  });
}
