import 'package:flutter/material.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/featured_event_card.dart';

/// Horizontally scrolling row of [FeaturedEventCard]s for the home
/// dashboard.
class FeaturedEventsList extends StatelessWidget {
  const FeaturedEventsList({required this.events, super.key});

  final List<FeaturedEvent> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 168,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) =>
            FeaturedEventCard(event: events[index]),
      ),
    );
  }
}
