import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';

/// A single featured-event card for the home dashboard's horizontal list —
/// tapping it opens the full event detail (the `events` feature owns that
/// screen; this card only needs the route path, not a cross-feature import).
class FeaturedEventCard extends StatelessWidget {
  const FeaturedEventCard({required this.event, super.key});

  final FeaturedEvent event;

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
    final theme = Theme.of(context);
    return SizedBox(
      width: 240,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(RoutePaths.eventDetailPath(event.id)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: event.coverImage != null
                    ? CachedNetworkImage(
                        imageUrl: event.coverImage!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) => const DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: MulearnGradients.trusty),
                        ),
                      )
                    : const DecoratedBox(
                        decoration:
                            BoxDecoration(gradient: MulearnGradients.trusty),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.title,
                      style: theme.textTheme.titleSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 12, color: MulearnColors.gray600),
                        const SizedBox(width: 4),
                        Text(_dateLabel, style: theme.textTheme.bodySmall),
                        const SizedBox(width: 10),
                        const Icon(Icons.place,
                            size: 12, color: MulearnColors.gray600),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            _venueLabel,
                            style: theme.textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
