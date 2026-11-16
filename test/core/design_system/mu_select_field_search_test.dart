import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

/// A select whose list is too long to download (every college) searches the
/// server as the person types: 2+ letters, debounced, the pick named in the
/// field.
void main() {
  testWidgets('searches the server, debounced, and names the pick', (
    tester,
  ) async {
    final asked = <String>[];
    String? value;
    String? name;
    await tester.pumpWidget(
      MaterialApp(
        theme: MuThemeData.light(),
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => MuSelectField(
              label: 'College',
              hint: 'Search your college',
              options: const [],
              value: value,
              selectedLabel: name,
              onChanged: (v) => setState(() => value = v),
              onPicked: (o) => setState(() => name = o.label),
              search: (q) async {
                asked.add(q);
                return const [MuOption('cet', 'College of Engineering')];
              },
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Search your college'));
    await tester.pumpAndSettle();
    expect(find.text('Type at least 2 letters to search.'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'c');
    await tester.pump(const Duration(milliseconds: 400));
    expect(asked, isEmpty, reason: 'one letter asks nothing');

    await tester.enterText(find.byType(EditableText), 'co');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(EditableText), 'col');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    expect(asked, ['col'], reason: 'quick typing asks once, for the latest');

    await tester.tap(find.text('College of Engineering'));
    await tester.pumpAndSettle();
    expect(value, 'cet');
    expect(find.text('College of Engineering'), findsOneWidget);
  });
}
