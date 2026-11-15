import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/leaderboard/leaderboard_providers.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/router/tab_navigation.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/role_pending_banner.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/workspace_cards.dart';

/// Home, built from the design system (artifact: Screen patterns → Home).
///
/// Greeting bar → the karma card (the screen's one loud element) → this
/// week → "Up next" bento → top performers → happening soon. Nothing here
/// is faked: sections without backing data are left out.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refreshAll(WidgetRef ref) {
    // Roles and mentor applications too: an approval since launch shows.
    invalidateSessionState(ref.invalidate);
    return Future.wait([
      ref.read(myProgressSummaryControllerProvider.notifier).refresh(),
      ref.read(featuredEventsControllerProvider.notifier).refresh(),
      ref.refresh(learnerSummaryProvider.future),
    ]);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.mu.colors;
    final summaryState = ref.watch(myProgressSummaryControllerProvider);
    final summary = summaryState.value;

    return Scaffold(
      backgroundColor: c.chalk,
      body: SafeArea(
        bottom: false,
        child: MuRefresh(
          onRefresh: () => _refreshAll(ref),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: MuSpacing.space2),
                  child: _Greeting(summary: summary),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space3,
                  MuSpacing.space5,
                  MuSpacing.navClearance,
                ),
                sliver: SliverList.list(
                  children: [
                    // A role awaiting verification (ROLE-02).
                    const PendingRoleBanners(),
                    const SizedBox(height: MuSpacing.space2),
                    summaryState.when(
                      skipError: true,
                      skipLoadingOnReload: true,
                      loading: () => const _KarmaPlaceholder(),
                      error: (error, _) => _LoadFailed(
                        message: "Couldn't load your karma",
                        onRetry: () => ref.read(myProgressSummaryControllerProvider.notifier).refresh(),
                      ),
                      data: (s) => MuKarmaMeter(
                        total: s.karma,
                        level: s.level == null ? null : levelLabel(s.level),
                        rank: s.rank != null && s.percentile != null
                            ? 'Rank #${s.rank} · Top ${s.percentile!.round()}%'
                            : null,
                        onTap: () => context.openTab(RoutePaths.journey),
                      ),
                    ),
                    const _ThisWeek(),
                    const SizedBox(height: MuSpacing.space10),
                    const _UpNext(),
                    const SizedBox(height: MuSpacing.space10),
                    const _TopPerformers(),
                    const SizedBox(height: MuSpacing.space10),
                    const _HappeningSoon(),
                    // Role workspaces open from Home (spec §8.2 item 5); the
                    // artifact closes Home with these doors.
                    const WorkspaceCards(),
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

/// "Friday, 13 Nov · Level 4", or just the date until the summary loads.
String _subtitle(MyProgressSummary? s, DateTime now) {
  final date =
      '${const ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'][now.weekday - 1]}, '
      '${formatDay(now).split(' ').skip(1).join(' ')}';
  return s?.level == null ? date : '$date · ${levelLabel(s!.level)}';
}

class _Greeting extends ConsumerWidget {
  const _Greeting({this.summary});

  final MyProgressSummary? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = summary;
    final first = (s != null && s.fullName.trim().isNotEmpty) ? s.fullName.trim().split(' ').first : 'there';
    final unread = ref.watch(unreadNotificationsProvider).value ?? 0;
    return MuTopBar.greeting(
      greeting: 'Hey $first',
      subtitle: _subtitle(s, DateTime.now()),
      avatar: Semantics(
        button: true,
        label: 'Your profile',
        excludeSemantics: true,
        child: MuPressable(
          onTap: () => context.openTab(RoutePaths.profile),
          child: MuAvatar(name: s?.fullName ?? '', url: s?.profilePicUrl, size: MuSizes.avatarMd, ring: false),
        ),
      ),
      actions: [
        MuIconButton(icon: LucideIcons.search, tooltip: 'Search', onPressed: () => context.push(RoutePaths.search)),
        MuIconButton(
          icon: LucideIcons.bell,
          badgeCount: unread,
          tooltip: unread == 0 ? 'Notifications' : 'Notifications, $unread unread',
          onPressed: () => context.push(RoutePaths.notifications),
        ),
      ],
    );
  }
}

class _KarmaPlaceholder extends StatelessWidget {
  const _KarmaPlaceholder();

  @override
  Widget build(BuildContext context) => Container(
    height: 196,
    decoration: BoxDecoration(color: context.mu.colors.surfaceSunk, borderRadius: BorderRadius.circular(MuRadii.panel)),
  );
}

class _LoadFailed extends StatelessWidget {
  const _LoadFailed({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Text(message, style: context.mu.text.caption.copyWith(color: context.mu.colors.ink2)),
      ),
      MuButton(label: 'Retry', variant: MuButtonVariant.ghost, size: MuButtonSize.small, onPressed: onRetry),
    ],
  );
}

/// Karma this week and the streak, as pills under the karma card.
class _ThisWeek extends ConsumerWidget {
  const _ThisWeek();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(learnerSummaryProvider)
        .when(
          skipError: true,
          loading: () => const SizedBox.shrink(),
          error: (_, _) => Padding(
            padding: const EdgeInsets.only(top: MuSpacing.space2),
            child: _LoadFailed(
              message: "Couldn't load your week",
              onRetry: () => ref.invalidate(learnerSummaryProvider),
            ),
          ),
          data: (week) => Padding(
            padding: const EdgeInsets.only(top: MuSpacing.space3),
            child: Wrap(
              spacing: MuSpacing.space2,
              runSpacing: MuSpacing.space2,
              children: [
                MuPill(
                  '+${muGrouped(week.weeklyKarma)} this week',
                  tone: MuPillTone.volt,
                  icon: LucideIcons.trendingUp,
                ),
                if (week.streakDays > 0) MuPill('${week.streakDays}-day streak', icon: LucideIcons.flame),
              ],
            ),
          ),
        );
  }
}

/// The bento: the next circle meeting (tall), the two ways to learn, and
/// whatever setup is still to do.
class _UpNext extends ConsumerWidget {
  const _UpNext();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final week = ref.watch(learnerSummaryProvider).value;
    final meeting = week?.nextMeeting;
    final caps = ref.watch(capabilitiesProvider).value;
    final needsDiscord = (caps?.needsDiscord ?? false) && ref.watch(discordAuthUriProvider) != null;
    final canBrowseJobs = caps?.canBrowseJobs ?? false;
    final summary = ref.watch(myProgressSummaryControllerProvider).value;
    final needsGroups = summary != null && summary.interestGroupCount == 0;

    final tiles = <MuTile>[
      if (meeting != null)
        MuTile(
          title: meeting.title,
          size: MuTileSize.tall,
          fill: MuTileFill.cobalt,
          pill: MuPill('Circle · ${formatDay(meeting.startsAt.toLocal())}', tone: MuPillTone.paper),
          meta: '${meeting.circleName}\n${formatTime(meeting.startsAt.toLocal())}',
          onTap: () => context.push(RoutePaths.meetingDetailPath(meeting.id)),
        ),
      MuTile(
        title: 'Find a task',
        fill: MuTileFill.volt,
        meta: 'Earn karma with a hashtag',
        onTap: () => context.openTab(RoutePaths.tasks),
      ),
      MuTile(
        title: 'Learning circles',
        fill: MuTileFill.night,
        meta: 'Learn with a group',
        onTap: () => context.push(RoutePaths.learningCircles),
      ),
      // With no group yet, "Join interest groups" under Get set up says it.
      if (!needsGroups)
        MuTile(
          title: 'Interest groups',
          category: IgCategory.maker,
          meta: 'Find and join communities',
          onTap: () => context.push(RoutePaths.interestGroups),
        ),
      MuTile(
        title: 'Weekly Twitches',
        fill: MuTileFill.cobalt,
        meta: 'Talks and campus shows',
        onTap: () => context.push(RoutePaths.weeklyTwitches),
      ),
      MuTile(
        title: 'Mentor sessions',
        category: IgCategory.creative,
        meta: 'Join one, or ask for help',
        onTap: () => context.push(RoutePaths.learnerSessions),
      ),
      MuTile(
        title: 'Projects',
        fill: MuTileFill.volt,
        meta: 'See what learners built, show yours',
        onTap: () => context.push(RoutePaths.projects),
      ),
      MuTile(
        title: 'Problem statements',
        category: IgCategory.manager,
        meta: 'Solve real problems, share your fix',
        onTap: () => context.push(RoutePaths.problemStatements),
      ),
      if (canBrowseJobs)
        MuTile(
          title: 'Internships & gigs',
          category: IgCategory.coder,
          meta: 'Put your karma to work',
          onTap: () => context.push(RoutePaths.opportunities),
        ),
    ];
    final setup = <MuTile>[
      if (needsDiscord)
        MuTile(
          title: 'Connect Discord',
          category: IgCategory.creative,
          size: MuTileSize.short,
          meta: 'Post your task proof there to earn karma',
          onTap: () => unawaited(ref.read(discordConnectFlowProvider.notifier).start()),
        ),
      if (needsGroups)
        MuTile(
          title: 'Join interest groups',
          category: IgCategory.manager,
          size: MuTileSize.short,
          meta: 'Pick up to three to see their tasks',
          onTap: () => context.push(RoutePaths.interestGroups),
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (setup.isNotEmpty) ...[
          const MuSectionTitle('Get set up'),
          const SizedBox(height: MuSpacing.space3),
          MuBento(tiles: setup),
          const SizedBox(height: MuSpacing.space10),
        ],
        MuSectionTitle(meeting != null ? 'Up next' : 'Keep going'),
        const SizedBox(height: MuSpacing.space3),
        MuBento(tiles: tiles),
      ],
    );
  }
}

class _TopPerformers extends ConsumerWidget {
  const _TopPerformers();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = context.mu.colors;
    return ref
        .watch(studentLeaderboardProvider(monthly: false))
        .when(
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
          data: (entries) {
            if (entries.isEmpty) return const SizedBox.shrink();
            final top = entries.take(3).toList();
            final max = top.first.totalKarma.toInt();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MuSectionTitle('Top performers', onSeeAll: () => context.openTab(RoutePaths.leaderboard)),
                const SizedBox(height: MuSpacing.space3),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4, vertical: MuSpacing.space1),
                  decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
                  child: Column(
                    children: [
                      for (var i = 0; i < top.length; i++)
                        MuRankRow(
                          rank: i + 1,
                          maxKarma: max,
                          entry: MuRankEntry(
                            name: top[i].fullName,
                            karma: top[i].totalKarma.toInt(),
                            subtitle: top[i].institution,
                            photoUrl: top[i].profilePic,
                          ),
                          onTap: top[i].muid == null
                              ? null
                              : () => context.push(RoutePaths.publicProfilePath(top[i].muid!)),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
  }
}

class _HappeningSoon extends ConsumerWidget {
  const _HappeningSoon();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(featuredEventsControllerProvider)
        .when(
          loading: () => const SizedBox.shrink(),
          error: (_, _) => const SizedBox.shrink(),
          data: (events) {
            if (events.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MuSectionTitle('Happening soon', onSeeAll: () => context.push(RoutePaths.events)),
                const SizedBox(height: MuSpacing.space3),
                for (final e in events.take(2)) ...[
                  Center(child: _Ticket(event: e)),
                  const SizedBox(height: MuSpacing.space5),
                ],
              ],
            );
          },
        );
  }
}

class _Ticket extends StatelessWidget {
  const _Ticket({required this.event});

  final FeaturedEvent event;

  String get _place =>
      event.venue.venueType == 'online' ? 'Online' : (event.venue.venueCity ?? 'Venue to be announced');

  @override
  Widget build(BuildContext context) {
    final starts = DateTime.tryParse(event.startDatetime)?.toLocal();
    final ends = DateTime.tryParse(event.endDatetime)?.toLocal();
    final when = starts == null || ends == null
        ? _place
        : '${formatWhen(starts: starts, ends: ends, now: DateTime.now())} · $_place';
    void open() => context.push(RoutePaths.eventDetailPath(event.id));
    return MuEventTicket(
      title: event.title,
      when: when,
      posterUrl: event.coverImage,
      capacity: event.interestCount > 0
          ? MuPill('${muGrouped(event.interestCount)} interested', tone: MuPillTone.night, icon: LucideIcons.users)
          : null,
      kind: event.eventScope.isEmpty
          ? null
          : MuPill(event.eventScope[0].toUpperCase() + event.eventScope.substring(1), tone: MuPillTone.paper),
      pills: [
        if ((event.minKarma ?? 0) > 0) MuPill('${muGrouped(event.minKarma!)}+ karma to join', icon: LucideIcons.zap),
        for (final tag in event.tags.take(2)) MuPill(tag, mono: true),
      ],
      stub: MuButton(label: 'View event', variant: MuButtonVariant.ink, knob: true, block: true, onPressed: open),
      onTap: open,
    );
  }
}
