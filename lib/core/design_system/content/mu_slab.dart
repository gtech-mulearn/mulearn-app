import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// Fill of a [MuSlab].
enum MuSlabTone {
  /// Default: today's challenge, a featured thing.
  cobalt,

  /// Karma moments: a level ready to claim.
  volt,

  /// Live events.
  night,
}

/// The one loud element of a screen: a coloured slab with decorative token
/// shapes (discs and capsules, never stock art) clipped at its right edge.
/// One per screen.
class MuSlab extends StatelessWidget {
  /// A slab. [seed] fixes the shape composition (use the content's id).
  const MuSlab({
    required this.title,
    this.tone = MuSlabTone.cobalt,
    this.badge,
    this.body,
    this.footer,
    this.seed = 'mulearn',
    this.onTap,
    super.key,
  });

  /// Headline, two lines at most.
  final String title;

  /// Fill.
  final MuSlabTone tone;

  /// A pill above the title (karma, "Live now").
  final Widget? badge;

  /// One line under the title.
  final String? body;

  /// Avatars or a button at the bottom.
  final Widget? footer;

  /// Composition seed.
  final String seed;

  /// Opens the thing.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final (bg, fg) = switch (tone) {
      MuSlabTone.cobalt => (c.cobalt, c.onCobalt),
      MuSlabTone.volt => (c.volt, c.onVolt),
      MuSlabTone.night => (c.night, c.onNight),
    };
    final orbColors = switch (tone) {
      MuSlabTone.cobalt => [c.volt, c.igCreative, c.night, c.igMaker],
      MuSlabTone.volt => [c.night, c.cobalt, c.igCreative, c.surface],
      MuSlabTone.night => [c.volt, c.cobalt, c.igCreative, c.igMaker],
    };
    final slab = Container(
      constraints: const BoxConstraints(minHeight: 164),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(MuRadii.panel),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: ExcludeSemantics(
              child: CustomPaint(
                painter: _OrbsPainter(seed: seed, colors: orbColors),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: FractionallySizedBox(
              widthFactor: 0.64,
              alignment: AlignmentDirectional.centerStart,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (badge != null) ...[
                    badge!,
                    const SizedBox(height: MuSpacing.space3),
                  ],
                  Text(
                    title,
                    style: mu.text.display.copyWith(
                      fontSize: 30,
                      height: 1,
                      color: fg,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (body != null) ...[
                    const SizedBox(height: MuSpacing.space2),
                    Text(
                      body!,
                      style: mu.text.label.copyWith(
                        color: fg.withValues(alpha: 0.86),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  if (footer != null) ...[
                    const SizedBox(height: MuSpacing.space4),
                    footer!,
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
    if (onTap == null) return slab;
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: slab,
      ),
    );
  }
}

/// Four token shapes (two discs, two capsules) at seeded positions in the
/// slab's right third.
class _OrbsPainter extends CustomPainter {
  _OrbsPainter({required this.seed, required this.colors});

  final String seed;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    var h = 0;
    for (final u in seed.codeUnits) {
      h = (h * 31 + u) & 0x7fffffff;
    }
    final rnd = math.Random(h);
    double jitter(double v, double range) =>
        v + (rnd.nextDouble() - 0.5) * range;
    final right = size.width;
    final shapes = <(Offset, double, double, double)>[
      // centre, width, height, rotation
      (Offset(jitter(right - 100, 24), jitter(66, 20)), 72, 72, 0),
      (Offset(jitter(right - 30, 16), jitter(46, 16)), 118, 42, -0.5),
      (Offset(jitter(right - 46, 16), jitter(122, 20)), 54, 54, 0),
      (Offset(jitter(right - 84, 20), jitter(164, 16)), 96, 36, 0.32),
    ];
    for (var i = 0; i < shapes.length; i++) {
      final (center, w, hgt, rot) = shapes[i];
      canvas
        ..save()
        ..translate(center.dx, center.dy)
        ..rotate(rot);
      final rect = Rect.fromCenter(center: Offset.zero, width: w, height: hgt);
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(hgt / 2)),
          Paint()..color = colors[i % colors.length],
        )
        ..restore();
    }
  }

  @override
  bool shouldRepaint(_OrbsPainter old) =>
      old.seed != seed || old.colors != colors;
}
