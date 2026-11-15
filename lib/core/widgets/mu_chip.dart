import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

enum MuTagStyle { neutral, deadline, success, warning, karmaNew }

/// Non-interactive metadata pill (e.g. "High Priority", "2 days left").
class MuTagChip extends StatelessWidget {
  const MuTagChip({
    required this.label,
    super.key,
    this.style = MuTagStyle.neutral,
  });

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
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MuRadius.chip),
      ),
      alignment: Alignment.center,
      child: Text(label, style: MuType.chip.copyWith(color: fg, fontSize: 12)),
    );
  }
}
