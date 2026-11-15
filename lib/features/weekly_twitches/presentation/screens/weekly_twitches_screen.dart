import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/widgets/mu_load_more_footer.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/weekly_twitches/domain/entities/twitch.dart';
import 'package:mulearn_app/features/weekly_twitches/presentation/providers/weekly_twitches_providers.dart';

/// Weekly Twitches: the four weekly shows as chips; under each, what's
/// coming up (soonest first, today's marked) and past episodes. Read-only,
/// like the dashboard's `/dashboard/weekly-twitches`.
class WeeklyTwitchesScreen extends ConsumerStatefulWidget {
  const WeeklyTwitchesScreen({this.initial = TwitchShow.officeHours, super.key});

  /// The show to open on (`?show=` from a link).
  final TwitchShow initial;

  @override
  ConsumerState<WeeklyTwitchesScreen> createState() => _WeeklyTwitchesScreenState();
}

class _WeeklyTwitchesScreenState extends ConsumerState<WeeklyTwitchesScreen> {
  late TwitchShow _show = widget.initial;

  bool _onScroll(ScrollNotification n) {
    final past = ref.read(twitchesPastProvider(_show)).value;
    if (n.metrics.extentAfter < 400 && past != null && past.hasMore && past.loadMoreError == null) {
      unawaited(ref.read(twitchesPastProvider(_show).notifier).loadMore());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final comingUp = ref.watch(twitchesComingUpProvider(_show));
    final past = ref.watch(twitchesPastProvider(_show));

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: MuRefresh(
          onRefresh: () => Future.wait([
            ref.refresh(twitchesComingUpProvider(_show).future),
            ref.refresh(twitchesPastProvider(_show).future),
          ]),
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: ListView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space2,
                MuSpacing.space5,
                MuSpacing.space8,
              ),
              children: [
                if (Navigator.of(context).canPop()) ...[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: MuIconButton(icon: LucideIcons.arrowLeft, tooltip: 'Back', onPressed: () => context.pop()),
                  ),
                  const SizedBox(height: MuSpacing.space3),
                ],
                Semantics(
                  header: true,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Weekly\n', style: mu.text.displayLight.copyWith(fontSize: 36)),
                        TextSpan(text: 'Twitches', style: mu.text.display.copyWith(fontSize: 36)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: MuSpacing.space2),
                Text(
                  'Four shows every week: talks, campus stories and skill sessions. Open to everyone.',
                  style: mu.text.body.copyWith(color: c.ink2),
                ),
                const SizedBox(height: MuSpacing.space4),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      for (final s in TwitchShow.values) ...[
                        MuFilterChip(label: s.label, selected: s == _show, onTap: () => setState(() => _show = s)),
                        const SizedBox(width: MuSpacing.space2),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: MuSpacing.space2),
                Text(_show.blurb, style: mu.text.caption),
                const MuSectionEyebrow('COMING UP', top: MuSpacing.space5),
                ...comingUp.when(
                  skipError: true,
                  loading: () => [const _Loading()],
                  error: (e, _) => [_Problem(error: e, onRetry: () => ref.invalidate(twitchesComingUpProvider(_show)))],
                  data: (items) => items.isEmpty
                      ? [MuEmptyLine('Nothing announced yet. New ${_show.label} episodes show up here.')]
                      : [_Episodes(items)],
                ),
                const MuSectionEyebrow('PAST EPISODES', top: MuSpacing.space6),
                ...past.when(
                  skipError: true,
                  loading: () => [const _Loading()],
                  error: (e, _) => [_Problem(error: e, onRetry: () => ref.invalidate(twitchesPastProvider(_show)))],
                  data: (paged) => [
                    if (paged.items.isEmpty) const MuEmptyLine('No past episodes yet.') else _Episodes(paged.items),
                    if (paged.hasMore || paged.loadMoreError != null)
                      MuLoadMoreFooter(
                        isLoading: paged.isLoadingMore,
                        error: paged.loadMoreError,
                        onRetry: () => ref.read(twitchesPastProvider(_show).notifier).loadMore(),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: MuSpacing.space5),
    child: Center(child: MuDotsLoader()),
  );
}

class _Problem extends StatelessWidget {
  const _Problem({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(child: MuEmptyLine(ApiException.messageFor(error))),
      MuButton(label: 'Retry', variant: MuButtonVariant.ghost, size: MuButtonSize.small, onPressed: onRetry),
    ],
  );
}

class _Episodes extends StatelessWidget {
  const _Episodes(this.items);

  final List<TwitchEpisode> items;

  @override
  Widget build(BuildContext context) => MuFeedGroup(
    children: [for (var i = 0; i < items.length; i++) EpisodeRow(episode: items[i], last: i == items.length - 1)],
  );
}

const _months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

/// An episode as a feed row: its date as a calendar leaf, title, when and
/// who; "Today" when it's on today. Opens the episode.
class EpisodeRow extends StatelessWidget {
  const EpisodeRow({required this.episode, this.last = false, super.key});

  final TwitchEpisode episode;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    final e = episode;
    final today = e.status == TwitchStatus.ongoing;
    final who = e.performer ?? e.campus;
    return MuFeedRow(
      leading: Container(
        width: 44,
        height: 48,
        decoration: BoxDecoration(
          color: today ? c.volt : c.surfaceSunk,
          borderRadius: BorderRadius.circular(MuRadii.control),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _months[e.date.month - 1],
              style: mu.text.caption.copyWith(fontSize: 10, color: today ? c.onVolt : c.ink3, height: 1),
            ),
            const SizedBox(height: 2),
            Text(
              '${e.date.day}',
              style: mu.text.bodyStrong.copyWith(fontSize: 18, color: today ? c.onVolt : c.ink, height: 1),
            ),
          ],
        ),
      ),
      subject: e.title,
      time: [if (e.time != null) formatTime(e.startsAt) else formatDay(e.date), ?who].join(' · '),
      trailing: Icon(LucideIcons.chevronRight, size: MuSizes.iconSm + 2, color: c.ink3),
      actions: [if (today) const MuPill('Today', tone: MuPillTone.volt, icon: LucideIcons.radio)],
      divider: !last,
      onTap: () => context.push(RoutePaths.weeklyTwitchPath(e.show.slug, e.id)),
    );
  }
}
