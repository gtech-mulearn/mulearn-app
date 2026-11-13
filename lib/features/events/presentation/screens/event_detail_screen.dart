import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_buttons.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_toast.dart';
import 'package:mulearn_app/features/events/domain/entities/event_linked_task.dart';
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
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(gradient: MuColors.karmaGradient),
                  ),
                  if ((event.bannerImage ?? event.coverImage) != null)
                    CachedNetworkImage(
                      imageUrl: (event.bannerImage ?? event.coverImage)!,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => const DecoratedBox(
                        decoration: BoxDecoration(gradient: MuColors.karmaGradient),
                      ),
                    ),
                  Positioned(
                    right: MuSpace.m,
                    top: MuSpace.m,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: MuColors.imageScrim,
                        borderRadius: BorderRadius.circular(MuRadius.chip),
                      ),
                      child: Text(
                        event.venue.venueType == 'online' ? 'ONLINE' : 'IN PERSON',
                        style: MuType.tag.copyWith(color: MuColors.surface),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(MuSpace.screenH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title, style: MuType.headline.copyWith(fontSize: 26)),
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
                  // Eligibility up front (UX-07): the backend's own reason,
                  // before any tap, with the actions disabled.
                  if (!event.canRegister && event.blockedReason != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(MuSpace.m),
                      decoration: BoxDecoration(
                        color: MuColors.warningBg,
                        borderRadius: BorderRadius.circular(MuRadius.inner),
                      ),
                      child: Row(
                        children: [
                          const Icon(LucideIcons.info, size: 18, color: MuColors.warning),
                          const SizedBox(width: MuSpace.s),
                          Expanded(
                            child: Text(event.blockedReason!, style: MuType.body.copyWith(color: MuColors.warning)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: MuSpace.m),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: MuPrimaryButton(
                          label: isBusy
                              ? 'Please wait…'
                              : (event.isInterested ? 'Interested' : "I'm interested"),
                          icon: event.isInterested ? LucideIcons.check : LucideIcons.star,
                          onPressed: isBusy || !event.canRegister
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
                            onPressed: event.canRegister
                                ? () => launchUrl(
                                      Uri.parse(event.registrationUrl!),
                                      mode: LaunchMode.externalApplication,
                                    )
                                : null,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (interestState.hasError) ...[
                    const SizedBox(height: MuSpace.s),
                    Text(
                      ApiException.messageFor(interestState.error!),
                      style: MuType.caption.copyWith(color: MuColors.error),
                    ),
                  ],
                  if (event.description != null) ...[
                    const SizedBox(height: MuSpace.xxl),
                    const MuSectionHeader(title: 'About'),
                    const SizedBox(height: MuSpace.m),
                    Text(event.description!, style: MuType.body),
                  ],
                  if (event.linkedTasks.isNotEmpty) ...[
                    const SizedBox(height: MuSpace.xxl),
                    const MuSectionHeader(title: 'Tasks for this event'),
                    const SizedBox(height: MuSpace.m),
                    for (final task in event.linkedTasks) ...[
                      _LinkedTaskTile(task: task),
                      const SizedBox(height: MuSpace.s),
                    ],
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

/// A task linked to the event: title, hashtag (copy it into the Discord
/// post) and karma.
class _LinkedTaskTile extends StatelessWidget {
  const _LinkedTaskTile({required this.task});

  final EventLinkedTask task;

  @override
  Widget build(BuildContext context) {
    final hashtag = task.hashtag;
    final karma = task.karma;
    return MuCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title, style: MuType.bodyMed),
                if (hashtag != null && hashtag.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(hashtag, style: MuType.caption.copyWith(color: MuColors.primary)),
                ],
                if (karma != null) ...[
                  const SizedBox(height: 2),
                  Text('+${karma.toInt()} karma', style: MuType.caption.copyWith(color: MuColors.karmaAccent)),
                ],
              ],
            ),
          ),
          if (hashtag != null && hashtag.isNotEmpty)
            IconButton(
              tooltip: 'Copy hashtag',
              icon: const Icon(LucideIcons.copy, size: 18),
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: hashtag));
                if (context.mounted) MuToast.show(context, message: 'Copied $hashtag', type: MuToastType.success);
              },
            ),
        ],
      ),
    );
  }
}
