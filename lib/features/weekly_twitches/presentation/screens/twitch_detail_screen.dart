import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';
import 'package:mulearn_app/features/weekly_twitches/presentation/providers/weekly_twitches_providers.dart';

/// One Weekly Twitches episode (from the list or an "announced"
/// notification): poster, when, who, where, the Interest Groups it's for,
/// and the link pinned at the bottom (Join now on the day).
class TwitchDetailScreen extends ConsumerWidget {
  const TwitchDetailScreen({required this.show, required this.id, super.key});

  final TwitchShow show;
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(twitchEpisodeProvider(show, id));
    final episode = state.value;
    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(
        child: Column(
          children: [
            const MuTopBar.detail(),
            Expanded(
              child: state.when(
                loading: () => const Center(
                  child: MuDotsLoader(label: 'Loading the episode…'),
                ),
                error: (e, _) => ErrorRetryView(
                  error: e,
                  onRetry: () =>
                      ref.invalidate(twitchEpisodeProvider(show, id)),
                ),
                data: (e) => _Body(episode: e),
              ),
            ),
            if (episode?.link != null) _LinkBar(episode: episode!),
          ],
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.episode});

  final TwitchEpisode episode;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final e = episode;
    final poster = e.posterUrl;
    final status = switch (e.status) {
      TwitchStatus.ongoing => const MuPill(
        'Today',
        tone: MuPillTone.volt,
        icon: LucideIcons.radio,
      ),
      TwitchStatus.upcoming => const MuPill(
        'Upcoming',
        tone: MuPillTone.cobalt,
      ),
      TwitchStatus.completed => const MuPill('Past episode'),
    };
    final description = e.description ?? '';
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        MuSpacing.space2,
        MuSpacing.space5,
        MuSpacing.space8,
      ),
      children: [
        ExcludeSemantics(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MuRadii.card),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (poster != null)
                    CachedNetworkImage(
                      imageUrl: poster,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          MuGeneratedPoster(text: e.title, fontSize: 40),
                      errorWidget: (_, _, _) =>
                          MuGeneratedPoster(text: e.title, fontSize: 40),
                    )
                  else
                    MuGeneratedPoster(text: e.title, fontSize: 40),
                  Positioned(
                    left: 12,
                    top: 12,
                    child: MuPill(e.show.label, tone: MuPillTone.paper),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: MuSpacing.space5),
        Semantics(
          header: true,
          child: Text(e.title, style: mu.text.display.copyWith(fontSize: 30)),
        ),
        const SizedBox(height: MuSpacing.space3),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            status,
            if (e.zone != null)
              MuPill('${e.zone} zone', icon: LucideIcons.mapPin),
            for (final ig in e.interestGroups)
              MuPill(ig, tone: MuPillTone.paper),
          ],
        ),
        const SizedBox(height: MuSpacing.space5),
        MuFeedGroup(
          children: [
            MuFeedRow(
              leading: const MuFeedIcon(
                LucideIcons.calendar,
                tone: MuFeedTone.event,
              ),
              subject: formatDay(e.date),
              time: e.time == null
                  ? 'Time to be announced'
                  : formatTime(e.startsAt),
              divider: e.performer != null || e.campus != null,
            ),
            if (e.performer != null)
              MuFeedRow(
                leading: MuAvatar(
                  name: e.performer!,
                  size: MuSizes.avatarMd,
                  ring: false,
                ),
                subject: e.performer!,
                time: e.designation ?? 'Speaker',
                divider: e.campus != null,
              ),
            if (e.campus != null)
              MuFeedRow(
                leading: const MuFeedIcon(LucideIcons.graduationCap),
                subject: e.campus!,
                time: e.show == TwitchShow.grabYourSuperpowers
                    ? 'Hosting college'
                    : 'Campus',
                divider: false,
              ),
          ],
        ),
        if (description.isNotEmpty) ...[
          const MuSectionEyebrow('ABOUT', top: MuSpacing.space6),
          Text(description, style: mu.text.body.copyWith(color: c.ink2)),
        ],
      ],
    );
  }
}

/// The episode's link, pinned: Join now (volt) on the day, Open link
/// before and after.
class _LinkBar extends ConsumerWidget {
  const _LinkBar({required this.episode});

  final TwitchEpisode episode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.mu.colors;
    final today = episode.status == TwitchStatus.ongoing;
    final uri = Uri.tryParse(episode.link!);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: c.chalk,
        border: Border(top: BorderSide(color: c.line)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          MuSpacing.space5,
          MuSpacing.space3,
          MuSpacing.space5,
          MuSpacing.space3,
        ),
        child: MuButton(
          label: today ? 'Join now' : 'Open link',
          icon: today ? LucideIcons.video : LucideIcons.externalLink,
          variant: today ? MuButtonVariant.volt : MuButtonVariant.ink,
          block: true,
          onPressed: uri == null
              ? null
              : () => unawaited(ref.read(openExternalProvider)(uri)),
        ),
      ),
    );
  }
}
