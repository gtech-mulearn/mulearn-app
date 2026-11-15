import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_leaderboard.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_level_path.dart';
import 'package:mulearn_app/core/design_system/mulearn/mu_voice_bubble.dart';

Widget _host(Widget child) => MaterialApp(
  home: Scaffold(
    body: Center(child: SizedBox(width: 320, child: child)),
  ),
);

void main() {
  test('karma numbers are grouped', () {
    expect(muGrouped(12480), '12,480');
    expect(muGrouped(73953), '73,953');
    expect(muGrouped(999), '999');
    expect(muGrouped(1000000), '1,000,000');
  });

  testWidgets('level path announces each stop and opens it', (tester) async {
    MuLevelStop? opened;
    await tester.pumpWidget(
      _host(
        MuLevelPath(
          onOpen: (s) => opened = s,
          stops: const [
            MuLevelStop(
              number: 3,
              title: 'Level 3',
              state: MuStopState.done,
              meta: '144 tasks · 9 done',
            ),
            MuLevelStop(
              number: 4,
              title: 'Level 4',
              state: MuStopState.now,
              meta: '264 tasks',
              progress: 0.68,
            ),
            MuLevelStop(
              number: 5,
              title: 'Level 5',
              state: MuStopState.locked,
              meta: '108 tasks',
            ),
          ],
        ),
      ),
    );
    expect(
      find.bySemanticsLabel("Level 4, you're here, 264 tasks"),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Level 5, locked, 108 tasks'), findsOneWidget);
    expect(find.text("You're here · 68%"), findsOneWidget);
    await tester.tap(find.bySemanticsLabel("Level 4, you're here, 264 tasks"));
    expect(opened?.number, 4);
  });

  testWidgets('podium orders 2-1-3 with #1 tallest; rows scale bars to #1', (
    tester,
  ) async {
    const top = [
      MuRankEntry(name: 'Nikhil K', karma: 52940),
      MuRankEntry(name: 'Rahul V', karma: 48210),
      MuRankEntry(name: 'Sneha M', karma: 45005),
    ];
    await tester.pumpWidget(
      _host(
        const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MuPodium(top: top),
            MuRankRow(
              rank: 14,
              entry: MuRankEntry(name: 'Aysha', karma: 12480, subtitle: 'CET'),
              maxKarma: 52940,
              isMe: true,
            ),
          ],
        ),
      ),
    );
    final second = tester.getCenter(find.text('Rahul V')).dx;
    final first = tester.getCenter(find.text('Nikhil K')).dx;
    final third = tester.getCenter(find.text('Sneha M')).dx;
    expect(second < first && first < third, isTrue);
    expect(
      find.bySemanticsLabel('Rank 1, Nikhil K, 52,940 karma'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel('Rank 14, You · Aysha, CET, 12,480 karma'),
      findsOneWidget,
    );
    final bar = tester.widget<FractionallySizedBox>(
      find.byType(FractionallySizedBox),
    );
    expect(bar.widthFactor, closeTo(12480 / 52940, 1e-9));
    expect(tester.takeException(), isNull);
  });

  testWidgets('voice bubble renders its line', (tester) async {
    await tester.pumpWidget(
      _host(const MuVoiceBubble('Nobody learns alone', tone: MuVoiceTone.volt)),
    );
    expect(find.text('Nobody learns alone'), findsOneWidget);
  });
}
