import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

enum MuCardVariant {
  /// White surface, soft shadow — the default, for canvas-background screens.
  surface,

  /// Tinted blue bg, no shadow — attachments/info blocks.
  tinted,

  /// White surface, no shadow — for stacking directly on a gradient header.
  onGradient,
}

/// Primary rounded card container (rules.md §8).
class MuCard extends StatelessWidget {
  const MuCard({
    required this.child,
    super.key,
    this.variant = MuCardVariant.surface,
    this.padding = const EdgeInsets.all(MuSpace.xl),
    this.onTap,
  });

  final Widget child;
  final MuCardVariant variant;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg = switch (variant) {
      MuCardVariant.surface => MuColors.surface,
      MuCardVariant.tinted => MuColors.primarySoft,
      MuCardVariant.onGradient => MuColors.surface,
    };
    final shadow = variant == MuCardVariant.surface ? MuShadow.card : null;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MuRadius.card),
        boxShadow: shadow,
      ),
      child: child,
    );

    if (onTap == null) return content;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(MuRadius.card),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MuRadius.card),
        child: content,
      ),
    );
  }
}
