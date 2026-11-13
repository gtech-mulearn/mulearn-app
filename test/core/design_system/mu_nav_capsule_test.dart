import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/navigation/mu_nav_capsule.dart';

const _items = [
  MuNavItem(icon: LucideIcons.home, label: 'Home'),
  MuNavItem(icon: LucideIcons.checkSquare, label: 'Tasks'),
  MuNavItem(icon: LucideIcons.milestone, label: 'Journey'),
  MuNavItem(icon: LucideIcons.trophy, label: 'Ranks'),
  MuNavItem(icon: LucideIcons.user, label: 'You'),
];

Widget _host({required int index, required ValueChanged<int> onSelect, double width = 360}) => MaterialApp(
  home: MediaQuery(
    data: MediaQueryData(size: Size(width, 760)),
    child: Scaffold(
      body: const SizedBox(),
      bottomNavigationBar: MuNavCapsule(items: _items, currentIndex: index, onSelect: onSelect, badges: const {2}),
    ),
  ),
);

void main() {
  testWidgets('every tab is a labelled button; the current one is selected', (tester) async {
    await tester.pumpWidget(_host(index: 0, onSelect: (_) {}));
    for (final item in _items) {
      expect(find.bySemanticsLabel(item.label), findsOneWidget);
    }
    expect(
      tester.getSemantics(find.bySemanticsLabel('Home')),
      isSemantics(isButton: true, isSelected: true, label: 'Home', hasTapAction: true),
    );
  });

  testWidgets('tapping a tab reports it and the pill moves', (tester) async {
    var index = 0;
    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) => _host(index: index, onSelect: (i) => setState(() => index = i)),
      ),
    );
    await tester.tap(find.bySemanticsLabel('Ranks'));
    await tester.pumpAndSettle();
    expect(index, 3);
    expect(find.text('Ranks'), findsOneWidget);
  });

  testWidgets('dragging across scrubs and selects on release', (tester) async {
    int? chosen;
    await tester.pumpWidget(_host(index: 0, onSelect: (i) => chosen = i));
    final start = tester.getCenter(find.bySemanticsLabel('Home'));
    final end = tester.getCenter(find.bySemanticsLabel('You'));
    await tester.dragFrom(start, end - start);
    await tester.pumpAndSettle();
    expect(chosen, 4);
  });

  testWidgets('fits a 320dp screen without overflow', (tester) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(index: 2, onSelect: (_) {}, width: 320));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
  testWidgets('at 360dp the selected tab shows its label without overflow', (tester) async {
    tester.view.physicalSize = const Size(360, 760);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(_host(index: 2, onSelect: (_) {}));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Journey'), findsOneWidget);
  });
}
