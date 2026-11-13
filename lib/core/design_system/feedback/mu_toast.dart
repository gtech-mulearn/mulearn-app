import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/motion/mu_spring.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// What the toast reports; sets the icon disc, haptic and default duration.
enum MuToastType {
  /// Something finished ("Registered").
  success,

  /// Something failed; say what and how to fix it.
  error,

  /// Neutral information.
  info,

  /// Karma gained, or an undoable change.
  karma,
}

/// A single action on a toast ("Undo", "View pass").
class MuToastAction {
  /// Label in sentence case and what it does.
  const MuToastAction(this.label, this.onPressed);

  /// Button text.
  final String label;

  /// Runs, then the toast closes.
  final VoidCallback onPressed;
}

/// Confirmations, undo and short problems: a `night` capsule that drops in
/// from the top safe area (so it never covers the nav capsule or a primary
/// button). One at a time; a new one replaces the old.
abstract final class MuToast {
  static OverlayEntry? _current;

  /// Shows [message]. Past tense for done things ("Registered"); for
  /// problems, what happened and what to do.
  static void show(
    BuildContext context, {
    required String message,
    MuToastType type = MuToastType.info,
    Duration? duration,
    MuToastAction? action,
  }) {
    _current?.remove();
    _current = null;
    final overlay = Overlay.of(context, rootOverlay: true);
    final shown =
        duration ??
        switch ((type, action)) {
          (MuToastType.error, _) => const Duration(seconds: 6),
          (_, MuToastAction()) => const Duration(seconds: 6),
          _ => const Duration(seconds: 4),
        };
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _Toast(
        message: message,
        type: type,
        duration: shown,
        action: action,
        onGone: () {
          if (_current == entry) _current = null;
          entry.remove();
        },
      ),
    );
    _current = entry;
    overlay.insert(entry);
  }
}

class _Toast extends StatefulWidget {
  const _Toast({
    required this.message,
    required this.type,
    required this.duration,
    required this.action,
    required this.onGone,
  });

  final String message;
  final MuToastType type;
  final Duration duration;
  final MuToastAction? action;
  final VoidCallback onGone;

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> with SingleTickerProviderStateMixin {
  // 0 = hidden above the screen, 1 = in place. Unbounded so springs can
  // overshoot and drags can rubber-band.
  late final AnimationController _t = AnimationController.unbounded(vsync: this);
  Timer? _timer;
  bool _leaving = false;
  bool _held = false;

  static const _travel = 96.0;

  @override
  void initState() {
    super.initState();
    switch (widget.type) {
      case MuToastType.success:
        HapticFeedback.mediumImpact();
      case MuToastType.error:
        HapticFeedback.heavyImpact();
      case MuToastType.info:
      case MuToastType.karma:
        HapticFeedback.lightImpact();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _springTo(1);
    });
    _startTimer();
  }

  bool get _reduceMotion => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(widget.duration, _leave);
  }

  void _springTo(double target, {double velocity = 0}) {
    if (_reduceMotion) {
      _t.value = target;
      return;
    }
    _t.animateWith(SpringSimulation(MuSprings.sheet.description, _t.value, target, velocity));
  }

  Future<void> _leave() async {
    if (_leaving || !mounted) return;
    if (_held) {
      _startTimer();
      return;
    }
    _leaving = true;
    _timer?.cancel();
    if (_reduceMotion) {
      widget.onGone();
      return;
    }
    await _t
        .animateWith(SpringSimulation(MuSprings.standard.description, _t.value, 0, _t.velocity))
        .orCancel
        .catchError((_) {});
    if (mounted) widget.onGone();
  }

  void _onDragUpdate(DragUpdateDetails d) {
    final next = _t.value + d.delta.dy / _travel;
    // Up dismisses; down past rest resists (rubber band).
    _t.value = next > 1 ? 1 + rubberband(next - 1, 1) : next;
  }

  void _onDragEnd(DragEndDetails d) {
    _held = false;
    final v = d.velocity.pixelsPerSecond.dy / _travel;
    final projected = _t.value + project(d.velocity.pixelsPerSecond.dy) / _travel;
    if (projected < 0.5) {
      _leave();
    } else {
      _springTo(1, velocity: v);
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (icon, discBg, discFg) = switch (widget.type) {
      MuToastType.success => (LucideIcons.check, c.success, c.surface),
      MuToastType.error => (LucideIcons.alertTriangle, c.danger, c.surface),
      MuToastType.info => (LucideIcons.info, c.onNight.withValues(alpha: 0.12), c.onNight),
      MuToastType.karma => (LucideIcons.zap, c.volt, c.onVolt),
    };
    final top = MediaQuery.paddingOf(context).top + MuSpacing.space2;

    final capsule = Container(
      constraints: const BoxConstraints(minHeight: 56, maxWidth: 520),
      padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 8, 8),
      decoration: BoxDecoration(
        color: c.night,
        borderRadius: BorderRadius.circular(MuRadii.round),
        boxShadow: mu.shadows.float,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: discBg, shape: BoxShape.circle),
            child: Icon(icon, size: MuSizes.iconSm, color: discFg),
          ),
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Text(
              widget.message,
              style: mu.text.body.copyWith(color: c.onNight, fontSize: 14, height: 20 / 14),
            ),
          ),
          if (widget.action case final action?)
            MuPressable(
              onTap: () {
                action.onPressed();
                _leave();
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: MuSizes.touchMin, minWidth: MuSizes.touchMin),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space3),
                  child: Center(
                    child: Text(action.label, style: mu.text.bodyStrong.copyWith(color: c.volt, fontSize: 14)),
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: MuSpacing.space2),
        ],
      ),
    );

    return Positioned(
      top: top,
      left: MuSpacing.space3,
      right: MuSpacing.space3,
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, child) {
          final p = _t.value;
          return Opacity(
            opacity: p.clamp(0, 1),
            child: Transform.translate(offset: Offset(0, (p - 1) * _travel), child: child),
          );
        },
        child: Semantics(
          liveRegion: true,
          container: true,
          child: GestureDetector(
            onTap: _leave,
            onVerticalDragStart: (_) => _held = true,
            onVerticalDragUpdate: _onDragUpdate,
            onVerticalDragEnd: _onDragEnd,
            child: Material(
              type: MaterialType.transparency,
              child: Center(child: capsule),
            ),
          ),
        ),
      ),
    );
  }
}

/// An inline nudge in the page flow ("You have 2 circle meetings today"):
/// the toast's look without floating, dismissible.
class MuNudge extends StatelessWidget {
  /// A nudge with a leading [icon].
  const MuNudge({required this.message, required this.icon, this.onDismiss, super.key});

  /// One sentence.
  final String message;

  /// Leading glyph.
  final IconData icon;

  /// Shows a close button when set.
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return Container(
      constraints: const BoxConstraints(minHeight: 56),
      padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 8, 8),
      decoration: BoxDecoration(color: c.night, borderRadius: BorderRadius.circular(MuRadii.round)),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: c.onNight.withValues(alpha: 0.12), shape: BoxShape.circle),
            child: Icon(icon, size: MuSizes.iconSm, color: c.onNight),
          ),
          const SizedBox(width: MuSpacing.space3),
          Expanded(
            child: Text(
              message,
              style: mu.text.body.copyWith(color: c.onNight, fontSize: 14, height: 20 / 14),
            ),
          ),
          if (onDismiss != null)
            Semantics(
              button: true,
              label: 'Dismiss',
              child: MuPressable(
                onTap: onDismiss,
                pressedScale: 0.92,
                child: SizedBox.square(
                  dimension: MuSizes.touchMin,
                  child: Center(
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(color: c.onNight.withValues(alpha: 0.1), shape: BoxShape.circle),
                      child: Icon(LucideIcons.x, size: MuSizes.iconSm, color: c.onNight),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
