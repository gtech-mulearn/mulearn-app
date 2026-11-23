import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(
    body: Center(
      child: SizedBox(width: 320, child: SingleChildScrollView(child: child)),
    ),
  ),
);

const _sjc = 'St Josephs College of Engineering and Technology Palai';

const _top = [
  MuCampusRank(
    name: 'Mar Baselios College of Engineering and Technology',
    code: 'MBT',
    karma: 4200413,
    detail: '2,671 learners',
  ),
  MuCampusRank(
    name: _sjc,
    code: 'SJC',
    karma: 3027145,
    detail: '2,469 learners',
  ),
  MuCampusRank(
    name: 'Marian Engineering College',
    code: 'MCE',
    karma: 1249700,
    detail: '1,947 learners',
  ),
];

/// Campus mode of the leaderboard (layout A, 2026-11-23): the top three as
/// podium cards, then seal rows; whole names, never cut.
void main() {
  testWidgets('podium cards show whole names and open by index', (
    tester,
  ) async {
    int? opened;
    await tester.pumpWidget(
      _host(MuCampusPodium(top: _top, onOpen: (i) => opened = i)),
    );

    expect(tester.widget<Text>(find.text(_sjc)).maxLines, isNull);
    await tester.tap(find.text(_sjc));
    expect(opened, 1);
  });

  testWidgets('podium with fewer than three', (tester) async {
    await tester.pumpWidget(_host(MuCampusPodium(top: _top.sublist(0, 1))));
    expect(find.bySemanticsLabel(RegExp('^Rank 1, ')), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('^Rank 2, ')), findsNothing);

    await tester.pumpWidget(_host(MuCampusPodium(top: _top.sublist(0, 2))));
    expect(find.bySemanticsLabel(RegExp('^Rank 2, ')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('rank row: bar scales to #1, chevron only when tappable', (
    tester,
  ) async {
    const awh = MuCampusRank(
      name: 'AWH Engineering College',
      code: 'AWH',
      karma: 894306,
      detail: '1,240 learners',
    );
    await tester.pumpWidget(
      _host(const MuCampusRankRow(rank: 4, entry: awh, maxKarma: 4200413)),
    );

    final bar = tester.widget<FractionallySizedBox>(
      find.byType(FractionallySizedBox),
    );
    expect(bar.widthFactor, closeTo(894306 / 4200413, 0.001));
    // The cobalt fill is drawn, 4 tall, scaled against the full track.
    final fill = find.descendant(
      of: find.byType(FractionallySizedBox),
      matching: find.byType(ColoredBox),
    );
    final track = tester.getSize(
      find
          .ancestor(
            of: find.byType(FractionallySizedBox),
            matching: find.byType(Stack),
          )
          .first,
    );
    expect(tester.getSize(fill).height, 4);
    expect(
      tester.getSize(fill).width,
      closeTo(track.width * 894306 / 4200413, 1),
    );
    expect(find.byIcon(LucideIcons.chevronRight), findsNothing);

    var taps = 0;
    await tester.pumpWidget(
      _host(
        MuCampusRankRow(
          rank: 4,
          entry: awh,
          maxKarma: 4200413,
          onTap: () => taps++,
        ),
      ),
    );
    expect(find.byIcon(LucideIcons.chevronRight), findsOneWidget);
    await tester.tap(find.text('AWH Engineering College'));
    expect(taps, 1);
  });

  testWidgets('cards and rows can be opened by accessibility services', (
    tester,
  ) async {
    await tester.pumpWidget(_host(MuCampusPodium(top: _top, onOpen: (_) {})));
    expect(
      tester.getSemantics(find.bySemanticsLabel(RegExp('^Rank 2, '))),
      isSemantics(isButton: true, hasTapAction: true),
    );

    await tester.pumpWidget(
      _host(
        MuCampusRankRow(rank: 4, entry: _top[2], maxKarma: 1, onTap: () {}),
      ),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel(RegExp('^Rank 4, '))),
      isSemantics(isButton: true, hasTapAction: true),
    );
  });

  testWidgets('every card line reads at 4.5:1', (tester) async {
    await tester.pumpWidget(_host(const MuCampusPodium(top: _top)));
    final c = tester.element(find.byType(MuCampusPodium)).mu.colors;
    final fills = [c.volt, c.cobalt, c.night];
    for (var i = 0; i < 3; i++) {
      final meta = tester.widget<RichText>(
        find.byWidgetPredicate(
          (w) =>
              w is RichText &&
              w.text.toPlainText().startsWith(muGrouped(_top[i].karma)),
        ),
      );
      final fg = (meta.text as TextSpan).style!.color!;
      expect(
        _contrast(Color.alphaBlend(fg, fills[i]), fills[i]),
        greaterThanOrEqualTo(4.5),
        reason: 'card ${i + 1}',
      );
    }
  });

  testWidgets('an inverse seal code reads at 4.5:1 on cobalt and night', (
    tester,
  ) async {
    for (final ground in [
      (MuPalette c) => c.cobalt,
      (MuPalette c) => c.night,
    ]) {
      await tester.pumpWidget(
        _host(
          Builder(
            builder: (context) => ColoredBox(
              color: ground(context.mu.colors),
              child: const Center(
                child: MuCampusSeal(code: 'SJC', size: 44, inverse: true),
              ),
            ),
          ),
        ),
      );
      final c = tester.element(find.byType(MuCampusSeal)).mu.colors;
      final paint = tester.widget<CustomPaint>(
        find.descendant(
          of: find.byType(MuCampusSeal),
          matching: find.byType(CustomPaint),
        ),
      );
      // ignore: avoid_dynamic_calls — the painter is private to the seal.
      final fill = (paint.painter! as dynamic).fill as Color;
      final ink = tester.widget<Text>(find.text('SJC')).style!.color!;
      final bg = Color.alphaBlend(fill, ground(c));
      expect(_contrast(ink, bg), greaterThanOrEqualTo(4.5));
    }
  });

  testWidgets('your campus row caption reads at 4.5:1 on its tint', (
    tester,
  ) async {
    const chn = MuCampusRank(
      name: 'College of Engineering Chengannur',
      karma: 674713,
      detail: '1,099 learners',
      isMine: true,
    );
    await tester.pumpWidget(
      _host(const MuCampusRankRow(rank: 7, entry: chn, maxKarma: 4200413)),
    );
    final c = tester.element(find.byType(MuCampusRankRow)).mu.colors;
    final meta = tester.widget<RichText>(
      find.byWidgetPredicate(
        (w) => w is RichText && w.text.toPlainText().startsWith('674,713'),
      ),
    );
    final fg = (meta.text as TextSpan).style!.color!;
    expect(
      _contrast(Color.alphaBlend(fg, c.cobaltTint), c.cobaltTint),
      greaterThanOrEqualTo(4.5),
    );
  });

  testWidgets('your campus is tagged and announced', (tester) async {
    const chn = MuCampusRank(
      name: 'College of Engineering Chengannur',
      code: 'CHN',
      karma: 674713,
      detail: '1,099 learners',
      isMine: true,
    );
    await tester.pumpWidget(
      _host(const MuCampusRankRow(rank: 7, entry: chn, maxKarma: 4200413)),
    );

    expect(find.text('Your campus'), findsOneWidget);
    expect(
      find.bySemanticsLabel(
        'Rank 7, College of Engineering Chengannur, 674,713 karma, '
        '1,099 learners, your campus',
      ),
      findsOneWidget,
    );
  });
}

double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}
