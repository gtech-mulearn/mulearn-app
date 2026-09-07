import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/mu_haptics.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';

/// Once-a-day celebratory popup on [LeaderboardScreen] — "you're #N, X
/// karma" — built entirely from `currentUserRankSummaryProvider` (real
/// `rank`/`karma`/`percentile` fields off the user-profile endpoint, no
/// invented data). Gated to at most one showing per calendar day by
/// `RankPopupGate`; the screen decides when to call [show], this widget is
/// just the visual.
class RankSummaryPopup extends StatelessWidget {
  const RankSummaryPopup({
    required this.rank,
    required this.karma,
    this.percentile,
    super.key,
  });

  final int? rank;
  final int karma;
  final double? percentile;

  static Future<void> show(
    BuildContext context, {
    required int? rank,
    required int karma,
    double? percentile,
  }) {
    MuHaptics.medium();
    return showDialog<void>(
      context: context,
      builder: (_) => RankSummaryPopup(
        rank: rank,
        karma: karma,
        percentile: percentile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: MuColors.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: MuSpace.xxl),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MuRadius.hero),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          MuSpace.xl,
          MuSpace.xxl,
          MuSpace.xl,
          MuSpace.xl,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                gradient: MuColors.karmaGradient,
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.trophy, color: Colors.white, size: 30),
            ),
            const SizedBox(height: MuSpace.l),
            Text(
              rank != null ? "You're ranked #$rank" : 'Keep going!',
              style: MuType.headline,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MuSpace.s),
            Text(
              percentile != null
                  ? 'Top ${percentile!.toStringAsFixed(percentile! < 10 ? 1 : 0)}% among all learners, with $karma karma.'
                  : "You've earned $karma karma so far. Keep it up!",
              style: MuType.body.copyWith(color: MuColors.inkSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: MuSpace.xl),
            MuPrimaryButton(
              label: 'Nice!',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
