import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Weekly karma bar chart (rules.md §8) — 7 rounded vertical bars, today
/// highlighted in lime, past days in the primary tint. Animates growing in
/// on first build.
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
                            ? MuColors.lime
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
