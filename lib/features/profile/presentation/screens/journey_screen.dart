import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/theme/mu_radius.dart';
import 'package:mulearn_app/core/theme/mu_shadow.dart';
import 'package:mulearn_app/core/theme/mu_space.dart';
import 'package:mulearn_app/core/theme/mulearn_colors.dart';
import 'package:mulearn_app/core/theme/mulearn_typography.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/core/widgets/mu_progress_bars.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/domain/level_number.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';

enum _LevelStatus { cleared, current, locked }

/// The 7-level progression path as its own top-level tab (promoted from
/// Profile's "Mu Voyage" tab, which stays and links here via "See the map").
/// Reuses `userLevelsProvider`/`UserLevel`/`LevelTask` from this same feature
/// — no new repository call (rules.md §2: same feature, not a cross-feature
/// import). DESIGN_SPEC.md §2 "06 — Level journey", adapted.
///
/// The "current level" comes from [UserProfile.level] (the same real field
/// Profile's own header uses) — NOT derived from `get-user-levels`'s
/// per-task `completed` flags. That endpoint has no field marking which
/// level is current, and every level can carry an optional task nobody
/// completes (e.g. "Connect Qseverse Wallet" in level 1); guessing "current
/// = first level where not every task is done" meant a level with one
/// perpetually-incomplete optional task never counted as cleared, so the
/// screen got stuck showing level 1 regardless of the user's real level —
/// confirmed by a live report of exactly that.
class JourneyScreen extends ConsumerWidget {
  const JourneyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelsState = ref.watch(userLevelsProvider);
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      backgroundColor: MuColors.canvas,
      body: SafeArea(
        child: levelsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorRetryView(
            error: error,
            onRetry: () => ref.invalidate(userLevelsProvider),
          ),
          data: (levels) => profileState.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorRetryView(
              error: error,
              onRetry: () => ref.invalidate(profileControllerProvider),
            ),
            data: (profile) => _JourneyBody(
              levels: levels,
              currentLevelNumber: parseLevelNumber(profile.level),
            ),
          ),
        ),
      ),
    );
  }
}

class _JourneyBody extends StatefulWidget {
  const _JourneyBody({required this.levels, required this.currentLevelNumber});

  final List<UserLevel> levels;

  /// 1-indexed, straight from [UserProfile.level] — real, not guessed.
  final int currentLevelNumber;

  @override
  State<_JourneyBody> createState() => _JourneyBodyState();
}

/// Plays the climb once per screen visit: level cards reveal in sequence
/// from level 1 up to the user's real current level (see the class doc on
/// [JourneyScreen] for why that number comes from [UserProfile.level]),
/// landing with a bouncier "arrival" pop on the current card rather than
/// everything just snapping into place at once.
class _JourneyBodyState extends State<_JourneyBody> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Longer for a longer climb — capped so a 7-level climb doesn't drag.
    final duration = 450 + widget.levels.length * 130;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: duration.clamp(450, 1400)),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// The reveal `Interval` for level [i] of [count] — cards climb in
  /// sequence, each one starting before the previous finishes so the climb
  /// reads as continuous rather than a strict one-at-a-time queue.
  Interval _intervalFor(int i, int count) {
    final step = 1 / count;
    final start = (i * step * 0.7).clamp(0.0, 1.0);
    final end = (start + step * 1.6).clamp(0.0, 1.0);
    return Interval(start, end, curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final levels = widget.levels;
    if (levels.isEmpty) {
      return Center(
        child: Text('No levels yet.', style: MuType.body),
      );
    }

    final currentIndex = (widget.currentLevelNumber - 1).clamp(0, levels.length - 1);

    final currentLevel = levels[currentIndex];
    final remaining = currentLevel.tasks
        .where((t) => !t.completed)
        .fold<num>(0, (sum, t) => sum + t.karma);
    final totalTasks = currentLevel.tasks.length;
    final doneTasks = currentLevel.tasks.where((t) => t.completed).length;
    final ringValue = totalTasks == 0 ? 1.0 : doneTasks / totalTasks;
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
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: ringValue),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeOutCubic,
          builder: (context, animatedRingValue, child) => _JourneyHeaderCard(
            levelNumber: currentIndex + 1,
            levelName: currentLevel.name,
            ringValue: animatedRingValue,
            remaining: remaining,
            nextLevel: nextLevel,
          ),
        ),
        const SizedBox(height: MuSpace.xxl),
        for (var i = 0; i < levels.length; i++)
          _ClimbingLevelCard(
            animation: CurvedAnimation(
              parent: _controller,
              curve: _intervalFor(i, levels.length),
            ),
            isCurrent: i == currentIndex,
            child: _LevelCard(
              index: i,
              level: levels[i],
              status: i < currentIndex
                  ? _LevelStatus.cleared
                  : i == currentIndex
                      ? _LevelStatus.current
                      : _LevelStatus.locked,
            ),
          ),
      ],
    );
  }
}

/// One card's entrance in the climb: fades and slides up into place, then —
/// only for the current level, the one the user just "arrived" at — a
/// bouncier overshoot-and-settle scale on top, so it reads as a small
/// arrival moment rather than just another step.
class _ClimbingLevelCard extends StatelessWidget {
  const _ClimbingLevelCard({
    required this.animation,
    required this.isCurrent,
    required this.child,
  });

  final Animation<double> animation;
  final bool isCurrent;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final arrival = isCurrent
        ? CurvedAnimation(parent: animation, curve: Curves.elasticOut)
        : animation;

    return AnimatedBuilder(
      animation: Listenable.merge([animation, arrival]),
      builder: (context, _) {
        return Opacity(
          opacity: animation.value.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, (1 - animation.value) * 24),
            child: Transform.scale(
              // elasticOut overshoots past 1.0 before settling — that
              // overshoot is the "pop," so only cap it well above 1.0
              // rather than clamping it away entirely.
              scale: isCurrent ? arrival.value.clamp(0.0, 1.2) : 1,
              child: child,
            ),
          ),
        );
      },
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
  });

  final int levelNumber;
  final String levelName;
  final double ringValue;
  final num remaining;
  final UserLevel? nextLevel;

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
            trackColor: Colors.white.withValues(alpha: 0.14),
            child: Text(
              '$levelNumber',
              style: MuType.stat.copyWith(color: MuColors.surface, fontSize: 26),
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
                  nextLevel == null
                      ? "You've cleared every level so far."
                      : '$remaining more karma unlocks Level ${levelNumber + 1} · ${nextLevel!.name}',
                  style: MuType.caption.copyWith(color: Colors.white.withValues(alpha: 0.7)),
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
  const _LevelCard({required this.index, required this.level, required this.status});

  final int index;
  final UserLevel level;
  final _LevelStatus status;

  @override
  Widget build(BuildContext context) {
    final isEven = index.isEven;
    final doneTasks = level.tasks.where((t) => t.completed).length;

    final (bg, fg) = switch (status) {
      _LevelStatus.current => (MuColors.ink, MuColors.surface),
      _LevelStatus.cleared => (MuColors.surface, MuColors.ink),
      _LevelStatus.locked => (MuColors.hairline, MuColors.inkFaint),
    };

    final (pillBg, pillFg, pillLabel) = switch (status) {
      _LevelStatus.current => (MuColors.karmaAccentTint, MuColors.karmaAccent, 'YOU ARE HERE'),
      _LevelStatus.cleared => (MuColors.successBg, MuColors.success, 'CLEARED'),
      _LevelStatus.locked => (MuColors.hairline, MuColors.inkFaint, 'LOCKED'),
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
          boxShadow: status == _LevelStatus.current ? MuShadow.hero : MuShadow.card,
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
                    color: status == _LevelStatus.current
                        ? Colors.white.withValues(alpha: 0.12)
                        : MuColors.primaryTint,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: MuType.statSmall.copyWith(
                      color: status == _LevelStatus.locked ? MuColors.inkFaint : MuColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: MuSpace.m),
                Expanded(
                  child: Text(level.name, style: MuType.title.copyWith(color: fg)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: pillBg,
                    borderRadius: BorderRadius.circular(MuRadius.chip),
                  ),
                  child: Text(pillLabel, style: MuType.tag.copyWith(color: pillFg)),
                ),
              ],
            ),
            const SizedBox(height: MuSpace.m),
            Row(
              children: [
                Icon(
                  LucideIcons.zap,
                  size: 15,
                  color: status == _LevelStatus.locked ? MuColors.inkFaint : MuColors.karmaAccent,
                ),
                const SizedBox(width: 4),
                Text(
                  '${level.karma} karma',
                  style: MuType.caption.copyWith(
                    color: status == _LevelStatus.current
                        ? Colors.white.withValues(alpha: 0.7)
                        : MuColors.inkSecondary,
                  ),
                ),
                const SizedBox(width: MuSpace.m),
                Text(
                  '$doneTasks/${level.tasks.length} tasks',
                  style: MuType.caption.copyWith(
                    color: status == _LevelStatus.current
                        ? Colors.white.withValues(alpha: 0.7)
                        : MuColors.inkSecondary,
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
