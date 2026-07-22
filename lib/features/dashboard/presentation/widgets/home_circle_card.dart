import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';

/// Compact card for a circle the signed-in user has joined — for the Home
/// dashboard's "Your Circles" preview row.
class HomeCircleCard extends StatelessWidget {
  const HomeCircleCard({required this.circle, required this.onTap, super.key});

  final LearningCircle circle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      child: MuCard(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                gradient: MuColors.heroGradient,
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
              alignment: Alignment.center,
              child: Text(
                circle.title.isNotEmpty ? circle.title[0].toUpperCase() : '?',
                style: MuType.bodyMed.copyWith(color: Colors.white),
              ),
            ),
            const SizedBox(height: MuSpace.s),
            Text(
              circle.title,
              style: MuType.bodyMed,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: MuSpace.xs),
            MuTagChip(label: circle.ig),
            const SizedBox(height: MuSpace.s),
            Row(
              children: [
                const Icon(LucideIcons.users, size: 12, color: MuColors.inkTertiary),
                const SizedBox(width: MuSpace.xs),
                Text('${circle.totalMembers} members', style: MuType.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
