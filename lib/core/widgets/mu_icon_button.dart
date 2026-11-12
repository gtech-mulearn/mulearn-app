import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Circular tinted icon button (rules.md §8) — two styles: `tinted` for
/// light/canvas screens, `glass` for gradient headers.
class MuIconButton extends StatelessWidget {
  const MuIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.glass = false,
    this.badge = false,
    this.badgeCount = 0,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;

  /// Use on gradient/dark backgrounds — translucent white instead of tint.
  final bool glass;

  /// Shows a small karma-accent dot.
  final bool badge;

  /// Shows a count pill (hidden at 0, "99+" above 99), e.g. unread
  /// notifications. Takes precedence over [badge].
  final int badgeCount;

  /// What the button does, for screen readers and long-press (UX-08).
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final button = Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: glass ? MuColors.onBrand.withValues(alpha: 0.16) : MuColors.primaryTint,
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
        if (badgeCount > 0)
          Positioned(
            top: 2,
            right: 0,
            child: ExcludeSemantics(
              child: Container(
                constraints: const BoxConstraints(minWidth: 18),
                height: 18,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: const BoxDecoration(
                  color: MuColors.karmaAccent,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                alignment: Alignment.center,
                child: Text(
                  badgeCount > 99 ? '99+' : '$badgeCount',
                  style: MuType.caption.copyWith(color: MuColors.onBrand, fontSize: 11, fontWeight: FontWeight.w700, height: 1),
                ),
              ),
            ),
          )
        else if (badge)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: MuColors.karmaAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
    final label = tooltip;
    if (label == null) return button;
    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(button: true, label: label, onTap: onPressed, excludeSemantics: true, child: button),
    );
  }
}
