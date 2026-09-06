import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Builds a button's content given whether it's currently pressed — lets
/// buttons swap in their hover/pressed color (mobile has no hover, so
/// "pressed" stands in for the design's `:hover` states).
// ignore: avoid_positional_boolean_parameters
typedef MuPressBuilder = Widget Function(BuildContext context, bool pressed);

/// Shared press-scale behavior for every μLearn button (rules.md §8 —
/// "Pressed: scale 0.97").
class _PressScale extends StatefulWidget {
  const _PressScale({required this.onPressed, required this.builder});

  final VoidCallback? onPressed;
  final MuPressBuilder builder;

  @override
  State<_PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<_PressScale> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onPressed == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1,
        duration: const Duration(milliseconds: 100),
        child: widget.builder(context, _pressed),
      ),
    );
  }
}

/// Primary action button — solid brand blue pill with a glow shadow
/// (rules.md §8 / DESIGN_SPEC.md §1 "Primary button").
class MuPrimaryButton extends StatelessWidget {
  const MuPrimaryButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    return _PressScale(
      onPressed: onPressed,
      builder: (context, pressed) => Container(
        height: 56,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: disabled
              ? MuColors.primary.withValues(alpha: 0.4)
              : pressed
                  ? MuColors.primaryHover
                  : MuColors.primary,
          borderRadius: BorderRadius.circular(MuRadius.chip),
          boxShadow: disabled ? null : MuShadow.buttonGlow,
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: MuColors.surface),
              const SizedBox(width: MuSpace.s),
            ],
            Text(
              label,
              style: MuType.bodyMed.copyWith(
                color: MuColors.surface,
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The single most-rewarding action per screen — karma-purple, never more
/// than one on screen at a time (rules.md §8). Replaces the retired lime
/// accent: karma/reward now reads as purple ([MuColors.karmaAccent]).
class MuKarmaButton extends StatelessWidget {
  const MuKarmaButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon = Icons.bolt,
    this.expand = true,
    this.compact = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    return _PressScale(
      onPressed: onPressed,
      builder: (context, pressed) => Container(
        height: compact ? 44 : 56,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: disabled ? MuColors.karmaAccent.withValues(alpha: 0.4) : MuColors.karmaAccent,
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: compact ? 16 : 20, color: MuColors.surface),
              const SizedBox(width: MuSpace.s),
            ],
            Text(
              label,
              style: (compact ? MuType.chip : MuType.bodyMed).copyWith(color: MuColors.surface),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bordered secondary action — the OAuth-button pill treatment
/// (DESIGN_SPEC.md §1 "Outline pill button").
class MuGhostButton extends StatelessWidget {
  const MuGhostButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.expand = true,
    this.light = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  /// On a dark/gradient background — border and text become white.
  final bool light;

  @override
  Widget build(BuildContext context) {
    final color = light ? MuColors.surface : MuColors.ink;
    return _PressScale(
      onPressed: onPressed,
      builder: (context, pressed) => Container(
        height: 54,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: light
              ? Colors.transparent
              : (pressed ? MuColors.surface : MuColors.surface.withValues(alpha: 0.7)),
          border: Border.all(
            color: light
                ? Colors.white.withValues(alpha: pressed ? 0.9 : 0.6)
                : (pressed ? MuColors.ink : MuColors.divider),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18, color: color),
              const SizedBox(width: MuSpace.s),
            ],
            Text(
              label,
              style: MuType.bodyMed.copyWith(color: color, fontSize: 14.5, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

/// Finalizing/completing action — solid ink black (rules.md §8, "Mark as
/// Complete").
class MuDarkButton extends StatelessWidget {
  const MuDarkButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    return _PressScale(
      onPressed: onPressed,
      builder: (context, pressed) => Container(
        height: 56,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: disabled ? MuColors.ink.withValues(alpha: 0.4) : MuColors.ink,
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20, color: MuColors.surface),
              const SizedBox(width: MuSpace.s),
            ],
            Text(label, style: MuType.bodyMed.copyWith(color: MuColors.surface)),
          ],
        ),
      ),
    );
  }
}
