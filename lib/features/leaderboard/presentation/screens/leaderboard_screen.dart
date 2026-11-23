import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/auth/current_user_college.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/leaderboard/leaderboard_providers.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/campus_name.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';

enum _Board { students, colleges }

/// Students and colleges, all time or this month (artifact: Leaderboard,
/// Screen patterns → Leaderboards): the top three on podium blocks, everyone
/// else as rows with a karma bar scaled to #1.
class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  bool _monthly = false;
  _Board _board = _Board.students;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    return Scaffold(
      backgroundColor: mu.colors.chalk,
      body: SafeArea(
        bottom: false,
        child: MuRefresh(
          onRefresh: () => _board == _Board.students
              ? ref.refresh(
                  studentLeaderboardProvider(monthly: _monthly).future,
                )
              : ref.refresh(
                  collegeLeaderboardProvider(monthly: _monthly).future,
                ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  MuSpacing.space4,
                  MuSpacing.space5,
                  0,
                ),
                sliver: SliverList.list(
                  children: [
                    Semantics(
                      header: true,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Who's ",
                              style: mu.text.displayLight.copyWith(
                                fontSize: 34,
                              ),
                            ),
                            TextSpan(
                              text: 'leading',
                              style: mu.text.display.copyWith(fontSize: 34),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: MuSpacing.space4),
                    MuSegmented<_Board>(
                      values: _Board.values,
                      selected: _board,
                      label: (b) =>
                          b == _Board.students ? 'Students' : 'Colleges',
                      onChanged: (b) => setState(() => _board = b),
                    ),
                    const SizedBox(height: MuSpacing.space2),
                    Row(
                      children: [
                        MuFilterChip(
                          label: 'All time',
                          selected: !_monthly,
                          onTap: () => setState(() => _monthly = false),
                        ),
                        const SizedBox(width: MuSpacing.space2),
                        MuFilterChip(
                          label: 'This month',
                          selected: _monthly,
                          onTap: () => setState(() => _monthly = true),
                        ),
                      ],
                    ),
                    const SizedBox(height: MuSpacing.space5),
                  ],
                ),
              ),
              if (_board == _Board.students)
                _StudentBoard(monthly: _monthly)
              else
                _CollegeBoard(monthly: _monthly),
            ],
          ),
        ),
      ),
    );
  }
}

/// Podium + rows for any board.
class _BoardView extends StatelessWidget {
  const _BoardView({required this.entries, this.open});

  final List<MuRankEntry> entries;

  /// Opens the entry at an index, or null when it can't open.
  final VoidCallback? Function(int index)? open;

  @override
  Widget build(BuildContext context) {
    final c = context.mu.colors;
    final hasPodium = entries.length >= 3;
    final rest = hasPodium ? entries.skip(3).toList() : entries;
    final offset = hasPodium ? 3 : 0;
    final max = entries.first.karma;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        MuSpacing.space5,
        0,
        MuSpacing.space5,
        MuSpacing.navClearance,
      ),
      child: Column(
        children: [
          if (hasPodium)
            MuPodium(
              top: entries.take(3).toList(),
              onOpen: (e) => open?.call(entries.indexOf(e))?.call(),
            ),
          if (rest.isNotEmpty) ...[
            const SizedBox(height: MuSpacing.space3),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: MuSpacing.space4,
                vertical: MuSpacing.space1,
              ),
              decoration: BoxDecoration(
                color: c.surface,
                borderRadius: BorderRadius.circular(MuRadii.card),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < rest.length; i++)
                    MuRankRow(
                      rank: i + offset + 1,
                      entry: rest[i],
                      maxKarma: max,
                      onTap: open?.call(i + offset),
                    ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StudentBoard extends ConsumerWidget {
  const _StudentBoard({required this.monthly});

  final bool monthly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(studentLeaderboardProvider(monthly: monthly))
        .when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => SliverFillRemaining(
            child: ErrorRetryView(
              error: error,
              onRetry: () =>
                  ref.invalidate(studentLeaderboardProvider(monthly: monthly)),
            ),
          ),
          data: (entries) {
            if (entries.isEmpty) {
              return const SliverToBoxAdapter(
                child: MuStateDisplay(
                  variant: MuStateVariant.noResults,
                  size: MuStateSize.sm,
                ),
              );
            }
            return SliverToBoxAdapter(
              child: _BoardView(
                entries: [
                  for (final e in entries)
                    MuRankEntry(
                      name: e.fullName,
                      karma: e.totalKarma.toInt(),
                      subtitle: e.institution,
                      photoUrl: e.profilePic,
                    ),
                ],
                open: (i) {
                  final muid = entries[i].muid;
                  return muid == null
                      ? null
                      : () => context.push(RoutePaths.publicProfilePath(muid));
                },
              ),
            );
          },
        );
  }
}

class _CollegeBoard extends ConsumerWidget {
  const _CollegeBoard({required this.monthly});

  final bool monthly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(collegeLeaderboardProvider(monthly: monthly))
        .when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => SliverFillRemaining(
            child: ErrorRetryView(
              error: error,
              onRetry: () =>
                  ref.invalidate(collegeLeaderboardProvider(monthly: monthly)),
            ),
          ),
          data: (entries) {
            if (entries.isEmpty) {
              return const SliverToBoxAdapter(
                child: MuStateDisplay(
                  variant: MuStateVariant.noResults,
                  size: MuStateSize.sm,
                ),
              );
            }
            final mine = ref.watch(currentUserCollegeProvider).value?.id;
            String detail(int n) => monthly
                ? (n == 1
                      ? '1 active learner'
                      : '${muGrouped(n)} active learners')
                : (n == 1 ? '1 learner' : '${muGrouped(n)} learners');
            final ranks = [
              for (final e in entries)
                MuCampusRank(
                  name: campusDisplayName(title: e.title, code: e.code),
                  code: e.code,
                  karma: e.totalKarma.toInt(),
                  detail: detail(e.totalStudents),
                  isMine: e.id != null && e.id == mine,
                ),
            ];
            VoidCallback? open(int i) {
              final id = entries[i].id;
              return id == null
                  ? null
                  : () => context.push(RoutePaths.publicCampusPath(id));
            }

            final top = ranks.take(3).toList();
            return SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  MuSpacing.space5,
                  0,
                  MuSpacing.space5,
                  MuSpacing.navClearance,
                ),
                child: Column(
                  children: [
                    MuCampusPodium(
                      top: top,
                      // Cards open only when every one of them can.
                      onOpen: entries.take(3).every((e) => e.id != null)
                          ? (i) => open(i)?.call()
                          : null,
                    ),
                    if (ranks.length > 3) ...[
                      const SizedBox(height: MuSpacing.space3),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MuSpacing.space4,
                          vertical: MuSpacing.space1,
                        ),
                        decoration: BoxDecoration(
                          color: context.mu.colors.surface,
                          borderRadius: BorderRadius.circular(MuRadii.card),
                        ),
                        child: Column(
                          children: [
                            for (var i = 3; i < ranks.length; i++)
                              MuCampusRankRow(
                                rank: i + 1,
                                entry: ranks[i],
                                maxKarma: ranks.first.karma,
                                onTap: open(i),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        );
  }
}
