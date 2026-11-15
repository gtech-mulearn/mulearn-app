import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/content/mu_bento.dart';
import 'package:mulearn_app/core/design_system/content/mu_slab.dart';
import 'package:mulearn_app/core/design_system/input/mu_pill.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme_data.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(
    body: Center(child: SizedBox(width: 320, child: child)),
  ),
);

void main() {
  testWidgets('slab shows its content and opens', (tester) async {
    var opened = 0;
    await tester.pumpWidget(
      _host(
        MuSlab(
          title: "Today's challenge",
          badge: const MuPill('+200 karma', tone: MuPillTone.paper),
          body: 'Find Better · #ge-find-better',
          seed: 'ge-find-better',
          onTap: () => opened++,
        ),
      ),
    );
    expect(find.text("Today's challenge"), findsOneWidget);
    expect(find.text('+200 karma'), findsOneWidget);
    await tester.tap(find.byType(MuSlab));
    expect(opened, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('tiles fill by IG category and stack into two columns', (tester) async {
    await tester.pumpWidget(
      _host(
        MuBento(
          tiles: [
            MuTile(title: 'IoT & Robotics Circle', category: IgCategory.maker, size: MuTileSize.tall, onTap: () {}),
            MuTile(title: 'ToDo List', category: IgCategory.coder, onTap: () {}),
            const MuTile(title: 'Connect Discord', category: IgCategory.creative, size: MuTileSize.short),
          ],
        ),
      ),
    );
    final maker = tester.getTopLeft(find.text('IoT & Robotics Circle'));
    final coder = tester.getTopLeft(find.text('ToDo List'));
    final creative = tester.getTopLeft(find.text('Connect Discord'));
    expect(coder.dx, greaterThan(maker.dx)); // second column
    expect(creative.dx, coder.dx); // under the square tile
    expect(creative.dy, greaterThan(coder.dy));

    final fills = tester
        .widgetList<Container>(find.descendant(of: find.byType(MuTile), matching: find.byType(Container)))
        .map((c) => (c.decoration as BoxDecoration?)?.color)
        .toSet();
    expect(fills, containsAll([MuPalette.light.igMaker, MuPalette.light.igCoder, MuPalette.light.igCreative]));
    expect(tester.takeException(), isNull);
  });

  testWidgets('a wide tile spans both columns', (tester) async {
    await tester.pumpWidget(
      _host(
        const MuBento(
          tiles: [MuTile(title: 'Pick an Interest Group to get your first tasks', size: MuTileSize.wide)],
        ),
      ),
    );
    expect(tester.getSize(find.byType(MuTile)).width, 320);
  });

  testWidgets('a tile alone on its row spans the row; pairs share a height', (tester) async {
    await tester.pumpWidget(
      _host(
        MuBento(
          tiles: [
            MuTile(title: 'Find a task', category: IgCategory.coder, onTap: () {}),
            MuTile(title: 'Learning circles', category: IgCategory.maker, meta: 'Learn with a group', onTap: () {}),
            MuTile(title: 'Internships & gigs', category: IgCategory.creative, onTap: () {}),
          ],
        ),
      ),
    );
    final a = tester.getRect(find.widgetWithText(MuTile, 'Find a task'));
    final b = tester.getRect(find.widgetWithText(MuTile, 'Learning circles'));
    final c = tester.getRect(find.widgetWithText(MuTile, 'Internships & gigs'));
    expect(a.height, b.height);
    expect(a.top, b.top);
    expect(c.width, 320, reason: 'the odd one out takes the whole row');
    expect(tester.takeException(), isNull);
  });

  testWidgets('a single tile of any size fills the board', (tester) async {
    await tester.pumpWidget(
      _host(
        const MuBento(
          tiles: [MuTile(title: 'Connect Discord', size: MuTileSize.short)],
        ),
      ),
    );
    expect(tester.getSize(find.byType(MuTile)).width, 320);
  });
  testWidgets('paper pills stay white in dark theme', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: MuThemeData.dark(),
        home: const Scaffold(
          body: Center(child: MuPill('+200 karma', tone: MuPillTone.paper)),
        ),
      ),
    );
    final box = tester.widget<Container>(find.descendant(of: find.byType(MuPill), matching: find.byType(Container)));
    final fill = (box.decoration! as BoxDecoration).color!;
    expect(fill.computeLuminance(), greaterThan(0.9));
  });
}
