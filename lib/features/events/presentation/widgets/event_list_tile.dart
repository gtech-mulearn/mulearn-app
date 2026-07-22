import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';

/// A single row in the full events list — cover thumbnail, title, date,
/// venue, and an interested indicator.
class EventListTile extends StatelessWidget {
  const EventListTile({required this.event, required this.onTap, super.key});

  final Event event;
  final VoidCallback onTap;

  String get _dateLabel {
    final start = DateTime.tryParse(event.startDatetime);
    if (start == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[start.month - 1]} ${start.day}';
  }

  String get _venueLabel {
    if (event.venue.venueType == 'online') return 'Online';
    return event.venue.venueCity ?? 'TBA';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MuSpace.m),
      child: MuCard(
        onTap: onTap,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(MuRadius.inner),
              child: SizedBox(
                height: 48,
                width: 48,
                child: event.coverImage != null
                    ? CachedNetworkImage(
                        imageUrl: event.coverImage!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const DecoratedBox(
                          decoration: BoxDecoration(gradient: MuColors.heroGradient),
                        ),
                      )
                    : const DecoratedBox(
                        decoration: BoxDecoration(gradient: MuColors.heroGradient),
                      ),
              ),
            ),
            const SizedBox(width: MuSpace.m),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: MuType.bodyMed, maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(LucideIcons.calendar, size: 12, color: MuColors.inkSecondary),
                      const SizedBox(width: MuSpace.xs),
                      Text(_dateLabel, style: MuType.caption),
                      const SizedBox(width: MuSpace.s),
                      const Icon(LucideIcons.mapPin, size: 12, color: MuColors.inkSecondary),
                      const SizedBox(width: MuSpace.xs),
                      Expanded(
                        child: Text(_venueLabel, style: MuType.caption, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (event.isInterested) ...[
              const SizedBox(width: MuSpace.s),
              const Icon(LucideIcons.checkCircle2, color: MuColors.limeBright),
            ],
          ],
        ),
      ),
    );
  }
}
