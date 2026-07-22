import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_chip.dart';
import 'package:mulearn_app/core/widgets/mu_gradient_header.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/leaderboard_controller.dart';
import 'package:mulearn_app/features/leaderboard/presentation/widgets/leaderboard_list_tile.dart';
import 'package:mulearn_app/features/leaderboard/presentation/widgets/leaderboard_podium.dart';

/// Student + college leaderboards with an all-time/this-month toggle —
/// immersive gradient header, top-3 podium, then a ranked list.
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  bool _monthly = false;
  bool _students = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: MuGradientHeader(
              title: 'Leaderboard',
              bottom: Row(
                children: [
                  MuFilterChip(
                    label: 'Students',
                    selected: _students,
                    onTap: () => setState(() => _students = true),
                  ),
                  const SizedBox(width: MuSpace.s),
                  MuFilterChip(
                    label: 'Colleges',
                    selected: !_students,
                    onTap: () => setState(() => _students = false),
                  ),
                  const Spacer(),
                  MuFilterChip(
                    label: _monthly ? 'This month' : 'All time',
                    selected: true,
                    onTap: () => setState(() => _monthly = !_monthly),
                  ),
                ],
              ),
            ),
          ),
          if (_students)
            _StudentLeaderboardSliver(monthly: _monthly)
          else
            _CollegeLeaderboardSliver(monthly: _monthly),
        ],
      ),
    );
  }
}

class _StudentLeaderboardSliver extends ConsumerWidget {
  const _StudentLeaderboardSliver({required this.monthly});

  final bool monthly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesState = ref.watch(studentLeaderboardProvider(monthly: monthly));

    return entriesState.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => SliverFillRemaining(
        child: ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(studentLeaderboardProvider(monthly: monthly)),
        ),
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return const SliverFillRemaining(child: Center(child: Text('No students yet.')));
        }
        final podium = entries
            .take(3)
            .map((e) => LeaderboardPodiumEntry(
                  name: e.fullName,
                  karma: e.totalKarma,
                  avatarUrl: e.profilePic,
                ))
            .toList();
        final rest = entries.skip(3).toList();
        return SliverList.list(
          children: [
            LeaderboardPodium(top3: podium),
            const SizedBox(height: MuSpace.m),
            for (var i = 0; i < rest.length; i++)
              LeaderboardListTile(
                rank: i + 4,
                title: rest[i].fullName,
                subtitle: rest[i].institution,
                karma: rest[i].totalKarma,
                avatarUrl: rest[i].profilePic,
              ),
            const SizedBox(height: MuSpace.navClearance),
          ],
        );
      },
    );
  }
}

class _CollegeLeaderboardSliver extends ConsumerWidget {
  const _CollegeLeaderboardSliver({required this.monthly});

  final bool monthly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesState = ref.watch(collegeLeaderboardProvider(monthly: monthly));

    return entriesState.when(
      loading: () => const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => SliverFillRemaining(
        child: ErrorRetryView(
          error: error,
          onRetry: () => ref.invalidate(collegeLeaderboardProvider(monthly: monthly)),
        ),
      ),
      data: (entries) {
        if (entries.isEmpty) {
          return const SliverFillRemaining(child: Center(child: Text('No colleges yet.')));
        }
        final podium = entries
            .take(3)
            .map((e) => LeaderboardPodiumEntry(name: e.title, karma: e.totalKarma))
            .toList();
        final rest = entries.skip(3).toList();
        return SliverList.list(
          children: [
            LeaderboardPodium(top3: podium),
            const SizedBox(height: MuSpace.m),
            for (var i = 0; i < rest.length; i++)
              LeaderboardListTile(
                rank: i + 4,
                title: rest[i].title,
                subtitle: '${rest[i].totalStudents} students',
                karma: rest[i].totalKarma,
              ),
            const SizedBox(height: MuSpace.navClearance),
          ],
        );
      },
    );
  }
}
