import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/motion/mu_spring.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A deliberate gesture for actions that must not happen by accident: drag
/// the volt thumb along a night track. The thumb follows the finger 1:1,
/// rubber-bands past either end, and commits when released past 82% of the
/// travel or when the release velocity projects past the end; otherwise it
/// springs back carrying that velocity. Screen readers get a button that
/// confirms on double-tap.
class MuSlideToConfirm extends StatefulWidget {
  /// A slide-to-confirm track.
  const MuSlideToConfirm({
    required this.label,
    required this.onConfirmed,
    this.icon = LucideIcons.chevronsRight,
    this.confirmedLabel = 'Done',
    super.key,
  });

  /// The hint on the track, e.g. "Copy hashtag & open Discord".
  final String label;

  /// Shown on the success track once [onConfirmed] finishes.
  final String confirmedLabel;

  /// The thumb's icon.
  final IconData icon;

  /// Runs on commit; the thumb shows a spinner meanwhile.
  final Future<void> Function() onConfirmed;

  @override
  State<MuSlideToConfirm> createState() => _MuSlideToConfirmState();
}

enum _Phase { idle, running, done }

class _MuSlideToConfirmState extends State<MuSlideToConfirm> with SingleTickerProviderStateMixin {
  static const double _height = 64;
  static const double _pad = 6;
  static const double _thumb = 52;

  late final AnimationController _x = AnimationController.unbounded(vsync: this);
  double _travel = 0;
  double _drag = 0; // finger position along the travel, unclamped
  _Phase _phase = _Phase.idle;

  @override
  void dispose() {
    _x.dispose();
    super.dispose();
  }

  double _shown(double raw) {
    if (raw < 0) return -rubberband(-raw, _travel, constant: 0.2);
    if (raw > _travel) return _travel + rubberband(raw - _travel, _travel, constant: 0.2);
    return raw;
  }

  void _spring(double target, double velocity, MuSpringSpec spec) {
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce) {
      _x.value = target;
      return;
    }
    unawaited(_x.animateWith(SpringSimulation(spec.description, _x.value, target, velocity)));
  }

  void _onStart(DragStartDetails _) {
    if (_phase != _Phase.idle) return;
    _x.stop();
    _drag = _x.value;
  }

  void _onUpdate(DragUpdateDetails d) {
    if (_phase != _Phase.idle) return;
    _drag += d.delta.dx;
    _x.value = _shown(_drag);
  }

  void _onEnd(DragEndDetails d) {
    if (_phase != _Phase.idle) return;
    final v = d.velocity.pixelsPerSecond.dx;
    final commits = _x.value >= _travel * 0.82 || _x.value + project(v) >= _travel;
    if (commits) {
      unawaited(_confirm(velocity: v));
    } else {
      _spring(0, v, MuSprings.momentum);
    }
  }

  Future<void> _confirm({double velocity = 0}) async {
    if (_phase != _Phase.idle) return;
    setState(() => _phase = _Phase.running);
    _spring(_travel, velocity, MuSprings.snappy);
    unawaited(HapticFeedback.mediumImpact());
    try {
      await widget.onConfirmed();
      if (!mounted) return;
      setState(() => _phase = _Phase.done);
      await Future<void>.delayed(const Duration(milliseconds: 1400));
    } finally {
      if (mounted) {
        setState(() => _phase = _Phase.idle);
        _spring(0, 0, MuSprings.standard);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final done = _phase == _Phase.done;

    return Semantics(
      container: true,
      button: true,
      label: done ? widget.confirmedLabel : widget.label,
      excludeSemantics: true,
      onTap: _phase == _Phase.idle ? _confirm : null,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
        child: LayoutBuilder(
          builder: (context, box) {
            _travel = box.maxWidth - _pad * 2 - _thumb;
            return GestureDetector(
              onHorizontalDragStart: _onStart,
              onHorizontalDragUpdate: _onUpdate,
              onHorizontalDragEnd: _onEnd,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: _height,
                padding: const EdgeInsets.all(_pad),
                decoration: BoxDecoration(
                  color: done ? c.success : c.night,
                  borderRadius: BorderRadius.circular(MuRadii.round),
                ),
                child: AnimatedBuilder(
                  animation: _x,
                  builder: (context, _) {
                    final progress = _travel <= 0 ? 0.0 : (_x.value / _travel).clamp(0.0, 1.0);
                    return Stack(
                      children: [
                        Positioned.fill(
                          left: _thumb,
                          child: Center(
                            child: Opacity(
                              opacity: done ? 1 : (1 - progress * 1.4).clamp(0.0, 1.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Flexible(
                                    child: Text(
                                      done ? widget.confirmedLabel : widget.label,
                                      style: mu.text.bodyStrong.copyWith(color: done ? c.surface : c.onNight2),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  if (!done) ...[
                                    const SizedBox(width: MuSpacing.space1),
                                    Text(
                                      '›››',
                                      style: mu.text.bodyStrong.copyWith(
                                        color: c.onNight2.withValues(alpha: c.onNight2.a * 0.6),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: _x.value,
                          top: 0,
                          child: Container(
                            width: _thumb,
                            height: _thumb,
                            decoration: BoxDecoration(color: done ? c.surface : c.volt, shape: BoxShape.circle),
                            child: Center(
                              child: switch (_phase) {
                                _Phase.running => SizedBox.square(
                                  dimension: 22,
                                  child: CircularProgressIndicator(strokeWidth: 2.4, color: c.onVolt),
                                ),
                                _Phase.done => Icon(LucideIcons.check, color: c.success, size: MuSizes.iconMd),
                                _Phase.idle => Icon(widget.icon, color: c.onVolt, size: MuSizes.iconMd),
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
