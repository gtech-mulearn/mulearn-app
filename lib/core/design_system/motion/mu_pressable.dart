import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mulearn_app/core/design_system/motion/mu_spring.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Press feedback for every tappable design-system component.
///
/// Scales the child down the moment the finger lands (not on release) and
/// springs back from wherever it is, so a quick tap, a long press and a press
/// dragged away all feel continuous. The tap fires on release; sliding off
/// the target cancels it. Under reduced motion the scale is skipped.
class MuPressable extends StatefulWidget {
  /// Wraps [child] with press feedback.
  const MuPressable({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.pressedScale = 0.97,
    this.haptic = false,
    super.key,
  });

  /// Called on release. Null disables the press feedback too.
  final VoidCallback? onTap;

  /// Called after a long press.
  final VoidCallback? onLongPress;

  /// Scale while pressed (0.97 buttons, 0.98 cards, 0.92 icon buttons).
  final double pressedScale;

  /// A selection click on tap.
  final bool haptic;

  /// The pressable content.
  final Widget child;

  @override
  State<MuPressable> createState() => _MuPressableState();
}

class _MuPressableState extends State<MuPressable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scale = AnimationController.unbounded(
    vsync: this,
    value: 1,
  );

  bool _reduceMotion = false;

  bool get _enabled => widget.onTap != null || widget.onLongPress != null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read here, not in _springTo: a pointer still down when the widget
    // leaves the tree cancels during deactivation, when context is unusable.
    _reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
  }

  void _springTo(double target) {
    if (!mounted) return;
    if (_reduceMotion) {
      _scale.value = 1;
      return;
    }
    // Start from the on-screen value and current velocity: interruptible.
    _scale.animateWith(
      SpringSimulation(
        MuSprings.snappy.description,
        _scale.value,
        target,
        _scale.velocity,
      ),
    );
  }

  @override
  void dispose() {
    _scale.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _enabled ? (_) => _springTo(widget.pressedScale) : null,
      onTapCancel: _enabled ? () => _springTo(1) : null,
      onTapUp: _enabled ? (_) => _springTo(1) : null,
      onTap: widget.onTap == null
          ? null
          : () {
              if (widget.haptic) HapticFeedback.selectionClick();
              widget.onTap!();
            },
      onLongPress: widget.onLongPress == null
          ? null
          : () {
              _springTo(1);
              widget.onLongPress!();
            },
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: widget.child,
      ),
    );
  }
}
