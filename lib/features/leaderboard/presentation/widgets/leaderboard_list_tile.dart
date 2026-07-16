import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';

/// A single ranked row shared by the student and college leaderboard lists —
/// rank badge, optional avatar, title/subtitle, and a trailing karma value.
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
        1 => MulearnColors.rankGold,
        2 => MulearnColors.rankSilver,
        3 => MulearnColors.rankBronze,
        _ => MulearnColors.gray600,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Stack(
        alignment: Alignment.center,
        children: [
          if (avatarUrl != null)
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: avatarUrl!,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) => const DecoratedBox(
                  decoration: BoxDecoration(gradient: MulearnGradients.trusty),
                ),
              ),
            )
          else
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                gradient: MulearnGradients.trusty,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(subtitle, maxLines: 1, overflow: TextOverflow.ellipsis),
      leadingAndTrailingTextStyle: theme.textTheme.bodyMedium,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: _rankColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '#$rank',
              style: TextStyle(
                color: _rankColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 2),
          Text('$karma karma', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}
