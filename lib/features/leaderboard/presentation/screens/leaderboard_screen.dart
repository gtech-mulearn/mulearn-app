import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/leaderboard_controller.dart';
import 'package:mulearn_app/features/leaderboard/presentation/widgets/leaderboard_list_tile.dart';

/// Student + college leaderboards with an all-time/this-month toggle —
/// mirrors the reference dashboard's leaderboard page.
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);
  bool _monthly = false;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Students'),
            Tab(text: 'Colleges'),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: false, label: Text('All time')),
                ButtonSegment(value: true, label: Text('This month')),
              ],
              selected: {_monthly},
              onSelectionChanged: (selection) =>
                  setState(() => _monthly = selection.first),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _StudentLeaderboardList(monthly: _monthly),
                _CollegeLeaderboardList(monthly: _monthly),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentLeaderboardList extends ConsumerWidget {
  const _StudentLeaderboardList({required this.monthly});

  final bool monthly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesState =
        ref.watch(studentLeaderboardProvider(monthly: monthly));

    return entriesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text(ApiException.messageFor(error))),
      data: (entries) {
        if (entries.isEmpty) {
          return const Center(child: Text('No students yet.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return LeaderboardListTile(
              rank: index + 1,
              title: entry.fullName,
              subtitle: entry.institution,
              karma: entry.totalKarma,
              avatarUrl: entry.profilePic,
            );
          },
        );
      },
    );
  }
}

class _CollegeLeaderboardList extends ConsumerWidget {
  const _CollegeLeaderboardList({required this.monthly});

  final bool monthly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesState =
        ref.watch(collegeLeaderboardProvider(monthly: monthly));

    return entriesState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text(ApiException.messageFor(error))),
      data: (entries) {
        if (entries.isEmpty) {
          return const Center(child: Text('No colleges yet.'));
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: entries.length,
          itemBuilder: (context, index) {
            final entry = entries[index];
            return LeaderboardListTile(
              rank: index + 1,
              title: entry.title,
              subtitle: '${entry.totalStudents} students',
              karma: entry.totalKarma,
            );
          },
        );
      },
    );
  }
}
