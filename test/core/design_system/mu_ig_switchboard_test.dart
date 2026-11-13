import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/content/mu_ig_sticker.dart';
import 'package:mulearn_app/core/design_system/navigation/mu_switchboard.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';

Widget _host(Widget child, {bool reduceMotion = false}) => MaterialApp(
  home: MediaQuery(
    data: MediaQueryData(disableAnimations: reduceMotion, size: const Size(360, 760)),
    child: Scaffold(
      body: Center(child: SizedBox(width: 320, child: child)),
    ),
  ),
);

void main() {
  testWidgets('sticker announces itself and joins', (tester) async {
    var joins = 0;
    await tester.pumpWidget(
      _host(
        MuIgSticker(
          name: 'Web Development',
          category: IgCategory.coder,
          code: 'web',
          members: 4100,
          onJoin: () => joins++,
        ),
      ),
    );
    expect(find.text('WEB · CODER'), findsOneWidget);
    expect(find.text('4.1k'), findsOneWidget);
    expect(find.bySemanticsLabel('Web Development, coder Interest Group, 4100 members'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Join Web Development'));
    await tester.pumpAndSettle();
    expect(joins, 1);
  });

  testWidgets('a joining sticker shows progress and ignores taps', (tester) async {
    var joins = 0;
    await tester.pumpWidget(
      _host(MuIgSticker(name: 'Ui Ux', category: IgCategory.creative, joining: true, onJoin: () => joins++)),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Join Ui Ux'));
    await tester.pump();
    expect(joins, 0);
  });

  testWidgets('switchboard doors open and the pulse is read once', (tester) async {
    final opened = <String>[];
    MuDoor door(String l) =>
        MuDoor(label: l, icon: LucideIcons.hash, tone: IgCategory.coder, onTap: () => opened.add(l));
    await tester.pumpWidget(
      _host(
        MuSwitchboard(
          doors: [door('Events'), door('Interest Groups'), door('Learning Circles'), door('Campuses')],
          pulse: const ['73,953 learners', '2,338 learning circles'],
        ),
        reduceMotion: true,
      ),
    );
    await tester.tap(find.bySemanticsLabel('Learning Circles'));
    expect(opened, ['Learning Circles']);
    expect(find.bySemanticsLabel('73,953 learners. 2,338 learning circles'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the pulse scrolls when motion is allowed', (tester) async {
    await tester.pumpWidget(
      _host(const MuPulseStrip(items: ['73,953 learners', '2,338 learning circles', '1,949 campuses', '492 mentors'])),
    );
    final scroll = tester.widget<ListView>(find.byType(ListView)).controller!;
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    await tester.pump(const Duration(milliseconds: 50));
    expect(scroll.offset, greaterThan(0));
    await tester.pumpWidget(const SizedBox());
  });
}
