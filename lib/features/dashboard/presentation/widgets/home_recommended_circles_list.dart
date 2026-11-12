import 'package:flutter/material.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/learning_circle_tile.dart';

/// Horizontally scrolling preview of learning circles that match the
/// signed-in user's joined interest groups — mirrors [FeaturedEventsList]'s
/// pattern.
class HomeRecommendedCirclesList extends StatelessWidget {
  const HomeRecommendedCirclesList({
    required this.circles,
    required this.onTap,
    super.key,
  });

  final List<LearningCircle> circles;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    if (circles.isEmpty) return const SizedBox.shrink();
    final preview = circles.take(6).toList();
    return SizedBox(
      height: 112,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: preview.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final circle = preview[index];
          return SizedBox(
            width: 280,
            child: LearningCircleTile(circle: circle, onTap: () => onTap(circle.id)),
          );
        },
      ),
    );
  }
}
