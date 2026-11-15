import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/navigation/mu_segmented.dart';

void main() {
  testWidgets('segments are selectable buttons and report the tapped option', (
    tester,
  ) async {
    var selected = 'Students';
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: StatefulBuilder(
                builder: (context, setState) => MuSegmented<String>(
                  values: const ['Students', 'Colleges'],
                  selected: selected,
                  label: (v) => v,
                  onChanged: (v) => setState(() => selected = v),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Students')),
      isSemantics(isSelected: true, isButton: true),
    );
    await tester.tap(find.bySemanticsLabel('Colleges'));
    await tester.pumpAndSettle();
    expect(selected, 'Colleges');
    expect(
      tester.getSemantics(find.bySemanticsLabel('Colleges')),
      isSemantics(isSelected: true, isButton: true),
    );
  });
}
