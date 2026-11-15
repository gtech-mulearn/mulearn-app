import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/feedback/mu_sheet.dart';
import 'package:mulearn_app/core/design_system/input/mu_button.dart';

Widget _host(Future<void> Function(BuildContext) open) => MaterialApp(
  home: Scaffold(
    body: Builder(
      builder: (context) => Center(
        child: TextButton(
          onPressed: () => open(context),
          child: const Text('open'),
        ),
      ),
    ),
  ),
);

void main() {
  testWidgets('sheet shows its body and closes on a scrim tap', (tester) async {
    await tester.pumpWidget(
      _host(
        (context) => showMuSheet<void>(
          context,
          builder: (_) => MuSheetBody(
            eyebrow: 'One step',
            title: 'Sign in to register for IoT Build Night',
            body: "We'll bring you straight back here.",
            actions: [
              MuButton(
                label: 'Continue with Google',
                block: true,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('ONE STEP'), findsOneWidget);
    expect(
      find.text('Sign in to register for IoT Build Night'),
      findsOneWidget,
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Sign in to register for IoT Build Night'), findsNothing);
  });

  testWidgets('confirm resolves true on confirm, false on cancel', (
    tester,
  ) async {
    bool? result;
    await tester.pumpWidget(
      _host(
        (context) async => result = await showMuConfirm(
          context,
          title: 'Leave Pandas Saturdays?',
          body: "You'll lose your seat.",
          confirmLabel: 'Leave',
          destructive: true,
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Leave'));
    await tester.pumpAndSettle();
    expect(result, isTrue);

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  testWidgets('a destructive confirm ignores scrim taps', (tester) async {
    await tester.pumpWidget(
      _host(
        (context) => showMuConfirm(
          context,
          title: 'Delete session?',
          confirmLabel: 'Delete',
          destructive: true,
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.text('Delete session?'), findsOneWidget);
  });
}
