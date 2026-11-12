import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed.dart';

/// Top-user / top-college highlight card — mirrors the reference
/// dashboard's karma-feed widget.
class KarmaFeedCard extends StatelessWidget {
  const KarmaFeedCard({required this.karmaFeed, super.key});

  final KarmaFeed karmaFeed;

  @override
  Widget build(BuildContext context) {
    if (karmaFeed.topUser == null && karmaFeed.topCollege == null) {
      return const SizedBox.shrink();
    }

    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      child: Row(
        children: [
          if (karmaFeed.topUser case final topUser?)
            Expanded(
              child: _Highlight(
                icon: LucideIcons.trophy,
                label: 'Top learner',
                title: topUser.fullName,
                karma: topUser.karma,
              ),
            ),
          if (karmaFeed.topUser != null && karmaFeed.topCollege != null)
            const SizedBox(width: MuSpace.m),
          if (karmaFeed.topCollege case final topCollege?)
            Expanded(
              child: _Highlight(
                icon: LucideIcons.school,
                label: 'Top college',
                title: topCollege.name,
                karma: topCollege.karma,
              ),
            ),
        ],
      ),
    );
  }
}

class _Highlight extends StatelessWidget {
  const _Highlight({
    required this.icon,
    required this.label,
    required this.title,
    required this.karma,
  });

  final IconData icon;
  final String label;
  final String title;
  final num karma;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: MuColors.primary),
            const SizedBox(width: 4),
            Text(label.toUpperCase(), style: MuType.label),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: MuType.bodyMed,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text('$karma karma', style: MuType.statSmall.copyWith(color: MuColors.primary)),
      ],
    );
  }
}
