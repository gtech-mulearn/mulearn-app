import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/domain/entities/event_linked_task.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';

/// One event, read like the ticket it came from: the poster, the title in
/// display type, when and where, who runs it, what it's about and the tasks
/// that earn karma there. The action sits pinned at the bottom like the
/// ticket stub: Register (when there's a form) with interest beside it.
class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({required this.eventId, super.key});

  final String eventId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(eventDetailProvider(eventId));
    final event = detailState.value;

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            const MuTopBar.detail(),
            Expanded(
              child: detailState.when(
                loading: () => const Center(child: MuDotsLoader(label: 'Loading the event…')),
                error: (error, _) =>
                    ErrorRetryView(error: error, onRetry: () => ref.invalidate(eventDetailProvider(eventId))),
                data: (e) => _Body(event: e),
              ),
            ),
            if (event != null) _StubBar(event: event),
          ],
        ),
      ),
    );
  }
}

String? _place(Event e) {
  final v = e.venue;
  if (v.venueType == 'online') {
    return (v.venuePlatform?.isNotEmpty ?? false) ? 'Online · ${v.venuePlatform}' : 'Online';
  }
  final parts = [v.venueAddress, v.venueCity].where((s) => s != null && s.trim().isNotEmpty).join(', ');
  return parts.isEmpty ? null : parts;
}

String? _organiser(Event e) {
  final o = e.organizer;
  return switch (o.organiserType) {
    'admin' => 'μLearn Foundation',
    'global_ig' || 'campus_ig' => o.organiserIg?.name,
    'campus' => o.organiserCampus?.title,
    'company' || 'partner' => o.organiserCompany?.title,
    _ => null,
  };
}

class _Body extends ConsumerWidget {
  const _Body({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final start = DateTime.tryParse(event.startDatetime)?.toLocal();
    final end = DateTime.tryParse(event.endDatetime)?.toLocal();
    final kind = eventTypeLabels[event.eventType] ?? event.categoryName;
    final online = event.venue.venueType == 'online';
    final place = _place(event);
    final mapsUrl = event.venue.venueMapsUrl;
    final organiser = _organiser(event);
    final poster = event.bannerImage ?? event.coverImage;
    final description = event.description?.trim() ?? '';
    final deadline = DateTime.tryParse(event.registrationDeadline ?? '')?.toLocal();

    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, MuSpacing.space8),
      children: [
        ExcludeSemantics(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MuRadii.card),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (poster != null && poster.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: poster,
                      fit: BoxFit.cover,
                      placeholder: (_, _) => MuGeneratedPoster(text: event.title, fontSize: 44),
                      errorWidget: (_, _, _) => MuGeneratedPoster(text: event.title, fontSize: 44),
                    )
                  else
                    MuGeneratedPoster(text: event.title, fontSize: 44),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: MuPill('${muGrouped(event.interestCount)} interested', tone: MuPillTone.night),
                  ),
                  if (kind != null) Positioned(right: 12, top: 12, child: MuPill(kind, tone: MuPillTone.paper)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: MuSpacing.space5),
        Semantics(header: true, child: Text(event.title, style: mu.text.display.copyWith(fontSize: 32))),
        const SizedBox(height: MuSpacing.space3),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            MuPill(online ? 'Online' : 'In person', icon: online ? LucideIcons.wifi : LucideIcons.mapPin),
            if (event.minKarma != null && event.minKarma! > 0)
              MuPill('${muGrouped(event.minKarma!)}+ karma', tone: MuPillTone.volt),
            if (event.userLimit != null && event.userLimit! > 0) MuPill('${muGrouped(event.userLimit!)} seats'),
            if (event.isFeatured) const MuPill('Featured', tone: MuPillTone.cobalt, icon: LucideIcons.sparkles),
            for (final t in event.tags) MuPill('#$t'),
          ],
        ),
        if (!event.canRegister && event.blockedReason != null) ...[
          const SizedBox(height: MuSpacing.space4),
          Container(
            padding: const EdgeInsets.all(MuSpacing.space4),
            decoration: BoxDecoration(color: c.warningTint, borderRadius: BorderRadius.circular(MuRadii.control)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(LucideIcons.info, size: MuSizes.iconSm + 2, color: c.warning),
                const SizedBox(width: MuSpacing.space2),
                Expanded(
                  child: Text(event.blockedReason!, style: mu.text.body.copyWith(color: c.ink)),
                ),
              ],
            ),
          ),
        ],
        const SizedBox(height: MuSpacing.space5),
        MuFeedGroup(
          children: [
            if (start != null)
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.calendar, tone: MuFeedTone.event),
                subject: end == null ? formatDay(start) : formatRange(start, end),
                time: end == null ? formatTime(start) : '${formatTime(start)} – ${formatTime(end)}',
              ),
            MuFeedRow(
              leading: MuFeedIcon(online ? LucideIcons.wifi : LucideIcons.mapPin, tone: MuFeedTone.event),
              subject: place ?? 'Venue to be announced',
              time: online
                  ? 'The link arrives once you register'
                  : (mapsUrl?.isNotEmpty ?? false)
                  ? 'Open in Maps'
                  : null,
              trailing: !online && (mapsUrl?.isNotEmpty ?? false)
                  ? Icon(LucideIcons.arrowUpRight, size: MuSizes.iconSm, color: c.ink3)
                  : null,
              onTap: !online && (mapsUrl?.isNotEmpty ?? false) ? () => unawaited(_open(ref, mapsUrl!)) : null,
              divider: organiser != null || deadline != null,
            ),
            if (organiser != null)
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.users),
                subject: organiser,
                time: 'Organiser',
                divider: deadline != null,
              ),
            if (deadline != null)
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.clock, tone: MuFeedTone.pending),
                subject: 'Register by ${formatDay(deadline)}',
                time: formatTime(deadline),
                divider: false,
              ),
          ],
        ),
        if (description.isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space6),
          Semantics(header: true, child: Text('ABOUT', style: mu.text.eyebrow)),
          const SizedBox(height: MuSpacing.space2),
          Text(description, style: mu.text.bodyLg.copyWith(color: c.ink2)),
        ],
        if (event.linkedTasks.isNotEmpty) ...[
          const SizedBox(height: MuSpacing.space6),
          Semantics(header: true, child: Text('TASKS FOR THIS EVENT', style: mu.text.eyebrow)),
          const SizedBox(height: MuSpacing.space1),
          Text(
            'Post your proof on Discord with the hashtag to earn karma.',
            style: mu.text.caption.copyWith(color: c.ink3),
          ),
          const SizedBox(height: MuSpacing.space3),
          MuFeedGroup(
            children: [
              for (var i = 0; i < event.linkedTasks.length; i++)
                _LinkedTaskRow(task: event.linkedTasks[i], last: i == event.linkedTasks.length - 1),
            ],
          ),
        ],
      ],
    );
  }
}

Future<void> _open(WidgetRef ref, String url) async {
  final uri = Uri.tryParse(url);
  if (uri != null) await ref.read(openExternalProvider)(uri);
}

/// A task linked to the event: tap copies its hashtag for the Discord post.
class _LinkedTaskRow extends StatelessWidget {
  const _LinkedTaskRow({required this.task, required this.last});

  final EventLinkedTask task;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final hashtag = task.hashtag;
    final karma = task.karma;
    final hasTag = hashtag != null && hashtag.isNotEmpty;
    return MuFeedRow(
      leading: const MuFeedIcon(LucideIcons.target, tone: MuFeedTone.karma),
      subject: task.title,
      time: hasTag ? '$hashtag · tap to copy' : task.igName,
      trailing: karma == null ? null : MuFeedAmount('+${karma.toInt()} karma'),
      divider: !last,
      onTap: !hasTag
          ? null
          : () async {
              await Clipboard.setData(ClipboardData(text: hashtag));
              if (context.mounted) MuToast.show(context, message: 'Copied $hashtag', type: MuToastType.success);
            },
    );
  }
}

/// The ticket stub, pinned: Register opens the event's form when it has
/// one, with interest as the quieter choice beside it; otherwise interest
/// is the action. Both are off, with the reason above, when the event
/// can't take registrations.
class _StubBar extends ConsumerWidget {
  const _StubBar({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final interestState = ref.watch(eventInterestControllerProvider);
    final busy = interestState.isLoading;
    final interested = event.isInterested;
    final open = event.canRegister;
    final form = event.registrationUrl;
    final hasForm = form != null && form.isNotEmpty;

    void toggle() =>
        unawaited(ref.read(eventInterestControllerProvider.notifier).toggle(event.id, interested: !interested));

    final interest = MuButton(
      label: interested ? 'Interested' : "I'm interested",
      icon: interested ? LucideIcons.check : LucideIcons.star,
      variant: hasForm || interested ? MuButtonVariant.outline : MuButtonVariant.ink,
      block: true,
      loading: busy,
      onPressed: open && !busy ? toggle : null,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.chalk,
        border: Border(top: BorderSide(color: c.line)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space3, MuSpacing.space5, MuSpacing.space3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (interestState.hasError) ...[
              Text(ApiException.messageFor(interestState.error!), style: mu.text.caption.copyWith(color: c.danger)),
              const SizedBox(height: MuSpacing.space2),
            ],
            if (hasForm)
              Row(
                children: [
                  Expanded(flex: 4, child: interest),
                  const SizedBox(width: MuSpacing.space2),
                  Expanded(
                    flex: 5,
                    child: MuButton(
                      label: 'Register',
                      variant: MuButtonVariant.ink,
                      knob: true,
                      block: true,
                      onPressed: open ? () => unawaited(_open(ref, form)) : null,
                    ),
                  ),
                ],
              )
            else
              interest,
          ],
        ),
      ),
    );
  }
}
