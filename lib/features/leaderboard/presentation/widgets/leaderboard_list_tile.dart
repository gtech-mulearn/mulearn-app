import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

/// A single ranked row shared by the student and college leaderboard lists —
/// rank numeral, avatar, name/subtitle, karma right-aligned in `primary`
/// (DESIGN_SPEC.md §2 "09 — Leaderboard"). Meant to be stacked inside one
/// rounded list card with a hairline divider between rows (set
/// [showDivider] false on the last row).
class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    required this.rank,
    required this.title,
    required this.subtitle,
    required this.karma,
    super.key,
    this.avatarUrl,
    this.showDivider = true,
  });

  final int rank;
  final String title;
  final String subtitle;
  final num karma;
  final String? avatarUrl;
  final bool showDivider;

  Color get _rankColor => switch (rank) {
        1 => MuColors.rankGold,
        2 => MuColors.rankSilver,
        3 => MuColors.rankBronze,
        _ => MuColors.inkFaint,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: showDivider ? MuColors.hairline : Colors.transparent),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Text(
              '$rank',
              style: MuType.statSmall.copyWith(color: _rankColor),
            ),
          ),
          const SizedBox(width: MuSpace.s),
          ProfileAvatar(url: avatarUrl, name: title, size: 40),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: MuType.bodyMed, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(subtitle, style: MuType.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          Text('$karma', style: MuType.statSmall.copyWith(color: MuColors.primary)),
        ],
      ),
    );
  }
}
