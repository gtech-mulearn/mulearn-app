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
