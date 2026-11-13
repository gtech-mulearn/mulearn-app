import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/events/mu_event_ticket.dart';
import 'package:mulearn_app/core/design_system/input/mu_button.dart';
import 'package:mulearn_app/core/design_system/input/mu_pill.dart';

void main() {
  test('the ticket outline has a notch on each side at the perforation', () {
    const border = MuTicketBorder(perforationFromBottom: 92);
    const rect = Rect.fromLTWH(0, 0, 320, 500);
    final path = border.getOuterPath(rect);
    expect(path.contains(const Offset(4, 500 - 92)), isFalse); // left notch
    expect(path.contains(const Offset(316, 500 - 92)), isFalse); // right notch
    expect(path.contains(const Offset(4, 250)), isTrue); // body
    expect(path.contains(const Offset(160, 500 - 92)), isTrue); // middle of the line
  });

  testWidgets('listing ticket shows the event, opens it, and runs its stub action', (tester) async {
    var opened = 0;
    var registered = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: MuEventTicket(
                title: 'Learning Fest 2026',
                when: 'Until 30 Nov · Online',
                posterTitle: 'Learning Fest 26',
                capacity: const MuPill('92 interested', tone: MuPillTone.night),
                kind: const MuPill('Bootcamp', tone: MuPillTone.paper),
                pills: const [
                  MuPill('Earn karma', tone: MuPillTone.volt),
                  MuPill('11 weeks'),
                ],
                stub: MuButton(
                  label: 'Register',
                  variant: MuButtonVariant.ink,
                  knob: true,
                  block: true,
                  onPressed: () => registered++,
                ),
                onTap: () => opened++,
              ),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Learning Fest 2026'), findsOneWidget);
    expect(find.text('LEARNING FEST 26'), findsOneWidget);
    await tester.tap(find.text('Learning Fest 2026'));
    await tester.pumpAndSettle();
    expect(opened, 1);
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();
    expect(registered, 1);
    expect(tester.takeException(), isNull);
  });
}
