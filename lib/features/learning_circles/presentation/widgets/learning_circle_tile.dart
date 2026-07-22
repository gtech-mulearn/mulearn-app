import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';

class LearningCircleTile extends StatelessWidget {
  const LearningCircleTile({required this.circle, required this.onTap, super.key});

  final LearningCircle circle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.m),
      child: MuCard(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                gradient: MuColors.heroGradient,
                borderRadius: BorderRadius.circular(MuRadius.inner),
              ),
              alignment: Alignment.center,
              child: Text(
                circle.title.isNotEmpty ? circle.title[0].toUpperCase() : '?',
                style: MuType.title.copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    circle.title,
                    style: MuType.bodyMed,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    [circle.ig, if (circle.org != null) circle.org].join(' · '),
                    style: MuType.caption,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: MuSpace.s),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${circle.totalMembers}', style: MuType.statSmall.copyWith(fontSize: 15)),
                Row(
                  children: [
                    const Icon(LucideIcons.users, size: 12, color: MuColors.inkTertiary),
                    const SizedBox(width: 3),
                    Text('members', style: MuType.caption),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
