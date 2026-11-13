import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A 36dp filter pill: `surface` with a hairline ring, `night` when
/// selected. Rows of these scroll sideways, first chip "All".
class MuFilterChip extends StatelessWidget {
  /// A chip reading [label].
  const MuFilterChip({required this.label, required this.selected, required this.onTap, this.icon, super.key});

  /// Short label.
  final String label;

  /// Whether this filter is on.
  final bool selected;

  /// Toggles or selects.
  final VoidCallback onTap;

  /// Optional leading 16dp icon.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final fg = selected ? c.onNight : c.ink;
    return Semantics(
      container: true,
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: MuPressable(
        onTap: onTap,
        pressedScale: 0.95,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: MuSizes.touchMin),
          child: Center(
            widthFactor: 1,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: 36,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: selected ? c.night : c.surface,
                borderRadius: BorderRadius.circular(MuRadii.round),
                border: selected ? null : Border.all(color: c.line),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[Icon(icon, size: MuSizes.iconSm, color: fg), const SizedBox(width: 6)],
                  Text(label, style: mu.text.label.copyWith(color: fg)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
