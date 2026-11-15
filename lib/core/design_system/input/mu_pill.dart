import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Tone of a [MuPill].
enum MuPillTone {
  /// `surface-sunk` / `ink-2`: neutral metadata (duration, mode).
  neutral,

  /// `cobalt-tint` / `cobalt-text`: information (Online, Level 3).
  cobalt,

  /// Done, verified, seats available. Always with an icon.
  success,

  /// Pending, closing soon, few seats. Always with an icon.
  warning,

  /// Rejected, full. Always with an icon.
  danger,

  /// Karma only (+150).
  volt,

  /// White wash over a coloured tile or poster.
  paper,

  /// Night: capacity on posters, live counts.
  night,
}

/// A 24dp read-only pill: status, a karma amount, a fact.
class MuPill extends StatelessWidget {
  /// A pill reading [label].
  const MuPill(
    this.label, {
    this.tone = MuPillTone.neutral,
    this.icon,
    this.mono = false,
    super.key,
  });

  /// Short text.
  final String label;

  /// Colour and meaning.
  final MuPillTone tone;

  /// Leading 14dp icon (required by convention for success/warning/danger).
  final IconData? icon;

  /// Set the label in the mono face (hashtags, karma amounts).
  final bool mono;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (bg, fg) = switch (tone) {
      MuPillTone.neutral => (c.surfaceSunk, c.ink2),
      MuPillTone.cobalt => (c.cobaltTint, c.cobaltText),
      MuPillTone.success => (c.successTint, c.success),
      MuPillTone.warning => (c.warningTint, c.warning),
      MuPillTone.danger => (c.dangerTint, c.danger),
      MuPillTone.volt => (c.volt, c.onVolt),
      // Printed matter: white in both themes (on-cobalt is #fff in each).
      MuPillTone.paper => (c.onCobalt.withValues(alpha: 0.88), c.inkPrint),
      MuPillTone.night => (c.night, c.onNight),
    };
    final style = (mono ? mu.text.code : mu.text.label).copyWith(
      color: fg,
      fontSize: 12,
      height: 1,
    );
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MuRadii.round),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: MuSpacing.space1),
          ],
          Flexible(
            child: Text(
              label,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
