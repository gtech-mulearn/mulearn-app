import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
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
    return SizedBox(
      width: 252,
      child: Material(
        color: MuColors.surface,
        borderRadius: BorderRadius.circular(MuRadius.inner),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => context.push(RoutePaths.eventDetailPath(event.id)),
          child: Ink(
            decoration: const BoxDecoration(boxShadow: MuShadow.card),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 108,
                      width: double.infinity,
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
                    Positioned(
                      left: MuSpace.s,
                      bottom: MuSpace.s,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: MuSpace.s, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(MuRadius.chip),
                        ),
                        child: Text(
                          _dateLabel,
                          style: MuType.chip.copyWith(color: MuColors.ink, fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(MuSpace.m),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.title,
                        style: MuType.bodyMed,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: MuSpace.xs),
                      Row(
                        children: [
                          const Icon(LucideIcons.mapPin, size: 12, color: MuColors.inkTertiary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              _venueLabel,
                              style: MuType.caption,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (event.interestCount > 0) ...[
                            const Icon(LucideIcons.users, size: 12, color: MuColors.primary),
                            const SizedBox(width: 4),
                            Text(
                              '${event.interestCount}',
                              style: MuType.caption.copyWith(color: MuColors.primary),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
