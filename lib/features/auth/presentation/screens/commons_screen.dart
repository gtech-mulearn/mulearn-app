import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/leaderboard/leaderboard_providers.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/core/widgets/mu_logo.dart';
import 'package:mulearn_app/features/auth/domain/entities/public_community.dart';
import 'package:mulearn_app/features/auth/presentation/providers/welcome_providers.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/guest_sign_in_sheet.dart';

const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

String? _n(int? v) => v == null || v <= 0 ? null : muGrouped(v);

/// The Commons (artifact Pre-login → The Commons): μLearn as a guest sees
/// it, live, before anyone asks for an email. Every action leads somewhere:
/// trying to join or open something asks to sign in, titled with that
/// action, and brings the person back to it.
class CommonsScreen extends ConsumerWidget {
  const CommonsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    final stats = ref.watch(publicStatsProvider).value ?? const PublicStats();
    final events = ref.watch(guestFeaturedEventsProvider).value ?? const <GuestEvent>[];
    final groups = ref.watch(guestInterestGroupsProvider).value ?? const <GuestInterestGroup>[];
    final top = ref.watch(studentLeaderboardProvider(monthly: true)).value ?? const [];
    final members = _n(stats.members);
    final event = events.isEmpty ? null : events.first;

    void ask(String action, String resumeTo) => unawaited(showGuestSignIn(context, action: action, resumeTo: resumeTo));

    final pulse = [
      if (event != null) '${event.title} · ${_dayOf(event)}',
      ?(members == null ? null : '$members learners'),
      ?(_n(stats.circles) == null ? null : '${_n(stats.circles)} learning circles'),
      ?(_n(stats.interestGroups) == null ? null : '${_n(stats.interestGroups)} Interest Groups'),
      ?(_n(stats.mentors) == null ? null : '${_n(stats.mentors)} mentors'),
    ];

    return Scaffold(
      backgroundColor: c.chalk,
      body: Stack(
        children: [
          RefreshIndicator(
            color: c.cobalt,
            onRefresh: () async {
              ref
                ..invalidate(publicStatsProvider)
                ..invalidate(guestFeaturedEventsProvider)
                ..invalidate(guestInterestGroupsProvider);
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
              slivers: [
                SliverSafeArea(
                  bottom: false,
                  sliver: SliverPadding(
                    padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space3, MuSpacing.space5, 0),
                    sliver: SliverList.list(
                      children: [
                        Row(
                          children: [
                            ExcludeSemantics(
                              child: context.mu.isDark
                                  ? const MuLogo.wordmarkOnBrand()
                                  : const MuLogo.wordmark(height: 30),
                            ),
                            const Spacer(),
                            MuButton(
                              label: 'Sign in',
                              variant: MuButtonVariant.outline,
                              size: MuButtonSize.small,
                              onPressed: () => context.push(RoutePaths.signIn),
                            ),
                          ],
                        ),
                        const SizedBox(height: MuSpacing.space6),
                        Semantics(
                          header: true,
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Learn with\n',
                                  style: mu.text.displayLight.copyWith(fontSize: 36, height: 1.04),
                                ),
                                TextSpan(
                                  text: members == null ? 'your peers' : '$members peers',
                                  style: mu.text.display.copyWith(fontSize: 36, height: 1.04),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: MuSpacing.space5),
                        MuSwitchboard(
                          doors: [
                            MuDoor(
                              label: 'Events',
                              icon: LucideIcons.ticket,
                              tone: IgCategory.maker,
                              onTap: () => ask('see every event', RoutePaths.events),
                            ),
                            MuDoor(
                              label: 'Interest Groups',
                              icon: LucideIcons.hash,
                              tone: IgCategory.coder,
                              onTap: () => ask('join an Interest Group', RoutePaths.interestGroups),
                            ),
                            MuDoor(
                              label: 'Learning Circles',
                              icon: LucideIcons.users,
                              tone: IgCategory.creative,
                              onTap: () => ask('join a learning circle', RoutePaths.learningCircles),
                            ),
                            MuDoor(
                              label: 'Campuses',
                              icon: LucideIcons.school,
                              tone: IgCategory.manager,
                              onTap: () => ask('see the campus rankings', RoutePaths.leaderboard),
                            ),
                          ],
                          pulse: pulse,
                        ),
                        if (event != null) ...[
                          const SizedBox(height: MuSpacing.space8),
                          _LiveSlab(
                            event: event,
                            onJoin: () => ask('join ${event.title}', RoutePaths.eventDetailPath(event.id)),
                          ),
                        ],
                        if (groups.isNotEmpty) ...[
                          const SizedBox(height: MuSpacing.space10),
                          MuSectionTitle('Pick your corner', trailing: '${groups.length} groups'),
                        ],
                      ],
                    ),
                  ),
                ),
                if (groups.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 210,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space2, MuSpacing.space5, 0),
                        itemCount: groups.length,
                        separatorBuilder: (_, _) => const SizedBox(width: MuSpacing.space3),
                        itemBuilder: (context, i) => SizedBox(
                          width: 170,
                          child: MuIgSticker(
                            name: groups[i].name,
                            category: const [
                              IgCategory.coder,
                              IgCategory.creative,
                              IgCategory.maker,
                              IgCategory.manager,
                            ][i % 4],
                            index: i,
                            onTap: () =>
                                ask('open ${groups[i].name}', RoutePaths.interestGroupDetailPath(groups[i].id)),
                            onJoin: () =>
                                ask('join ${groups[i].name}', RoutePaths.interestGroupDetailPath(groups[i].id)),
                          ),
                        ),
                      ),
                    ),
                  ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, 140),
                  sliver: SliverList.list(
                    children: [
                      if (top.isNotEmpty) ...[
                        const SizedBox(height: MuSpacing.space10),
                        MuSectionTitle(
                          'Top this month',
                          onSeeAll: () => ask('see the full leaderboard', RoutePaths.leaderboard),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4),
                          decoration: BoxDecoration(
                            color: c.surface,
                            borderRadius: BorderRadius.circular(MuRadii.card),
                          ),
                          child: Column(
                            children: [
                              for (var i = 0; i < top.length && i < 3; i++)
                                MuRankRow(
                                  rank: i + 1,
                                  maxKarma: top.first.totalKarma.toInt(),
                                  entry: MuRankEntry(
                                    name: top[i].fullName,
                                    karma: top[i].totalKarma.toInt(),
                                    subtitle: top[i].institution,
                                    photoUrl: top[i].profilePic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: MuSpacing.space10),
                      const MuSectionTitle('How you grow'),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4, vertical: MuSpacing.space2),
                        decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
                        child: const MuLevelPath(
                          stops: [
                            MuLevelStop(
                              number: 1,
                              title: 'Level 1',
                              state: MuStopState.now,
                              meta: 'Where everyone starts',
                            ),
                            MuLevelStop(number: 2, title: 'Level 2', state: MuStopState.ahead),
                            MuLevelStop(number: 3, title: 'Level 3', state: MuStopState.ahead),
                            MuLevelStop(number: 4, title: 'Level 4', state: MuStopState.ahead),
                            MuLevelStop(number: 5, title: 'Level 5', state: MuStopState.ahead),
                            MuLevelStop(number: 6, title: 'Level 6', state: MuStopState.ahead),
                            MuLevelStop(
                              number: 7,
                              title: 'Level 7',
                              state: MuStopState.ahead,
                              meta: 'Karma from real work takes you here',
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: MuSpacing.space10),
                      const _DiscordCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(left: 0, right: 0, bottom: 0, child: _JoinDock(members: stats.members)),
        ],
      ),
    );
  }

  static String _dayOf(GuestEvent e) {
    final s = e.start;
    if (s == null) return e.place;
    final now = DateTime.now();
    final end = e.end ?? s;
    if (!now.isBefore(s) && !now.isAfter(end)) return 'on now';
    return '${s.day} ${_months[s.month - 1]}';
  }
}

/// The featured event as the page's one loud slab. "Live now" only while it
/// is actually running.
class _LiveSlab extends StatelessWidget {
  const _LiveSlab({required this.event, required this.onJoin});

  final GuestEvent event;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final s = event.start;
    final now = DateTime.now();
    final live = s != null && !now.isBefore(s) && !now.isAfter(event.end ?? s);
    final when = s == null ? event.place : '${s.day} ${_months[s.month - 1]} · ${event.place}';
    return MuSlab(
      title: event.title,
      tone: MuSlabTone.night,
      seed: event.id,
      badge: MuPill(live ? '● Live now' : 'Featured', tone: MuPillTone.volt),
      body: event.interested > 0 ? '$when · ${muGrouped(event.interested)} interested' : when,
      footer: MuButton(
        label: 'Count me in',
        variant: MuButtonVariant.volt,
        size: MuButtonSize.small,
        onPressed: onJoin,
      ),
      onTap: onJoin,
    );
  }
}

class _DiscordCard extends ConsumerWidget {
  const _DiscordCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mu = context.mu;
    final c = mu.colors;
    return Container(
      padding: const EdgeInsets.all(MuSpacing.space5),
      decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('The community lives on Discord', style: mu.text.title3),
          const SizedBox(height: MuSpacing.space1),
          Text(
            'Tasks are posted there with their hashtag and reviewed by peers. Say hello before you start.',
            style: mu.text.body.copyWith(color: c.ink2),
          ),
          const SizedBox(height: MuSpacing.space4),
          MuButton(
            label: 'Join the server',
            icon: LucideIcons.messageCircle,
            variant: MuButtonVariant.outline,
            size: MuButtonSize.small,
            onPressed: () => unawaited(ref.read(openExternalProvider)(discordServerInvite)),
          ),
        ],
      ),
    );
  }
}

/// The glass Join dock pinned at the bottom.
class _JoinDock extends StatelessWidget {
  const _JoinDock({required this.members});

  final int? members;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    final c = mu.colors;
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: c.glass,
            border: Border(top: BorderSide(color: c.line)),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                MuSpacing.space5,
                MuSpacing.space3,
                MuSpacing.space4,
                MuSpacing.space3,
              ),
              child: Row(
                children: [
                  const ExcludeSemantics(
                    child: MuAvatarStack(names: ['Arjun R', 'Sneha N', 'Fathima R']),
                  ),
                  const SizedBox(width: MuSpacing.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Stay curious.', style: mu.text.bodyStrong.copyWith(height: 1.2)),
                        Text('Grow every day.', style: mu.text.caption.copyWith(color: c.ink2)),
                      ],
                    ),
                  ),
                  MuButton(
                    label: 'Join μLearn',
                    size: MuButtonSize.small,
                    onPressed: () => context.push(RoutePaths.registerBasicInfo),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
