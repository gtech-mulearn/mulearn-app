import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/auth/current_user_rank_summary.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/mu_haptics.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_card.dart';
import 'package:mulearn_app/core/widgets/mu_gradient_header.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/leaderboard_controller.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/rank_popup_gate.dart';
import 'package:mulearn_app/features/leaderboard/presentation/widgets/leaderboard_list_tile.dart';
import 'package:mulearn_app/features/leaderboard/presentation/widgets/leaderboard_podium.dart';
import 'package:mulearn_app/features/leaderboard/presentation/widgets/rank_summary_popup.dart';

/// The monthly college-leaderboard endpoint doesn't return a `title` at
/// all (confirmed live — see `CollegeLeaderboardEntryDto`'s doc comment),
/// so fall back to the college's short `code` (e.g. "MBT") rather than a
/// generic placeholder when the full name isn't available.
String _collegeDisplayName(CollegeLeaderboardEntry entry) =>
    entry.title ?? entry.code ?? 'Unknown college';

/// Student + college leaderboards with an all-time/this-month toggle —
/// DESIGN_SPEC.md §2 "09 — Leaderboard", shipped with **2 segments**
/// (Learners, Colleges) rather than the mock's 3 — there is no
/// interest-group leaderboard endpoint, so that segment is omitted rather
/// than shown empty or faked (per the approved plan).
class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  bool _monthly = false;
  bool _students = true;

  @override
  void initState() {
    super.initState();
    // Once-a-day "your rank" celebratory popup — gated by RankPopupGate so
    // it shows at most once per calendar day (per the user's explicit
    // request), not on every visit to this tab.
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShowRankPopup());
  }

  Future<void> _maybeShowRankPopup() async {
    final gate = ref.read(rankPopupGateProvider);
    if (!await gate.shouldShowToday()) return;
    if (!mounted) return;

    try {
      final summary = await ref.read(currentUserRankSummaryProvider.future);
      await gate.markShownToday();
      if (!mounted) return;
      await RankSummaryPopup.show(
        context,
        rank: summary.rank,
        karma: summary.karma,
        percentile: summary.percentile,
      );
    } on Exception {
      // Best-effort — a failed fetch just means no popup today, never worth
      // surfacing an error for a purely celebratory extra.
    }
  }

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
              subtitle: 'See where you rank against learners and colleges.',
              bottom: Row(
                children: [
                  _SegmentedControl(
                    students: _students,
                    onChanged: (value) {
                      if (value == _students) return;
                      MuHaptics.selection();
                      setState(() => _students = value);
                    },
                  ),
                  const Spacer(),
                  _MonthlyToggle(
                    monthly: _monthly,
                    onTap: () {
                      MuHaptics.selection();
                      setState(() => _monthly = !_monthly);
                    },
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

/// Glass pill segmented control (Students / Colleges) sitting on the
/// gradient header — the design's 2-segment version (Groups omitted, no
/// backing endpoint).
class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({required this.students, required this.onChanged});

  final bool students;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(MuRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _SegmentItem(label: 'Students', selected: students, onTap: () => onChanged(true)),
          _SegmentItem(label: 'Colleges', selected: !students, onTap: () => onChanged(false)),
        ],
      ),
    );
  }
}

class _SegmentItem extends StatelessWidget {
  const _SegmentItem({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? MuColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(MuRadius.chip - 4),
        ),
        child: Text(
          label,
          style: MuType.chip.copyWith(
            color: selected ? MuColors.ink : MuColors.surface.withValues(alpha: 0.8),
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

/// Small secondary toggle for the real monthly/all-time functionality — kept
/// (per the plan) but styled as a lighter-weight control than the main
/// Students/Colleges segmented control, since the mock itself doesn't show
/// this control at all.
class _MonthlyToggle extends StatelessWidget {
  const _MonthlyToggle({required this.monthly, required this.onTap});

  final bool monthly;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(MuRadius.chip),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.calendarClock,
              size: 13,
              color: MuColors.surface.withValues(alpha: 0.85),
            ),
            const SizedBox(width: 5),
            Text(
              monthly ? 'This month' : 'All time',
              style: MuType.chip.copyWith(color: MuColors.surface.withValues(alpha: 0.9), fontSize: 12),
            ),
          ],
        ),
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
            if (rest.isNotEmpty) ...[
              const SizedBox(height: MuSpace.s),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                child: MuCard(
                  padding: const EdgeInsets.symmetric(horizontal: MuSpace.l),
                  child: Column(
                    children: [
                      for (var i = 0; i < rest.length; i++)
                        LeaderboardListTile(
                          rank: i + 4,
                          title: rest[i].fullName,
                          subtitle: rest[i].institution,
                          karma: rest[i].totalKarma,
                          avatarUrl: rest[i].profilePic,
                          showDivider: i < rest.length - 1,
                        ),
                    ],
                  ),
                ),
              ),
            ],
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
            .map((e) => LeaderboardPodiumEntry(
                  name: _collegeDisplayName(e),
                  karma: e.totalKarma,
                ))
            .toList();
        final rest = entries.skip(3).toList();
        return SliverList.list(
          children: [
            LeaderboardPodium(top3: podium),
            if (rest.isNotEmpty) ...[
              const SizedBox(height: MuSpace.s),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: MuSpace.screenH),
                child: MuCard(
                  padding: const EdgeInsets.symmetric(horizontal: MuSpace.l),
                  child: Column(
                    children: [
                      for (var i = 0; i < rest.length; i++)
                        LeaderboardListTile(
                          rank: i + 4,
                          title: _collegeDisplayName(rest[i]),
                          subtitle: '${rest[i].totalStudents} students',
                          karma: rest[i].totalKarma,
                          showDivider: i < rest.length - 1,
                        ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: MuSpace.navClearance),
          ],
        );
      },
    );
  }
}
