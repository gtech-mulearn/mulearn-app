import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Fill of an icon button.
enum MuIconButtonVariant {
  /// `surface` with a hairline ring; on `chalk`.
  surface,

  /// `surface-sunk`; on `surface`.
  sunk,

  /// `night`; strong tools (Scan, Your passes).
  night,

  /// `cobalt`; create in context (+ on Circles).
  cobalt,

  /// Translucent white; over photos and cobalt heroes.
  glass,
}

/// A 44dp circle holding one icon. Circles mean "a tool": buttons are pills,
/// cards are rounded rectangles.
class MuIconButton extends StatelessWidget {
  /// [tooltip] is required: it is the screen-reader label.
  const MuIconButton({
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.variant = MuIconButtonVariant.surface,
    this.glass = false,
    this.badge = false,
    this.badgeCount = 0,
    super.key,
  });

  /// The glyph (lucide, 1.8 stroke).
  final IconData icon;

  /// Null disables.
  final VoidCallback? onPressed;

  /// Screen-reader label and long-press tooltip; include the count when
  /// there is one ("Notifications, 3 unread").
  final String tooltip;

  /// Fill.
  final MuIconButtonVariant variant;

  /// Shorthand for [MuIconButtonVariant.glass].
  final bool glass;

  /// A dot without a number.
  final bool badge;

  /// A count bubble (99+ above 99); wins over [badge].
  final int badgeCount;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final v = glass ? MuIconButtonVariant.glass : variant;
    final (bg, fg) = switch (v) {
      MuIconButtonVariant.surface => (c.surface, c.ink),
      MuIconButtonVariant.sunk => (c.surfaceSunk, c.ink),
      MuIconButtonVariant.night => (c.night, c.onNight),
      MuIconButtonVariant.cobalt => (c.cobalt, c.onCobalt),
      MuIconButtonVariant.glass => (
        c.onCobalt.withValues(alpha: 0.18),
        c.onCobalt,
      ),
    };

    final circle = Container(
      width: MuSizes.iconBtn,
      height: MuSizes.iconBtn,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: v == MuIconButtonVariant.surface
            ? Border.all(color: c.line)
            : null,
      ),
      child: Icon(icon, size: MuSizes.iconMd, color: fg),
    );

    final Widget? marker;
    if (badgeCount > 0) {
      marker = PositionedDirectional(
        top: 0,
        end: 0,
        child: ExcludeSemantics(
          child: Container(
            constraints: const BoxConstraints(minWidth: 18),
            height: 18,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: c.danger,
              borderRadius: BorderRadius.circular(MuRadii.round),
              border: Border.all(color: c.surface, width: 2),
            ),
            child: Text(
              badgeCount > 99 ? '99+' : '$badgeCount',
              style: mu.text.codeSm.copyWith(color: c.surface, height: 1),
            ),
          ),
        ),
      );
    } else if (badge) {
      marker = PositionedDirectional(
        top: 6,
        end: 7,
        child: Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(
            color: c.danger,
            shape: BoxShape.circle,
            border: Border.all(color: c.surface, width: 2),
          ),
        ),
      );
    } else {
      marker = null;
    }

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        excludeFromSemantics: true,
        child: Opacity(
          opacity: onPressed == null ? MuOpacity.disabled : 1,
          child: MuPressable(
            onTap: onPressed,
            pressedScale: 0.92,
            child: SizedBox.square(
              dimension: MuSizes.touchMin,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [circle, ?marker],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
