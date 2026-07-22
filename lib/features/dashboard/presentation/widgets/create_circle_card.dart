import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';

/// Dashed-border CTA card leading the Home dashboard's "Your Circles" row.
class CreateCircleCard extends StatelessWidget {
  const CreateCircleCard({required this.onTap, super.key});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 168,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(MuRadius.card),
          child: CustomPaint(
            painter: _DashedBorderPainter(),
            child: Container(
              padding: const EdgeInsets.all(MuSpace.l),
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: MuColors.primaryTint,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: const Icon(LucideIcons.plus, size: 20, color: MuColors.primary),
                  ),
                  const SizedBox(height: MuSpace.s),
                  Text('Create Circle', style: MuType.bodyMed, textAlign: TextAlign.center),
                  const SizedBox(height: 2),
                  Text(
                    'Start a discussion or project',
                    style: MuType.caption,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(MuRadius.card),
    );
    final paint = Paint()
      ..color = MuColors.divider
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    const dashWidth = 6.0;
    const gapWidth = 4.0;
    final path = Path()..addRRect(rrect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(
          metric.extractPath(distance, distance + dashWidth),
          paint,
        );
        distance += dashWidth + gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
