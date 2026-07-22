import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';

/// A single ranked row shared by the student and college leaderboard lists —
/// rank in Space Grotesk, avatar, name, karma right-aligned in `primary`
/// (rules.md §8).
class LeaderboardListTile extends StatelessWidget {
  const LeaderboardListTile({
    required this.rank,
    required this.title,
    required this.subtitle,
    required this.karma,
    super.key,
    this.avatarUrl,
  });

  final int rank;
  final String title;
  final String subtitle;
  final num karma;
  final String? avatarUrl;

  Color get _rankColor => switch (rank) {
        1 => MuColors.rankGold,
        2 => MuColors.rankSilver,
        3 => MuColors.rankBronze,
        _ => MuColors.inkTertiary,
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH, vertical: MuSpace.s),
      child: Row(
        children: [
          SizedBox(
            width: 32,
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
