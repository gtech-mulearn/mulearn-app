import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_progress_bars.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/domain/level_status.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';

/// The 7-level progression path as its own top-level tab (promoted from
/// Profile's "Mu Voyage" tab, which stays and links here via "See the map").
/// Reuses `userLevelsProvider`/`UserLevel`/`LevelTask` from this same feature
/// — no new repository call (rules.md §2: same feature, not a cross-feature
/// import). DESIGN_SPEC.md §2 "06 — Level journey", adapted: the mock's
/// hardcoded "level 6 of 7" is replaced with a status derived from the real
/// task-completion data — "current" is the first level with an incomplete
/// task, everything before it "cleared", everything after "locked".
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsState = ref.watch(userLevelsProvider);
    // The user's own level decides where they are (spec §13).
    final profileState = ref.watch(profileControllerProvider);
    final levels = levelsState.value;
    final profile = profileState.value;

    final Widget body;
    if (levelsState.hasError && levels == null) {
      body = ErrorRetryView(
        error: levelsState.error!,
        onRetry: () => ref.invalidate(userLevelsProvider),
      );
    } else if (profileState.hasError && profile == null) {
      body = ErrorRetryView(
        error: profileState.error!,
        onRetry: () => ref.read(profileControllerProvider.notifier).refresh(),
      );
    } else if (levels == null || profile == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = _JourneyBody(levels: levels, userLevel: profile.level);
    }

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(child: body),
    );
  }
}

class _JourneyBody extends StatelessWidget {
  _JourneyBody({required List<UserLevel> levels, required this.userLevel})
    : levels = [...levels]
        ..sort((a, b) => levelNumber(a.name).compareTo(levelNumber(b.name)));

  final List<UserLevel> levels;

  /// The user's level from user-profile, e.g. "lvl1".
  final String? userLevel;

  @override
  Widget build(BuildContext context) {
    if (levels.isEmpty) {
      return Center(child: Text('No levels yet.', style: MuType.body));
    }

    final statuses = levelStatuses(levels, currentLevel: userLevel);
    var currentIndex = statuses.indexOf(LevelStatus.current);
    // Beyond the last listed level: everything is cleared; show the top one.
    if (currentIndex == -1) currentIndex = levels.length - 1;

    final currentLevel = levels[currentIndex];
    final remaining = currentLevel.tasks
        .where((t) => !t.completed)
        .fold<num>(0, (sum, t) => sum + t.karma);
    final totalTasks = currentLevel.tasks.length;
    final doneTasks = currentLevel.tasks.where((t) => t.completed).length;
    final ringValue = totalTasks == 0 ? 0.0 : doneTasks / totalTasks;
    final hasNext = currentIndex + 1 < levels.length;
    final nextLevel = hasNext ? levels[currentIndex + 1] : null;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        MuSpace.screenH,
        MuSpace.l,
        MuSpace.screenH,
        MuSpace.navClearance,
      ),
      children: [
        Text('Your journey', style: MuType.display.copyWith(fontSize: 28)),
        const SizedBox(height: MuSpace.xs),
        Text(
          'Every level unlocks harder work — track your climb here.',
          style: MuType.body.copyWith(color: MuColors.inkSecondary),
        ),
        const SizedBox(height: MuSpace.xl),
        _JourneyHeaderCard(
          levelNumber: levelNumber(currentLevel.name),
          levelName: levelLabel(currentLevel.name),
          hasTasks: totalTasks > 0,
          ringValue: ringValue,
          remaining: remaining,
          nextLevel: nextLevel,
        ),
        const SizedBox(height: MuSpace.xxl),
        for (var i = 0; i < levels.length; i++)
          _LevelCard(index: i, level: levels[i], status: statuses[i]),
      ],
    );
  }
}

class _JourneyHeaderCard extends StatelessWidget {
  const _JourneyHeaderCard({
    required this.levelNumber,
    required this.levelName,
    required this.ringValue,
    required this.remaining,
    required this.nextLevel,
    required this.hasTasks,
  });

  final int levelNumber;
  final String levelName;
  final double ringValue;
  final num remaining;
  final UserLevel? nextLevel;
  final bool hasTasks;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(MuSpace.xl),
      decoration: BoxDecoration(
        color: MuColors.ink,
        borderRadius: BorderRadius.circular(MuRadius.hero),
        boxShadow: MuShadow.hero,
      ),
      child: Row(
        children: [
          MuProgressRing(
            value: ringValue,
            size: 72,
            strokeWidth: 6,
            trackColor: MuColors.onBrand.withValues(alpha: 0.14),
            child: Text(
              '$levelNumber',
              style: MuType.stat.copyWith(
                color: MuColors.surface,
                fontSize: 26,
              ),
            ),
          ),
          const SizedBox(width: MuSpace.l),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  levelName,
                  style: MuType.title.copyWith(color: MuColors.surface),
                ),
                const SizedBox(height: MuSpace.xs),
                Text(
                  !hasTasks
                      ? 'No tasks in this level yet'
                      : nextLevel == null
                      ? "You've cleared every level so far."
                      : '$remaining more karma unlocks ${levelLabel(nextLevel!.name)}',
                  style: MuType.caption.copyWith(
                    color: MuColors.onBrand.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.index,
    required this.level,
    required this.status,
  });

  final int index;
  final UserLevel level;
  final LevelStatus status;

  @override
  Widget build(BuildContext context) {
    final isEven = index.isEven;
    final doneTasks = level.tasks.where((t) => t.completed).length;

    final (bg, fg) = switch (status) {
      LevelStatus.current => (MuColors.ink, MuColors.surface),
      LevelStatus.cleared => (MuColors.surface, MuColors.ink),
      LevelStatus.locked => (MuColors.hairline, MuColors.inkFaint),
    };

    final (pillBg, pillFg, pillLabel) = switch (status) {
      LevelStatus.current => (
        MuColors.karmaAccentTint,
        MuColors.karmaAccent,
        'YOU ARE HERE',
      ),
      LevelStatus.cleared => (MuColors.successBg, MuColors.success, 'CLEARED'),
      LevelStatus.locked => (MuColors.hairline, MuColors.inkFaint, 'LOCKED'),
    };

    return Padding(
      padding: EdgeInsets.only(
        bottom: MuSpace.l,
        left: isEven ? 0 : 24,
        right: isEven ? 24 : 0,
      ),
      child: Container(
        padding: const EdgeInsets.all(MuSpace.l),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(MuRadius.card),
          boxShadow: status == LevelStatus.current
              ? MuShadow.hero
              : MuShadow.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: status == LevelStatus.current
                        ? MuColors.onBrand.withValues(alpha: 0.12)
                        : MuColors.primaryTint,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${levelNumber(level.name)}',
                    style: MuType.statSmall.copyWith(
                      color: status == LevelStatus.locked
                          ? MuColors.inkFaint
                          : MuColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: MuSpace.m),
                Expanded(
                  child: Text(
                    levelLabel(level.name),
                    style: MuType.title.copyWith(color: fg),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: pillBg,
                    borderRadius: BorderRadius.circular(MuRadius.chip),
                  ),
                  child: Text(
                    pillLabel,
                    style: MuType.tag.copyWith(color: pillFg),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MuSpace.m),
            Row(
              children: [
                Icon(
                  LucideIcons.zap,
                  size: 15,
                  color: status == LevelStatus.locked
                      ? MuColors.inkFaint
                      : MuColors.karmaAccent,
                ),
                const SizedBox(width: 4),
                Text(
                  '${level.karma} karma',
                  style: MuType.caption.copyWith(
                    color: status == LevelStatus.current
                        ? MuColors.onBrand.withValues(alpha: 0.7)
                        : MuColors.inkSecondary,
                  ),
                ),
                const SizedBox(width: MuSpace.m),
                Flexible(
                  child: Text(
                    level.tasks.isEmpty
                        ? 'No tasks yet'
                        : '$doneTasks/${level.tasks.length} tasks',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: MuType.caption.copyWith(
                      color: status == LevelStatus.current
                          ? MuColors.onBrand.withValues(alpha: 0.7)
                          : MuColors.inkSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
