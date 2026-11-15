import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

Widget _host(Widget child) => MaterialApp(
  theme: MuThemeData.light(),
  home: Scaffold(
    body: Center(child: SizedBox(width: 360, child: child)),
  ),
);

void main() {
  testWidgets('a circle reads as one line and shows its count in the core', (tester) async {
    var opened = 0;
    await tester.pumpWidget(
      _host(
        MuCircleCard(
          title: 'Pandas Saturdays',
          total: 8,
          igName: 'Data Science',
          igCategory: IgCategory.coder,
          caption: 'CET · 8 members',
          members: const [(name: 'Arjun R', url: null), (name: 'Sneha N', url: null)],
          action: MuButton(label: 'Open', size: MuButtonSize.small, onPressed: () {}),
          onTap: () => opened++,
        ),
      ),
    );

    expect(find.text('8'), findsOneWidget);
    expect(find.byType(MuAvatar), findsNWidgets(2), reason: 'faces fill the seats they have');
    expect(find.bySemanticsLabel(RegExp('^Pandas Saturdays, Data Science, 8 members, CET')), findsOneWidget);

    await tester.tap(find.text('Pandas Saturdays'));
    expect(opened, 1);
  });

  testWidgets('without faces the ring shows up to five empty seats', (tester) async {
    await tester.pumpWidget(_host(const MuCircleCard(title: 'Big circle', total: 40)));

    expect(find.text('40'), findsOneWidget);
    expect(find.byType(MuAvatar), findsNothing);
  });
}
