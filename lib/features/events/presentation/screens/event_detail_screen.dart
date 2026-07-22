import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
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
      backgroundColor: MuColors.canvas,
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
                            BoxDecoration(gradient: MuColors.heroGradient),
                      ),
                    )
                  : const DecoratedBox(
                      decoration:
                          BoxDecoration(gradient: MuColors.heroGradient),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(MuSpace.screenH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: MuType.headline),
                  const SizedBox(height: MuSpace.s),
                  Wrap(
                    spacing: MuSpace.xs,
                    runSpacing: MuSpace.xs,
                    children: event.tags.map((t) => MuTagChip(label: t)).toList(),
                  ),
                  const SizedBox(height: MuSpace.m),
                  Row(
                    children: [
                      const Icon(LucideIcons.calendar, size: 18, color: MuColors.inkSecondary),
                      const SizedBox(width: MuSpace.s),
                      Text(
                        _formatDateRange(event.startDatetime, event.endDatetime),
                        style: MuType.body,
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpace.s),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(LucideIcons.mapPin, size: 18, color: MuColors.inkSecondary),
                      const SizedBox(width: MuSpace.s),
                      Expanded(
                        child: Text(
                          event.venue.venueType == 'online'
                              ? (event.venue.venuePlatform?.isNotEmpty ?? false)
                                  ? 'Online · ${event.venue.venuePlatform}'
                                  : 'Online'
                              : [
                                  event.venue.venueAddress,
                                  event.venue.venueCity,
                                ].where((s) => s != null && s.isNotEmpty).join(', '),
                          style: MuType.body,
                        ),
                      ),
                    ],
                  ),
                  if (event.minKarma != null && event.minKarma! > 0) ...[
                    const SizedBox(height: MuSpace.s),
                    Row(
                      children: [
                        const Icon(LucideIcons.zap, size: 18, color: MuColors.inkSecondary),
                        const SizedBox(width: MuSpace.s),
                        Text('${event.minKarma} karma required', style: MuType.body),
                      ],
                    ),
                  ],
                  const SizedBox(height: MuSpace.l),
                  Row(
                    children: [
                      Expanded(
                        child: MuPrimaryButton(
                          label: isBusy
                              ? 'Please wait…'
                              : (event.isInterested ? 'Interested' : "I'm interested"),
                          icon: event.isInterested ? LucideIcons.check : LucideIcons.star,
                          onPressed: isBusy
                              ? null
                              : () => ref
                                  .read(eventInterestControllerProvider.notifier)
                                  .toggle(eventId, interested: !event.isInterested),
                        ),
                      ),
                      if (event.registrationUrl != null &&
                          event.registrationUrl!.isNotEmpty) ...[
                        const SizedBox(width: MuSpace.s),
                        Expanded(
                          child: MuGhostButton(
                            label: 'Register',
                            onPressed: () => launchUrl(
                              Uri.parse(event.registrationUrl!),
                              mode: LaunchMode.externalApplication,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (interestState.hasError) ...[
                    const SizedBox(height: MuSpace.s),
                    Text(
                      ApiException.messageFor(interestState.error!),
                      style: MuType.caption.copyWith(color: MuColors.coral),
                    ),
                  ],
                  if (event.description != null) ...[
                    const SizedBox(height: MuSpace.xxl),
                    const MuSectionHeader(title: 'About'),
                    const SizedBox(height: MuSpace.m),
                    Text(event.description!, style: MuType.body),
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
