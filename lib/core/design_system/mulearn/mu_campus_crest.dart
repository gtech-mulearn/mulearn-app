import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/theme/mu_tones.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A campus as a stamped seal (artifact CampusCrest): its short code in
/// heavy caps inside a rounded square with a dashed inner ring. No logos
/// are fetched or guessed. `night` by default; [tone] gives it an IG fill.
class MuCampusSeal extends StatelessWidget {
  /// A seal for [code] (null shows [icon]).
  const MuCampusSeal({
    required this.code,
    this.tone,
    this.size = 56,
    this.icon = LucideIcons.school,
    super.key,
  });

  final String? code;

  /// Shown when there's no [code]: a school by default, a briefcase for a
  /// company, a plus for "add your campus".
  final IconData icon;

  /// An IG category fill instead of `night`.
  final IgCategory? tone;
  final double size;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final fill = tone == null ? c.night : MuTones.forIgCategory(c, tone!);
    final ink = tone == null ? c.onNight : c.inkPrint;
    final text = (code ?? '').trim();
    return ExcludeSemantics(
      child: SizedBox.square(
        dimension: size,
        child: CustomPaint(
          painter: _SealPainter(
            fill: fill,
            ring: ink.withValues(alpha: 0.35),
            radius: size * 16 / 56,
          ),
          child: Center(
            child: text.isEmpty
                ? Icon(icon, size: size * 0.4, color: ink)
                : Padding(
                    padding: EdgeInsets.all(size / 7),
                    child: FittedBox(
                      child: Text(
                        text.toUpperCase(),
                        style: mu.text.title3.copyWith(
                          color: ink,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

/// A campus row: seal, name and counts, and optionally its rank with the
/// scope under it ("#3 in Kerala"). On `surface` with `radius-card`.
class MuCampusCrest extends StatelessWidget {
  /// A crest row.
  const MuCampusCrest({
    required this.code,
    required this.name,
    this.caption,
    this.rank,
    this.scope,
    this.tone,
    this.trailing,
    this.onTap,
    this.icon = LucideIcons.school,
    super.key,
  });

  final String? code;
  final String name;

  /// The seal's icon when there's no [code].
  final IconData icon;

  /// "412 learners · 38 circles".
  final String? caption;
  final int? rank;

  /// "in Kerala".
  final String? scope;
  final IgCategory? tone;

  /// In place of the rank (a chevron, a pill).
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final row = Container(
      padding: const EdgeInsets.symmetric(
        horizontal: MuSpacing.space4,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: c.surface,
        borderRadius: BorderRadius.circular(MuRadii.card),
      ),
      child: Row(
        children: [
          MuCampusSeal(code: code, tone: tone, icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: mu.text.title3,
                ),
                if (caption != null && caption!.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    caption!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: mu.text.caption,
                  ),
                ],
              ],
            ),
          ),
          if (rank != null) ...[
            const SizedBox(width: MuSpacing.space3),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('#$rank', style: mu.text.numeral.copyWith(fontSize: 24)),
                if (scope != null)
                  Text(
                    scope!,
                    style: mu.text.caption.copyWith(
                      fontSize: 11,
                      color: c.ink3,
                    ),
                  ),
              ],
            ),
          ] else if (trailing != null) ...[
            const SizedBox(width: MuSpacing.space3),
            trailing!,
          ],
        ],
      ),
    );
    return Semantics(
      container: true,
      button: onTap != null,
      label: [
        name,
        ?caption,
        if (rank != null) 'rank $rank${scope == null ? '' : ' $scope'}',
      ].join(', '),
      excludeSemantics: true,
      child: onTap == null
          ? row
          : Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(MuRadii.card),
                child: row,
              ),
            ),
    );
  }
}

/// The seal: a rounded square with a dashed ring inset 4.
class _SealPainter extends CustomPainter {
  _SealPainter({required this.fill, required this.ring, required this.radius});

  final Color fill;
  final Color ring;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final outer = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );
    canvas.drawRRect(outer, Paint()..color = fill);
    final inset = size.width * 4 / 56;
    final inner = RRect.fromRectAndRadius(
      Offset(inset, inset) &
          Size(size.width - inset * 2, size.height - inset * 2),
      Radius.circular(radius - inset),
    );
    final paint = Paint()
      ..color = ring
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (final metric in (Path()..addRRect(inner)).computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 7) {
        canvas.drawPath(metric.extractPath(d, d + 4), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_SealPainter old) =>
      old.fill != fill || old.ring != ring || old.radius != radius;
}
