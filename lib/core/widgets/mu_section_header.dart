import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// UPPERCASE eyebrow section header with an optional trailing "View all"
/// (rules.md §8) — use this instead of a bold Title Case heading everywhere.
class MuSectionHeader extends StatelessWidget {
  const MuSectionHeader({
    required this.title,
    super.key,
    this.onViewAll,
  });

  final String title;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
      child: Row(
        children: [
          Expanded(
            child: Text(title.toUpperCase(), style: MuType.eyebrow),
          ),
          if (onViewAll != null)
            GestureDetector(
              onTap: onViewAll,
              child: Text(
                'View all',
                style: MuType.chip.copyWith(color: MuColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
