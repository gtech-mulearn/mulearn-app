import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// Circular tinted icon button (rules.md §8) — two styles: `tinted` for
/// light/canvas screens, `glass` for gradient headers.
class MuIconButton extends StatelessWidget {
  const MuIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.glass = false,
    this.badge = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  /// Use on gradient/dark backgrounds — translucent white instead of tint.
  final bool glass;

  /// Shows a small lime dot (e.g. unread notifications).
  final bool badge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: glass ? Colors.white.withValues(alpha: 0.16) : MuColors.primaryTint,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onPressed,
            customBorder: const CircleBorder(),
            child: SizedBox(
              height: 44,
              width: 44,
              child: Icon(
                icon,
                size: 20,
                color: glass ? MuColors.surface : MuColors.primary,
              ),
            ),
          ),
        ),
        if (badge)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: MuColors.limeBright,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
