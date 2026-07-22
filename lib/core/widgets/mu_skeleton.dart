import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';

/// Shimmer skeleton block (rules.md §8) — matches card geometry. Never use a
/// spinner on a content area; use this instead while loading.
class MuSkeleton extends StatefulWidget {
  const MuSkeleton({
    super.key,
    this.height = 80,
    this.width = double.infinity,
    this.radius = MuRadius.inner,
  });

  final double height;
  final double width;
  final double radius;

  @override
  State<MuSkeleton> createState() => _MuSkeletonState();
}

class _MuSkeletonState extends State<MuSkeleton> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment(-1 - _controller.value * 2, 0),
            end: Alignment(1 - _controller.value * 2, 0),
            colors: const [MuColors.canvas, MuColors.surface, MuColors.canvas],
            stops: const [0.35, 0.5, 0.65],
          ).createShader(bounds),
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              color: MuColors.canvas,
              borderRadius: BorderRadius.circular(widget.radius),
            ),
          ),
        );
      },
    );
  }
}
