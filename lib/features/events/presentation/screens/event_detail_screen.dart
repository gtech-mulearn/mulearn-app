import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mulearn_gradients.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';
import 'package:url_launcher/url_launcher.dart';

/// Full detail for a single event — banner, description, venue,
/// organizer, and an interest/RSVP toggle.
class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({required this.eventId, super.key});

  final String eventId;

  String _formatDateRange(String startIso, String endIso) {
    final start = DateTime.tryParse(startIso)?.toLocal();
    final end = DateTime.tryParse(endIso)?.toLocal();
    if (start == null) return '';
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', //
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    final startLabel =
        '${months[start.month - 1]} ${start.day}, ${start.year}';
    if (end == null || end.difference(start).inDays < 1) return startLabel;
    final endLabel = '${months[end.month - 1]} ${end.day}, ${end.year}';
    return '$startLabel – $endLabel';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(eventDetailProvider(eventId));
    final interestState = ref.watch(eventInterestControllerProvider);
    final isBusy = interestState.isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text('Event')),
      body: detailState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(eventDetailProvider(eventId)),
        ),
        data: (event) => ListView(
          padding: EdgeInsets.zero,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: (event.bannerImage ?? event.coverImage) != null
                  ? CachedNetworkImage(
                      imageUrl: (event.bannerImage ?? event.coverImage)!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const DecoratedBox(
                        decoration:
                            BoxDecoration(gradient: MulearnGradients.trusty),
                      ),
                    )
                  : const DecoratedBox(
                      decoration:
                          BoxDecoration(gradient: MulearnGradients.trusty),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    children: event.tags
                        .map((t) => Chip(
                              label: Text(t),
                              visualDensity: VisualDensity.compact,
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 18),
                      const SizedBox(width: 8),
                      Text(_formatDateRange(
                          event.startDatetime, event.endDatetime)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          event.venue.venueType == 'online'
                              ? (event.venue.venuePlatform?.isNotEmpty ??
                                      false)
                                  ? 'Online · ${event.venue.venuePlatform}'
                                  : 'Online'
                              : [
                                  event.venue.venueAddress,
                                  event.venue.venueCity,
                                ].where((s) => s != null && s.isNotEmpty).join(', '),
                        ),
                      ),
                    ],
                  ),
                  if (event.minKarma != null && event.minKarma! > 0) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.bolt, size: 18),
                        const SizedBox(width: 8),
                        Text('${event.minKarma} karma required'),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: isBusy
                              ? null
                              : () => ref
                                  .read(eventInterestControllerProvider.notifier)
                                  .toggle(eventId,
                                      interested: !event.isInterested),
                          icon: Icon(event.isInterested
                              ? Icons.check
                              : Icons.star_border),
                          label: Text(isBusy
                              ? 'Please wait…'
                              : (event.isInterested
                                  ? 'Interested'
                                  : "I'm interested")),
                        ),
                      ),
                      if (event.registrationUrl != null &&
                          event.registrationUrl!.isNotEmpty) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => launchUrl(
                              Uri.parse(event.registrationUrl!),
                              mode: LaunchMode.externalApplication,
                            ),
                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (interestState.hasError) ...[
                    const SizedBox(height: 8),
                    Text(
                      ApiException.messageFor(interestState.error!),
                      style: TextStyle(color: Theme.of(context).colorScheme.error),
                    ),
                  ],
                  if (event.description != null) ...[
                    const SizedBox(height: 24),
                    Text('About',
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 8),
                    Text(event.description!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
