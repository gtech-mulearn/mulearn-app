import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_gradient_header.dart';
import 'package:mulearn_app/core/widgets/mu_section_header.dart';
import 'package:mulearn_app/core/widgets/mu_skeleton.dart';
import 'package:mulearn_app/core/widgets/mu_stat_block.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/create_circle_card.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/featured_events_list.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/home_circle_card.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/home_interest_groups_list.dart';
import 'package:mulearn_app/features/dashboard/presentation/widgets/top_performer_card.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/leaderboard_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

/// Home dashboard — the landing screen after sign-in. Immersive gradient
/// header, karma/level/rank summary, top performers, upcoming events, the
/// user's circles, and an interest-group directory preview.
///
/// Shows two "Top Learner"/"Top College" rows back to back, both wrapped in
/// [TopPerformerCard] for a consistent look but genuinely different real
/// data: the first pulls `dashboard/profile/karma-feed/`'s built-in
/// top-user/top-college highlight, the second pulls the #1 entry from the
/// full `leaderboard/students|college/` all-time leaderboard.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refreshAll(WidgetRef ref) => Future.wait([
        ref.read(myProgressSummaryControllerProvider.notifier).refresh(),
        ref.read(karmaFeedControllerProvider.notifier).refresh(),
        ref.read(featuredEventsControllerProvider.notifier).refresh(),
      ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summaryState = ref.watch(myProgressSummaryControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: RefreshIndicator(
        onRefresh: () => _refreshAll(ref),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(
              child: summaryState.when(
                loading: () => MuGradientHeader(
                  title: 'Hey there',
                  trailing: _headerActions(context),
                  showDecoration: true,
                  light: true,
                ),
                error: (error, _) => MuGradientHeader(
                  title: 'Hey there',
                  trailing: _headerActions(context),
                  showDecoration: true,
                  light: true,
                ),
                data: (summary) => MuGradientHeader(
                  title: 'Hey, ${summary.fullName.split(' ').first} 👋',
                  subtitle: 'Keep learning, keep building.',
                  avatarUrl: summary.profilePicUrl,
                  avatarName: summary.fullName,
                  avatarSize: 72,
                  onAvatarTap: () => context.push(RoutePaths.profile),
                  trailing: _headerActions(context),
                  showDecoration: true,
                  light: true,
                ),
              ),
            ),
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
                    loading: () => const MuSkeleton(height: 120, radius: 28),
                    error: (error, _) => ErrorRetryView(
                      error: error,
                      onRetry: () => ref
                          .read(myProgressSummaryControllerProvider.notifier)
                          .refresh(),
                    ),
                    data: (summary) => MuCard(
                      child: Row(
                        children: [
                          Expanded(
                            child: _StatItem(
                              icon: LucideIcons.award,
                              tint: MuColors.statKarmaTint,
                              accent: MuColors.statKarmaAccent,
                              label: 'Karma',
                              value: '${summary.karma}',
                            ),
                          ),
                          _statDivider(),
                          Expanded(
                            child: _StatItem(
                              icon: LucideIcons.barChart2,
                              tint: MuColors.statLevelTint,
                              accent: MuColors.statLevelAccent,
                              label: 'Level',
                              value: summary.level ?? '—',
                            ),
                          ),
                          if (summary.rank != null) ...[
                            _statDivider(),
                            Expanded(
                              child: _StatItem(
                                icon: LucideIcons.trophy,
                                tint: MuColors.statRankTint,
                                accent: MuColors.rankGold,
                                label: 'Rank',
                                value: '#${summary.rank}',
                                pill: summary.percentile != null
                                    ? 'Top ${summary.percentile!.round()}%'
                                    : null,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: MuSpace.l),
                  Consumer(
                    builder: (context, ref, _) {
                      final karmaFeedState = ref.watch(karmaFeedControllerProvider);
                      return karmaFeedState.when(
                        loading: () => const MuSkeleton(height: 108),
                        error: (error, _) => const SizedBox.shrink(),
                        data: (karmaFeed) {
                          if (karmaFeed.topUser == null && karmaFeed.topCollege == null) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(bottom: MuSpace.m),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (karmaFeed.topUser case final topUser?)
                                  Expanded(
                                    child: TopPerformerCard(
                                      icon: LucideIcons.trophy,
                                      tint: MuColors.statLevelTint,
                                      accent: MuColors.statLevelAccent,
                                      eyebrow: 'Top learner',
                                      name: topUser.fullName,
                                      karma: topUser.karma.toInt(),
                                      onTap: () => context.push(RoutePaths.leaderboard),
                                    ),
                                  ),
                                if (karmaFeed.topUser != null && karmaFeed.topCollege != null)
                                  const SizedBox(width: MuSpace.m),
                                if (karmaFeed.topCollege case final topCollege?)
                                  Expanded(
                                    child: TopPerformerCard(
                                      icon: LucideIcons.building2,
                                      tint: MuColors.primaryTint,
                                      accent: MuColors.primary,
                                      eyebrow: 'Top college',
                                      name: topCollege.name,
                                      karma: topCollege.karma.toInt(),
                                      onTap: () => context.push(RoutePaths.leaderboard),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, _) {
                            final state =
                                ref.watch(studentLeaderboardProvider(monthly: false));
                            return state.when(
                              loading: () => const MuSkeleton(height: 108),
                              error: (error, _) => const SizedBox.shrink(),
                              data: (entries) {
                                if (entries.isEmpty) return const SizedBox.shrink();
                                final top = entries.first;
                                return TopPerformerCard(
                                  icon: LucideIcons.crown,
                                  tint: MuColors.statKarmaTint,
                                  accent: MuColors.statKarmaAccent,
                                  eyebrow: 'Top learner',
                                  name: top.fullName,
                                  karma: top.totalKarma.toInt(),
                                  avatarUrl: top.profilePic,
                                  onTap: () => context.push(RoutePaths.leaderboard),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: MuSpace.m),
                      Expanded(
                        child: Consumer(
                          builder: (context, ref, _) {
                            final state =
                                ref.watch(collegeLeaderboardProvider(monthly: false));
                            return state.when(
                              loading: () => const MuSkeleton(height: 108),
                              error: (error, _) => const SizedBox.shrink(),
                              data: (entries) {
                                if (entries.isEmpty) return const SizedBox.shrink();
                                final top = entries.first;
                                return TopPerformerCard(
                                  icon: LucideIcons.building2,
                                  tint: MuColors.statRankTint,
                                  accent: MuColors.rankGold,
                                  eyebrow: 'Top college',
                                  name: top.title,
                                  karma: top.totalKarma.toInt(),
                                  onTap: () => context.push(RoutePaths.leaderboard),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MuSpace.xxl),
                  MuSectionHeader(
                    title: 'Upcoming events',
                    onViewAll: () => context.push(RoutePaths.events),
                  ),
                  const SizedBox(height: MuSpace.m),
                  Consumer(
                    builder: (context, ref, _) {
                      final eventsState = ref.watch(featuredEventsControllerProvider);
                      return eventsState.when(
                        loading: () => const SizedBox(
                          height: 168,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        error: (error, _) => Text(ApiException.messageFor(error)),
                        data: (events) => FeaturedEventsList(events: events),
                      );
                    },
                  ),
                  const SizedBox(height: MuSpace.xxl),
                  MuSectionHeader(
                    title: 'Your circles',
                    onViewAll: () => context.push(RoutePaths.learningCircles),
                  ),
                  const SizedBox(height: MuSpace.m),
                  Consumer(
                    builder: (context, ref, _) {
                      final circlesState = ref.watch(myCirclesProvider);
                      final circles = circlesState.value ?? const [];
                      return SizedBox(
                        height: 168,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          itemCount: circles.length + 1,
                          separatorBuilder: (_, __) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return CreateCircleCard(
                                onTap: () =>
                                    context.push(RoutePaths.createLearningCircle),
                              );
                            }
                            final circle = circles[index - 1];
                            return HomeCircleCard(
                              circle: circle,
                              onTap: () => context
                                  .push(RoutePaths.learningCircleDetailPath(circle.id)),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Consumer(
                    builder: (context, ref, _) {
                      final catalogState = ref.watch(interestGroupsCatalogProvider);
                      final myIds = ref.watch(myInterestGroupIdsProvider).value ?? const [];
                      return catalogState.when(
                        loading: () => const SizedBox.shrink(),
                        error: (error, _) => const SizedBox.shrink(),
                        data: (groups) {
                          if (groups.isEmpty) return const SizedBox.shrink();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: MuSpace.xxl),
                              MuSectionHeader(
                                title: 'Interest groups',
                                onViewAll: () => context.push(RoutePaths.interestGroups),
                              ),
                              const SizedBox(height: MuSpace.m),
                              HomeInterestGroupsList(
                                groups: groups,
                                joinedIds: myIds.toSet(),
                                onTap: (id) => context
                                    .push(RoutePaths.interestGroupDetailPath(id)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statDivider() => Container(height: 40, width: 1, color: MuColors.divider);

  List<Widget> _headerActions(BuildContext context) => [
        _HeaderActionButton(
          icon: LucideIcons.compass,
          onPressed: () => context.push(RoutePaths.interestGroups),
        ),
        const SizedBox(width: MuSpace.s),
        _HeaderActionButton(
          icon: LucideIcons.calendarDays,
          onPressed: () => context.push(RoutePaths.events),
        ),
        const SizedBox(width: MuSpace.s),
        _HeaderActionButton(
          icon: LucideIcons.search,
          onPressed: () => context.push(RoutePaths.search),
        ),
      ];
}

/// White rounded-square icon button for Home's header — a slightly softer,
/// more "card-like" affordance than [MuIconButton]'s glass circle, matching
/// this screen's reference design without changing the shared component's
/// look on Profile/Leaderboard.
class _HeaderActionButton extends StatelessWidget {
  const _HeaderActionButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 40,
          width: 40,
          child: Icon(icon, size: 18, color: MuColors.primary),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.icon,
    required this.tint,
    required this.accent,
    required this.label,
    required this.value,
    this.pill,
  });

  final IconData icon;
  final Color tint;
  final Color accent;
  final String label;
  final String value;
  final String? pill;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(color: tint, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: accent),
        ),
        const SizedBox(height: MuSpace.s),
        MuStatBlock(label: label, value: value),
        if (pill != null) ...[
          const SizedBox(height: MuSpace.xs),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: MuSpace.s, vertical: 2),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(pill!, style: MuType.chip.copyWith(color: accent, fontSize: 11)),
          ),
        ],
      ],
    );
  }
}
