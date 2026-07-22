import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Shared press-scale behavior for every μLearn button (rules.md §8 —
/// "Pressed: scale 0.97").
class _PressScale extends StatefulWidget {
  const _PressScale({required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

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
        child: widget.child,
      ),
    );
  }
}

/// Primary action button — solid brand blue, full geometry per rules.md §8.
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
      child: Container(
        height: 56,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: disabled ? MuColors.primary.withValues(alpha: 0.4) : MuColors.primary,
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

/// The single most-rewarding action per screen — lime, never more than one
/// on screen at a time (rules.md §8).
class MuLimeButton extends StatelessWidget {
  const MuLimeButton({
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
      child: Container(
        height: compact ? 44 : 56,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: disabled ? MuColors.lime.withValues(alpha: 0.4) : MuColors.lime,
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: compact ? 16 : 20, color: MuColors.limeInk),
              const SizedBox(width: MuSpace.s),
            ],
            Text(
              label,
              style: (compact ? MuType.chip : MuType.bodyMed).copyWith(color: MuColors.limeInk),
            ),
          ],
        ),
      ),
    );
  }
}

/// Bordered secondary action.
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
      child: Container(
        height: 48,
        width: expand ? double.infinity : null,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          border: Border.all(
            color: light ? Colors.white.withValues(alpha: 0.6) : MuColors.divider,
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
            Text(label, style: MuType.bodyMed.copyWith(color: color)),
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
      child: Container(
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
