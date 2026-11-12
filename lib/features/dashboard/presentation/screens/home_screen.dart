import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_icon_button.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_skeleton.dart';
import 'package:mulearn_app/core/widgets/profile_avatar.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/featured_events_list.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/leaderboard_controller.dart';

/// Home dashboard — the landing screen after sign-in (DESIGN_SPEC.md §2 "03 —
/// Home"). Greeting header, a dark karma "hero" card, quick links into Tasks
/// and Learning circles, a real top-performers preview (reused from
/// `features/leaderboard`'s presentation layer — this file already reads
/// that feature directly, an established pattern predating this restyle, so
/// no new cross-feature import is introduced), and an upcoming-events strip.
///
/// Sections present in the original Claude Design mock but not backed by any
/// real field on [MyProgressSummary] are deliberately omitted rather than
/// faked — see the omissions noted inline below (streak widget, karma delta,
/// "resume a specific task" card, level-progress-to-next-level bar).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refreshAll(WidgetRef ref) => Future.wait([
        ref.read(myProgressSummaryControllerProvider.notifier).refresh(),
        ref.read(featuredEventsControllerProvider.notifier).refresh(),
      ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryState = ref.watch(myProgressSummaryControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () => _refreshAll(ref),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpace.screenH,
                  MuSpace.l,
                  MuSpace.screenH,
                  MuSpace.navClearance,
                ),
                sliver: SliverList.list(
                  children: [
                    summaryState.when(
                      loading: () => const _HomeHeader(),
                      error: (error, _) => const _HomeHeader(),
                      data: (summary) => _HomeHeader(summary: summary),
                    ),
                    const SizedBox(height: MuSpace.xxl),
                    summaryState.when(
                      loading: () => const MuSkeleton(height: 220, radius: MuRadius.hero),
                      error: (error, _) => ErrorRetryView(
                        error: error,
                        onRetry: () => ref
                            .read(myProgressSummaryControllerProvider.notifier)
                            .refresh(),
                      ),
                      data: (summary) => _KarmaHeroCard(summary: summary),
                    ),
                    const SizedBox(height: MuSpace.xxl),
                    Row(
                      children: [
                        Expanded(
                          child: _QuickLinkTile(
                            icon: LucideIcons.listTodo,
                            title: 'Find a task',
                            subtitle: "Browse what's open",
                            onTap: () => context.push(RoutePaths.tasks),
                          ),
                        ),
                        const SizedBox(width: MuSpace.m),
                        Expanded(
                          child: _QuickLinkTile(
                            icon: LucideIcons.users,
                            title: 'Learning circles',
                            subtitle: 'Learn with a group',
                            onTap: () => context.push(RoutePaths.learningCircles),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: MuSpace.xxl),
                    MuSectionHeader(
                      title: 'Top performers',
                      onViewAll: () => context.push(RoutePaths.leaderboard),
                    ),
                    const SizedBox(height: MuSpace.m),
                    Consumer(
                      builder: (context, ref, _) {
                        final state = ref.watch(studentLeaderboardProvider(monthly: false));
                        return state.when(
                          loading: () => const MuSkeleton(height: 168, radius: MuRadius.card),
                          error: (error, _) => const SizedBox.shrink(),
                          data: (entries) {
                            if (entries.isEmpty) return const SizedBox.shrink();
                            final top = entries.take(3).toList();
                            return MuCard(
                              padding: const EdgeInsets.symmetric(horizontal: MuSpace.l),
                              child: Column(
                                children: [
                                  for (var i = 0; i < top.length; i++)
                                    _MoverRow(
                                      rank: i + 1,
                                      name: top[i].fullName,
                                      meta: top[i].institution,
                                      karma: top[i].totalKarma.toInt(),
                                      avatarUrl: top[i].profilePic,
                                      showDivider: i != top.length - 1,
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: MuSpace.xxl),
                    MuSectionHeader(
                      title: 'Happening soon',
                      onViewAll: () => context.push(RoutePaths.events),
                    ),
                    const SizedBox(height: MuSpace.m),
                    Consumer(
                      builder: (context, ref, _) {
                        final eventsState = ref.watch(featuredEventsControllerProvider);
                        return eventsState.when(
                          loading: () => const SizedBox(
                            height: 196,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          error: (error, _) => const SizedBox.shrink(),
                          data: (events) => FeaturedEventsList(events: events.take(2).toList()),
                        );
                      },
                    ),
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

/// Formats an integer karma amount with thousands separators (e.g. `14919`
/// → `"14,919"`) without pulling in `intl` — not an existing dependency
/// (rules.md §9), so this stays a small hand-rolled helper.
String _formatKarma(int value) {
  final negative = value < 0;
  final digits = value.abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i != 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return negative ? '-$buffer' : buffer.toString();
}

/// `"Wednesday, 2 September"` — hand-rolled (no `intl` dependency, see
/// [_formatKarma]).
String _dateLine([DateTime? now]) {
  final date = now ?? DateTime.now();
  const weekdays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday', //
  ];
  const months = [
    'January', 'February', 'March', 'April', 'May', 'June', //
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  return '${weekdays[date.weekday - 1]}, ${date.day} ${months[date.month - 1]}';
}

/// Greeting row (DESIGN_SPEC.md §2 Home #1) — date line, "Hey, {name}", a
/// subtitle grounded in real karma/level (never the mock's fabricated "two
/// tasks away" copy), a notification bell (→ Notifications) and an avatar
/// (→ Profile). No unread-dot badge: there's no real unread-notifications
/// signal available to this screen yet, so it's left off rather than shown
/// in a fixed/fake state.
class _HomeHeader extends StatelessWidget {
  const _HomeHeader({this.summary});

  final MyProgressSummary? summary;

  @override
  Widget build(BuildContext context) {
    final s = summary;
    final name =
        (s != null && s.fullName.trim().isNotEmpty) ? s.fullName.trim().split(' ').first : 'there';
    final subtitle = s == null
        ? 'Keep learning, keep building.'
        : (s.level != null
            ? 'Level ${s.level} · ${_formatKarma(s.karma)} karma so far.'
            : '${_formatKarma(s.karma)} karma so far — keep going.');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_dateLine(), style: MuType.caption.copyWith(color: MuColors.inkTertiary)),
              const SizedBox(height: 4),
              Text('Hey, $name', style: MuType.display.copyWith(fontSize: 30)),
              const SizedBox(height: 4),
              Text(subtitle, style: MuType.body.copyWith(color: MuColors.inkSecondary)),
            ],
          ),
        ),
        const SizedBox(width: MuSpace.m),
        MuIconButton(
          icon: LucideIcons.bell,
          onPressed: () => context.push(RoutePaths.notifications),
        ),
        const SizedBox(width: MuSpace.s),
        GestureDetector(
          onTap: () => context.push(RoutePaths.profile),
          child: ProfileAvatar(url: s?.profilePicUrl, name: s?.fullName ?? '', size: 44),
        ),
      ],
    );
  }
}

/// Dark "hero" karma card (DESIGN_SPEC.md §2 Home #2 / §1 component styles)
/// — [MuColors.ink] surface, a soft purple radial glow blob, "TOTAL KARMA"
/// eyebrow + bolt icon, a real "Rank #X · Top Y%" pill when both fields are
/// present, the big karma number, and the level label. Tapping opens Journey.
///
/// Deliberately omitted vs. the mock, both for lack of backing data:
/// - The 7-day streak row — [MyProgressSummary] has no streak field.
/// - The "+250 today" karma delta — no delta field.
/// - The "{n} to next level" line and its progress bar — computing that
///   needs the real per-level karma thresholds, which live in the
///   `profile`/Journey feature's `UserLevel` data, not on this feature's own
///   minimal read model; reaching into `profile`'s domain layer to get them
///   would be a new cross-feature import this pass shouldn't introduce.
class _KarmaHeroCard extends StatelessWidget {
  const _KarmaHeroCard({required this.summary});

  final MyProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    final hasRank = summary.rank != null && summary.percentile != null;

    return GestureDetector(
      onTap: () => context.push(RoutePaths.journey),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MuRadius.hero),
          boxShadow: MuShadow.hero,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(MuRadius.hero),
          child: ColoredBox(
            color: MuColors.ink,
            child: Stack(
              children: [
                Positioned(
                  top: -70,
                  right: -50,
                  child: Container(
                    height: 240,
                    width: 240,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          MuColors.karmaAccent.withValues(alpha: 0.55),
                          MuColors.karmaAccent.withValues(alpha: 0),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(MuSpace.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(LucideIcons.zap, size: 16, color: MuColors.karmaAccent),
                          const SizedBox(width: 6),
                          Text(
                            'TOTAL KARMA',
                            style: MuType.eyebrow.copyWith(
                              color: Colors.white.withValues(alpha: 0.55),
                            ),
                          ),
                          const Spacer(),
                          if (hasRank)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: MuSpace.s,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(MuRadius.chip),
                              ),
                              child: Text(
                                'Rank #${summary.rank} · Top ${summary.percentile!.round()}%',
                                style: MuType.chip.copyWith(color: Colors.white, fontSize: 11),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: MuSpace.l),
                      Text(
                        _formatKarma(summary.karma),
                        style: MuType.stat.copyWith(fontSize: 50, color: Colors.white, height: 1),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'karma earned',
                        style: MuType.caption.copyWith(color: Colors.white.withValues(alpha: 0.5)),
                      ),
                      if (summary.level != null) ...[
                        const SizedBox(height: MuSpace.l),
                        Text(
                          'Level ${summary.level}',
                          style: MuType.bodyMed.copyWith(color: Colors.white),
                        ),
                      ],
                      const SizedBox(height: MuSpace.l),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'View your journey',
                            style: MuType.caption.copyWith(
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            LucideIcons.arrowRight,
                            size: 12,
                            color: Colors.white.withValues(alpha: 0.6),
                          ),
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

/// One of Home's two side-by-side quick-link tiles (DESIGN_SPEC.md §2 Home
/// #4). "Find a task" and "Learning circles" both point at real destinations
/// — there's no real "in-progress task" to resume (the mock's separate
/// "PICK UP WHERE YOU LEFT OFF" card), so rather than fabricate one or show
/// a second tile that duplicates "Find a task", that section is omitted
/// entirely and folded into this one.
class _QuickLinkTile extends StatelessWidget {
  const _QuickLinkTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MuCard(
      padding: const EdgeInsets.all(MuSpace.l),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: MuColors.primaryTint,
              borderRadius: BorderRadius.circular(MuRadius.inner),
            ),
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: MuColors.primary),
          ),
          const SizedBox(height: MuSpace.m),
          Text(title, style: MuType.bodyMed),
          const SizedBox(height: 2),
          Text(subtitle, style: MuType.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}

/// One row of the "Top performers" preview list — real data from
/// `features/leaderboard`'s all-time student leaderboard (top 3), the
/// nearest real equivalent to the mock's "THIS WEEK'S MOVERS" (there's no
/// weekly-scoped leaderboard endpoint, so the section is titled and framed
/// generically rather than claiming a "this week" scope the data can't back).
class _MoverRow extends StatelessWidget {
  const _MoverRow({
    required this.rank,
    required this.name,
    required this.meta,
    required this.karma,
    required this.showDivider,
    this.avatarUrl,
  });

  final int rank;
  final String name;
  final String meta;
  final int karma;
  final String? avatarUrl;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: MuSpace.m),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: MuColors.hairline))
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 18,
            child: Text(
              '$rank',
              style: MuType.caption.copyWith(color: MuColors.inkFaint),
            ),
          ),
          const SizedBox(width: MuSpace.s),
          ProfileAvatar(url: avatarUrl, name: name, size: 32),
          const SizedBox(width: MuSpace.m),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(name, style: MuType.bodyMed, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(meta, style: MuType.caption, maxLines: 1, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: MuSpace.s),
          Row(
            children: [
              const Icon(LucideIcons.zap, size: 12, color: MuColors.primary),
              const SizedBox(width: 4),
              Text(_formatKarma(karma), style: MuType.statSmall),
            ],
          ),
        ],
      ),
    );
  }
}
