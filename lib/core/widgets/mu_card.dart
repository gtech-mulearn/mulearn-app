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

/// Primary rounded card container (rules.md §8 / DESIGN_SPEC.md §1
/// "Cards") — 24px radius, resting shadow, and (for tappable cards) a hover
/// lift on press: a deeper shadow plus a small upward shift, mirroring the
/// design's `transform: translateY(-2px)` hover treatment.
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

  Color get _background => switch (variant) {
        MuCardVariant.surface => MuColors.surface,
        MuCardVariant.tinted => MuColors.primarySoft,
        MuCardVariant.onGradient => MuColors.surface,
      };

  @override
  Widget build(BuildContext context) {
    final restingShadow = variant == MuCardVariant.surface ? MuShadow.card : null;

    if (onTap == null) {
      return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: _background,
          borderRadius: BorderRadius.circular(MuRadius.card),
          boxShadow: restingShadow,
        ),
        child: child,
      );
    }

    return _HoverLiftCard(
      onTap: onTap!,
      background: _background,
      padding: padding,
      restingShadow: restingShadow,
      hoverShadow: variant == MuCardVariant.surface ? MuShadow.cardHover : null,
      child: child,
    );
  }
}

class _HoverLiftCard extends StatefulWidget {
  const _HoverLiftCard({
    required this.onTap,
    required this.background,
    required this.padding,
    required this.restingShadow,
    required this.hoverShadow,
    required this.child,
  });

  final VoidCallback onTap;
  final Color background;
  final EdgeInsetsGeometry padding;
  final List<BoxShadow>? restingShadow;
  final List<BoxShadow>? hoverShadow;
  final Widget child;

  @override
  State<_HoverLiftCard> createState() => _HoverLiftCardState();
}

class _HoverLiftCardState extends State<_HoverLiftCard> {
  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(MuRadius.card);
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _pressed ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: radius,
          boxShadow: _pressed ? widget.hoverShadow ?? widget.restingShadow : widget.restingShadow,
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: radius,
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: radius,
            child: Padding(padding: widget.padding, child: widget.child),
          ),
        ),
      ),
    );
  }
}
