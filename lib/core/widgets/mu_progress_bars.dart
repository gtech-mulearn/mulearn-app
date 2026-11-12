import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Weekly karma bar chart (rules.md §8) — 7 rounded vertical bars, today
/// highlighted in the karma accent, past days in the primary tint. Animates
/// growing in on first build.
class MuProgressBars extends StatefulWidget {
  const MuProgressBars({
    required this.values,
    required this.dayLabels,
    super.key,
    this.todayIndex,
    this.height = 80,
  });

  /// Raw values (e.g. karma per day) — normalized internally against the max.
  final List<double> values;
  final List<String> dayLabels;
  final int? todayIndex;
  final double height;

  @override
  State<MuProgressBars> createState() => _MuProgressBarsState();
}

class _MuProgressBarsState extends State<MuProgressBars> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) setState(() => _progress = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxValue = widget.values.fold<double>(1, (a, b) => a > b ? a : b);
    return SizedBox(
      height: widget.height + 20,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (var i = 0; i < widget.values.length; i++)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: widget.height,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      width: 10,
                      height: widget.height *
                          (widget.values[i] / maxValue).clamp(0.05, 1) *
                          _progress,
                      decoration: BoxDecoration(
                        color: i == widget.todayIndex
                            ? MuColors.karmaAccent
                            : MuColors.primaryTint,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(widget.dayLabels[i], style: MuType.caption),
              ],
            ),
        ],
      ),
    );
  }
}

/// Linear progress track (DESIGN_SPEC.md §1 "Progress bar") — pill-shaped,
/// animated width, with an optional blue→purple gradient fill for dark-card
/// contexts (e.g. the karma hero card) alongside the default solid-[MuColors
/// .primary] fill used on light-card contexts (e.g. the resume card).
class MuLinearProgress extends StatelessWidget {
  const MuLinearProgress({
    required this.value,
    super.key,
    this.height = 9,
    this.gradient = false,
    this.trackColor,
  });

  /// 0.0–1.0.
  final double value;

  final double height;

  /// Blue→purple gradient fill (dark-card contexts) instead of solid
  /// [MuColors.primary] (light-card contexts).
  final bool gradient;

  /// Defaults to `rgba(white,.14)` when [gradient] is set (dark-card
  /// context) or `MuColors.hairline` otherwise (light-card context).
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    final track = trackColor ?? (gradient ? Colors.white.withValues(alpha: 0.14) : MuColors.hairline);
    final clamped = value.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: Container(
        height: height,
        color: track,
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: clamped,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            height: height,
            decoration: BoxDecoration(
              color: gradient ? null : MuColors.primary,
              gradient: gradient ? MuColors.karmaGradient : null,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
      ),
    );
  }
}

/// Circular ring progress (DESIGN_SPEC.md §1 "Progress ring") — used for the
/// journey-header level ring and each Mu Voyage row's mini-ring. Ring color
/// varies by state: current = [MuColors.primary], cleared = [MuColors
/// .success], locked = [MuColors.inkFaint].
class MuProgressRing extends StatelessWidget {
  const MuProgressRing({
    required this.value,
    super.key,
    this.size = 56,
    this.strokeWidth = 5,
    this.color = MuColors.primary,
    this.trackColor = MuColors.hairline,
    this.child,
  });

  /// 0.0–1.0.
  final double value;
  final double size;
  final double strokeWidth;
  final Color color;
  final Color trackColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              value: value.clamp(0.0, 1.0),
              strokeWidth: strokeWidth,
              color: color,
              trackColor: trackColor,
            ),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.value,
    required this.strokeWidth,
    required this.color,
    required this.trackColor,
  });

  final double value;
  final double strokeWidth;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.shortestSide - strokeWidth) / 2;
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas
      ..drawCircle(center, radius, trackPaint)
      ..drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2,
        2 * math.pi * value,
        false,
        fillPaint,
      );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.value != value ||
      oldDelegate.color != color ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.strokeWidth != strokeWidth;
}
