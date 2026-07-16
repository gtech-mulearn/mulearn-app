import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
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
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          height: 48,
          width: 48,
          child: event.coverImage != null
              ? CachedNetworkImage(
                  imageUrl: event.coverImage!,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => const DecoratedBox(
                    decoration: BoxDecoration(gradient: MulearnGradients.trusty),
                  ),
                )
              : const DecoratedBox(
                  decoration: BoxDecoration(gradient: MulearnGradients.trusty),
                ),
        ),
      ),
      title: Text(event.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Row(
        children: [
          const Icon(Icons.calendar_today, size: 12, color: MulearnColors.gray600),
          const SizedBox(width: 4),
          Text(_dateLabel, style: theme.textTheme.bodySmall),
          const SizedBox(width: 10),
          const Icon(Icons.place, size: 12, color: MulearnColors.gray600),
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
      trailing: event.isInterested
          ? const Icon(Icons.check_circle, color: MulearnColors.rankGold)
          : null,
    );
  }
}
