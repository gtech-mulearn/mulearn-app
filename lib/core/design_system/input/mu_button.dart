import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Which job the button does. Hierarchy comes from fill, not size.
enum MuButtonVariant {
  /// The one forward move of a flow (Get started, Continue, Register).
  /// Usually with `knob: true`.
  ink,

  /// Brand commitment: Join μLearn, Join IG, Submit.
  cobalt,

  /// The alternative next to a primary: Sign in, Decline.
  outline,

  /// Low stakes: Skip, See all, Cancel.
  ghost,

  /// Karma only: Claim level, Collect reward.
  volt,
}

/// Height.
enum MuButtonSize {
  /// 52dp.
  regular,

  /// 40dp visible, 48dp hit area. Inside cards.
  small,
}

/// The design system's pill button.
class MuButton extends StatelessWidget {
  /// A button that says what it does ("Register", "Copy hashtag").
  const MuButton({
    required this.label,
    required this.onPressed,
    this.variant = MuButtonVariant.cobalt,
    this.size = MuButtonSize.regular,
    this.icon,
    this.knob = false,
    this.block = false,
    this.loading = false,
    this.loadingLabel,
    super.key,
  });

  /// Verb first, sentence case.
  final String label;

  /// Null disables the button.
  final VoidCallback? onPressed;

  /// Fill and role.
  final MuButtonVariant variant;

  /// Height.
  final MuButtonSize size;

  /// Optional leading icon.
  final IconData? icon;

  /// A volt disc with an arrow at the trailing end (the forward move).
  final bool knob;

  /// Full width within the gutter.
  final bool block;

  /// Shows a spinner and blocks taps.
  final bool loading;

  /// Present-tense label while loading ("Signing in"); defaults to [label].
  final String? loadingLabel;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (bg, fg, border) = switch (variant) {
      MuButtonVariant.ink => (c.night, c.onNight, null),
      MuButtonVariant.cobalt => (c.cobalt, c.onCobalt, null),
      MuButtonVariant.outline => (Colors.transparent, c.ink, c.lineStrong),
      MuButtonVariant.ghost => (Colors.transparent, c.cobaltText, null),
      MuButtonVariant.volt => (c.volt, c.onVolt, null),
    };
    final small = size == MuButtonSize.small;
    final height = small ? MuSizes.buttonHSm : MuSizes.buttonH;
    final textStyle = mu.text.button.copyWith(color: fg, fontSize: small ? 14 : null);
    final enabled = onPressed != null && !loading;
    final showKnob = knob && !loading;
    final shownLabel = loading ? (loadingLabel ?? label) : label;

    final content = Row(
      mainAxisSize: block ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: showKnob ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
      children: [
        if (loading) ...[
          SizedBox.square(
            dimension: 18,
            child: CircularProgressIndicator(strokeWidth: 2, color: fg),
          ),
          const SizedBox(width: MuSpacing.space2),
        ] else if (icon != null) ...[
          Icon(icon, size: small ? MuSizes.iconSm : 18, color: fg),
          const SizedBox(width: MuSpacing.space2),
        ],
        Flexible(
          child: Text(shownLabel, style: textStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
        if (showKnob) ...[
          const SizedBox(width: MuSpacing.space3),
          Container(
            width: height - 12,
            height: height - 12,
            decoration: BoxDecoration(color: c.volt, shape: BoxShape.circle),
            child: Icon(LucideIcons.arrowRight, size: MuSizes.iconMd, color: c.onVolt),
          ),
        ],
      ],
    );

    final pill = Container(
      height: height,
      padding: EdgeInsetsDirectional.only(
        start: variant == MuButtonVariant.ghost ? MuSpacing.space3 : (small ? MuSpacing.space4 : MuSpacing.space6),
        end: showKnob ? 6 : (variant == MuButtonVariant.ghost ? MuSpacing.space3 : (small ? MuSpacing.space4 : MuSpacing.space6)),
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MuRadii.round),
        border: border == null ? null : Border.all(color: border, width: 1.5),
      ),
      child: content,
    );

    return Semantics(
      button: true,
      enabled: enabled,
      label: shownLabel,
      excludeSemantics: true,
      child: Opacity(
        opacity: onPressed == null ? MuOpacity.disabled : 1,
        child: _FocusRing(
          enabled: enabled,
          onActivate: onPressed,
          color: c.focusRing,
          child: MuPressable(
            onTap: enabled ? onPressed : null,
            child: ConstrainedBox(
              // Small buttons keep a 48dp hit area around the 40dp pill.
              constraints: const BoxConstraints(minHeight: MuSizes.touchMin),
              child: Center(widthFactor: block ? null : 1, child: pill),
            ),
          ),
        ),
      ),
    );
  }
}

/// Keyboard and switch-access focus: Enter/Space activate, and a 2dp ring
/// offset 2dp shows while focused by keyboard.
class _FocusRing extends StatefulWidget {
  const _FocusRing({required this.enabled, required this.onActivate, required this.color, required this.child});

  final bool enabled;
  final VoidCallback? onActivate;
  final Color color;
  final Widget child;

  @override
  State<_FocusRing> createState() => _FocusRingState();
}

class _FocusRingState extends State<_FocusRing> {
  bool _highlight = false;

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      enabled: widget.enabled,
      onShowFocusHighlight: (v) => setState(() => _highlight = v),
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(onInvoke: (_) => widget.onActivate?.call()),
      },
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MuRadii.round),
          border: _highlight ? Border.all(color: widget.color, width: 2) : null,
        ),
        child: Padding(padding: const EdgeInsets.all(2), child: widget.child),
      ),
    );
  }
}
