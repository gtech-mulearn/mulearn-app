import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Selectable filter pill (rules.md §8) — for filter rows (e.g. "All /
/// Active / Completed"). Unselected: white + divider border. Selected: solid
/// ink.
class MuFilterChip extends StatelessWidget {
  const MuFilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 36,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? MuColors.ink : MuColors.surface,
          borderRadius: BorderRadius.circular(MuRadius.chip),
          border: selected ? null : Border.all(color: MuColors.divider),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: MuType.chip.copyWith(
            color: selected ? MuColors.surface : MuColors.inkSecondary,
          ),
        ),
      ),
    );
  }
}

/// Metadata tag style — semantic color variants. [neutral] doubles as the
/// design's "IG tag" pill (blue tint); [karmaNew] is the solid "NEW"-badge
/// treatment (karma purple bg, white fg) rather than a tint pair.
enum MuTagStyle { neutral, deadline, success, warning, karmaNew }

/// Non-interactive metadata pill (e.g. "High Priority", "2 days left").
class MuTagChip extends StatelessWidget {
  const MuTagChip({required this.label, super.key, this.style = MuTagStyle.neutral});

  final String label;
  final MuTagStyle style;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (style) {
      MuTagStyle.neutral => (MuColors.primaryTint, MuColors.primary),
      MuTagStyle.deadline => (MuColors.errorBg, MuColors.error),
      MuTagStyle.success => (MuColors.successBg, MuColors.success),
      MuTagStyle.warning => (MuColors.warningBg, MuColors.warning),
      MuTagStyle.karmaNew => (MuColors.karmaAccent, MuColors.surface),
    };
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(MuRadius.chip)),
      alignment: Alignment.center,
      child: Text(label, style: MuType.chip.copyWith(color: fg, fontSize: 12)),
    );
  }
}
