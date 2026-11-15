import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Loading (artifact Skeleton): a skeleton keeps the silhouette of what is
/// coming; inline waits use three hopping dots with a sentence.

/// Shows nothing for [delay], then [child]: fast responses never flash a
/// loader.
class MuDelayed extends StatefulWidget {
  /// Waits [delay] before showing [child].
  const MuDelayed({
    required this.child,
    this.delay = const Duration(milliseconds: 300),
    super.key,
  });

  final Widget child;
  final Duration delay;

  @override
  State<MuDelayed> createState() => _MuDelayedState();
}

class _MuDelayedState extends State<MuDelayed> {
  bool _show = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, () {
      if (mounted) setState(() => _show = true);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _show ? widget.child : const SizedBox.shrink();
}

/// One block of a skeleton in `surface-sunk`, with a shimmer passing left
/// to right every 1.4s (static under reduced motion). Compose them into the
/// real component's layout.
class MuSkeletonBox extends StatefulWidget {
  /// A skeleton block.
  const MuSkeletonBox({
    this.width,
    this.height = 16,
    this.radius = MuRadii.tag,
    super.key,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  State<MuSkeletonBox> createState() => _MuSkeletonBoxState();
}

class _MuSkeletonBoxState extends State<MuSkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _t = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce) {
      _t.stop();
    } else if (!_t.isAnimating) {
      unawaited(_t.repeat());
    }
  }

  @override
  void dispose() {
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    return ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _t,
        builder: (context, _) {
          final x = -1.5 + 3 * _t.value;
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius),
              gradient: LinearGradient(
                begin: Alignment(x - 1, 0),
                end: Alignment(x + 1, 0),
                colors: [
                  c.surfaceSunk,
                  Color.lerp(c.surfaceSunk, c.surface, 0.6)!,
                  c.surfaceSunk,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Three dots hopping in `cobalt`, `volt-text` and `ink`, with [label]
/// saying what is loading ("Checking your code…").
class MuDotsLoader extends StatefulWidget {
  /// A dots loader.
  const MuDotsLoader({this.label, super.key});

  final String? label;

  @override
  State<MuDotsLoader> createState() => _MuDotsLoaderState();
}

class _MuDotsLoaderState extends State<MuDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _t = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (reduce) {
      _t.stop();
    } else if (!_t.isAnimating) {
      unawaited(_t.repeat());
    }
  }

  @override
  void dispose() {
    _t.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final colors = [c.cobalt, c.voltText, c.ink];
    return Semantics(
      label: widget.label ?? 'Loading',
      liveRegion: true,
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _t,
            builder: (context, _) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < 3; i++) ...[
                  if (i > 0) const SizedBox(width: 6),
                  Transform.translate(
                    // Each dot hops 120ms after the one before.
                    offset: Offset(0, -6 * _hop((_t.value - i * 0.133) % 1)),
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: colors[i],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (widget.label != null) ...[
            const SizedBox(width: MuSpacing.space3),
            Flexible(
              child: Text(
                widget.label!,
                style: mu.text.body.copyWith(color: c.ink2),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Up and back down in the first half of the cycle, resting after.
  static double _hop(double t) => t < 0.5
      ? Curves.easeInOut.transform(t < 0.25 ? t * 4 : (0.5 - t) * 4)
      : 0;
}
