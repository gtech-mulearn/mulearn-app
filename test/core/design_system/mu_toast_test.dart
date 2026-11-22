import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/feedback/mu_toast.dart';

Widget _host(void Function(BuildContext) onPressed) => MaterialApp(
  home: Scaffold(
    body: Builder(
      builder: (context) => Center(
        child: TextButton(
          onPressed: () => onPressed(context),
          child: const Text('go'),
        ),
      ),
    ),
  ),
);

void main() {
  testWidgets('shows from the top and leaves after its duration', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        (c) =>
            MuToast.show(c, message: 'Registered', type: MuToastType.success),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('Registered'), findsOneWidget);
    expect(tester.getTopLeft(find.text('Registered')).dy, lessThan(200));

    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
    expect(find.text('Registered'), findsNothing);
  });

  testWidgets('a new toast replaces the old one', (tester) async {
    var n = 0;
    await tester.pumpWidget(
      _host((c) => MuToast.show(c, message: 'Toast ${++n}')),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    expect(find.text('Toast 1'), findsNothing);
    expect(find.text('Toast 2'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();
  });

  testWidgets('the action runs and closes the toast', (tester) async {
    var undone = 0;
    await tester.pumpWidget(
      _host(
        (c) => MuToast.show(
          c,
          message: 'Left Web Development',
          type: MuToastType.karma,
          action: MuToastAction('Undo', () => undone++),
        ),
      ),
    );
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(undone, 1);
    expect(find.text('Left Web Development'), findsNothing);
  });

  testWidgets('swiping up dismisses', (tester) async {
    await tester.pumpWidget(_host((c) => MuToast.show(c, message: 'Swipe me')));
    await tester.tap(find.text('go'));
    await tester.pumpAndSettle();
    await tester.fling(find.text('Swipe me'), const Offset(0, -80), 800);
    await tester.pumpAndSettle();
    expect(find.text('Swipe me'), findsNothing);
  });

  testWidgets('nudge dismisses through its close button', (tester) async {
    var closed = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MuNudge(
            message: 'You have 2 circle meetings today.',
            icon: LucideIcons.calendar,
            onDismiss: () => closed++,
          ),
        ),
      ),
    );
    await tester.tap(find.bySemanticsLabel('Dismiss'));
    await tester.pumpAndSettle();
    expect(closed, 1);
  });
}
