import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/design_system/motion/mu_pressable.dart';
import 'package:mulearn_app/core/design_system/theme/mu_theme.dart';
import 'package:mulearn_app/core/design_system/tokens/mu_tokens.g.dart';

/// A ticket silhouette: rounded corners with a semicircle notch cut from
/// each side at [perforationFromBottom], so shadows and clips follow the
/// notches.
class MuTicketBorder extends ShapeBorder {
  /// A ticket outline.
  const MuTicketBorder({
    required this.perforationFromBottom,
    this.radius = MuRadii.card,
    this.notch = 14,
  });

  /// Distance from the bottom edge to the perforation line.
  final double perforationFromBottom;

  /// Corner radius.
  final double radius;

  /// Notch radius.
  final double notch;

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      getOuterPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final body = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));
    final y = rect.bottom - perforationFromBottom;
    final notches = Path()
      ..addOval(Rect.fromCircle(center: Offset(rect.left, y), radius: notch))
      ..addOval(Rect.fromCircle(center: Offset(rect.right, y), radius: notch));
    return Path.combine(PathOperation.difference, body, notches);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => MuTicketBorder(
    perforationFromBottom: perforationFromBottom * t,
    radius: radius * t,
    notch: notch * t,
  );
}

/// An event as a ticket: poster on top, a perforation, and a stub holding
/// the one action (Register → Show pass → Join now).
class MuEventTicket extends StatelessWidget {
  /// The listing ticket.
  const MuEventTicket({
    required this.title,
    required this.when,
    required this.stub,
    this.posterUrl,
    this.posterTitle,
    this.capacity,
    this.kind,
    this.pills = const [],
    this.going,
    this.onTap,
    super.key,
  });

  /// Event name.
  final String title;

  /// Date range and place, as people say it ("Until 30 Nov · Online").
  final String when;

  /// Cover image; null draws a poster from [posterTitle] or [title].
  final String? posterUrl;

  /// Short poster text ("Learning Fest 26").
  final String? posterTitle;

  /// Top-left poster badge (seats left, interested count).
  final Widget? capacity;

  /// Top-right poster badge (event type).
  final Widget? kind;

  /// Meta pills under the title (karma, duration, scope).
  final List<Widget> pills;

  /// "Going from your campus" row content (usually a MuPeerLine).
  final Widget? going;

  /// The stub's action: a block MuButton.
  final Widget stub;

  /// Opens the event.
  final VoidCallback? onTap;

  static const double _stubHeight = 92;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;

    final poster = ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (posterUrl != null && posterUrl!.isNotEmpty)
              CachedNetworkImage(
                imageUrl: posterUrl!,
                fit: BoxFit.cover,
                placeholder: (_, _) =>
                    MuGeneratedPoster(text: posterTitle ?? title),
                errorWidget: (_, _, _) =>
                    MuGeneratedPoster(text: posterTitle ?? title),
              )
            else
              MuGeneratedPoster(text: posterTitle ?? title),
            if (capacity != null)
              Positioned(left: 10, top: 10, child: capacity!),
            if (kind != null) Positioned(right: 10, top: 10, child: kind!),
          ],
        ),
      ),
    );

    final top = Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ExcludeSemantics(child: poster),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 14, 8, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: mu.text.title2.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: MuSpacing.space1),
                Text(when, style: mu.text.caption),
                if (pills.isNotEmpty) ...[
                  const SizedBox(height: MuSpacing.space3),
                  Wrap(spacing: 6, runSpacing: 6, children: pills),
                ],
              ],
            ),
          ),
          if (going != null) ...[
            const SizedBox(height: MuSpacing.space3),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: MuSpacing.space3,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: c.surfaceSunk,
                borderRadius: BorderRadius.circular(14),
              ),
              child: going,
            ),
          ],
        ],
      ),
    );

    final ticket = Container(
      constraints: const BoxConstraints(maxWidth: 340),
      decoration: ShapeDecoration(
        color: c.surface,
        shape: const MuTicketBorder(perforationFromBottom: _stubHeight),
        shadows: mu.shadows.lift
            .map(
              (s) => s.copyWith(
                color: s.color.withValues(alpha: s.color.a * 0.45),
              ),
            )
            .toList(),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (onTap == null)
            top
          else
            Semantics(
              button: true,
              label: '$title. $when',
              child: MuPressable(onTap: onTap, pressedScale: 0.99, child: top),
            ),
          SizedBox(
            height: _stubHeight,
            child: Stack(
              children: [
                Positioned(
                  left: 16,
                  right: 16,
                  top: 0,
                  child: ExcludeSemantics(
                    child: CustomPaint(
                      size: const Size(double.infinity, 2),
                      painter: _DashPainter(c.lineStrong),
                    ),
                  ),
                ),
                // 18 + 56 (button with its focus-ring padding) + 18 = the 92dp stub.
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                  child: stub,
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return ticket;
  }
}

class _DashPainter extends CustomPainter {
  _DashPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 2;
    for (var x = 0.0; x < size.width; x += 10) {
      canvas.drawLine(
        Offset(x, 1),
        Offset((x + 5).clamp(0, size.width), 1),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}

/// A poster when the event has no cover: its short title in the poster
/// style over cobalt with a volt and a sticker disc.
class MuGeneratedPoster extends StatelessWidget {
  /// A poster for [text].
  const MuGeneratedPoster({required this.text, this.fontSize = 34, super.key});

  /// Poster type size: 34 on a ticket, larger on a detail hero.
  final double fontSize;

  final String text;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return ColoredBox(
      color: c.cobalt,
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -30,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(color: c.volt, shape: BoxShape.circle),
            ),
          ),
          Positioned(
            left: 18,
            top: 12,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: c.igCreative,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                text.toUpperCase(),
                style: mu.text.poster.copyWith(
                  fontSize: fontSize,
                  color: c.onCobalt,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
