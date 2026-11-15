import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/core/widgets/error_retry_view.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/domain/level_status.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/user_levels_controller.dart';

/// The seven levels as a route (artifact: LevelPath, Screen patterns →
/// Learning journey). The karma card on top shows the current level and how
/// much of it is done; the route below marks cleared, current and ahead
/// levels, and each opens its tasks. Status comes from the user's real level
/// and task completion (`levelStatuses`), never a hardcoded "level 6 of 7".
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
      body = ErrorRetryView(error: levelsState.error!, onRetry: () => ref.invalidate(userLevelsProvider));
    } else if (profileState.hasError && profile == null) {
      body = ErrorRetryView(
        error: profileState.error!,
        onRetry: () => ref.read(profileControllerProvider.notifier).refresh(),
      );
    } else if (levels == null || profile == null) {
      body = const Center(child: CircularProgressIndicator());
    } else {
      body = _JourneyBody(levels: levels, userLevel: profile.level, karma: profile.karma);
    }

    return Scaffold(
      backgroundColor: context.mu.colors.chalk,
      body: SafeArea(bottom: false, child: body),
    );
  }
}

class _JourneyBody extends StatelessWidget {
  _JourneyBody({required List<UserLevel> levels, required this.userLevel, required this.karma})
    : levels = [...levels]..sort((a, b) => levelNumber(a.name).compareTo(levelNumber(b.name)));

  final List<UserLevel> levels;

  /// The user's level from user-profile, e.g. "lvl1".
  final String? userLevel;

  /// Total karma.
  final int karma;

  @override
  Widget build(BuildContext context) {
    final mu = context.mu;
    if (levels.isEmpty) {
      return Center(child: Text('No levels yet.', style: mu.text.body));
    }

    final statuses = levelStatuses(levels, currentLevel: userLevel);
    var currentIndex = statuses.indexOf(LevelStatus.current);
    // Beyond the last listed level: everything is cleared; show the top one.
    if (currentIndex == -1) currentIndex = levels.length - 1;

    final current = levels[currentIndex];
    final remaining = current.tasks.where((t) => !t.completed).fold<num>(0, (sum, t) => sum + t.karma);
    final total = current.tasks.length;
    final done = current.tasks.where((t) => t.completed).length;
    final next = currentIndex + 1 < levels.length ? levels[currentIndex + 1] : null;

    String? toNext;
    if (total > 0 && remaining > 0) {
      toNext = next == null
          ? '${muGrouped(remaining.toInt())} karma left'
          : '${muGrouped(remaining.toInt())} to ${levelLabel(next.name)}';
    }

    return ListView(
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.fromLTRB(MuSpacing.space5, MuSpacing.space4, MuSpacing.space5, MuSpacing.navClearance),
      children: [
        Semantics(
          header: true,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Your ', style: mu.text.displayLight.copyWith(fontSize: 34)),
                TextSpan(text: 'journey', style: mu.text.display.copyWith(fontSize: 34)),
              ],
            ),
          ),
        ),
        const SizedBox(height: MuSpacing.space2),
        Text('Seven levels, all open. Pick any task and start.', style: mu.text.body.copyWith(color: mu.colors.ink2)),
        const SizedBox(height: MuSpacing.space5),
        MuKarmaMeter(
          total: karma,
          level: levelLabel(current.name),
          toNext: toNext,
          progress: total == 0 ? null : done / total,
        ),
        const SizedBox(height: MuSpacing.space5),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: MuSpacing.space4, vertical: MuSpacing.space2),
          decoration: BoxDecoration(color: mu.colors.surface, borderRadius: BorderRadius.circular(MuRadii.card)),
          child: MuLevelPath(
            stops: [
              for (var i = 0; i < levels.length; i++)
                MuLevelStop(
                  number: levelNumber(levels[i].name),
                  title: levelLabel(levels[i].name),
                  state: switch (statuses[i]) {
                    LevelStatus.cleared => MuStopState.done,
                    LevelStatus.current => MuStopState.now,
                    LevelStatus.ahead => MuStopState.ahead,
                  },
                  meta: _meta(levels[i]),
                ),
            ],
            onOpen: (stop) => _openLevel(context, levels.firstWhere((l) => levelNumber(l.name) == stop.number)),
          ),
        ),
      ],
    );
  }

  static String _meta(UserLevel level) {
    final total = level.tasks.length;
    if (total == 0) return 'No tasks in this level yet';
    final done = level.tasks.where((t) => t.completed).length;
    final tasks = total == 1 ? '1 task' : '$total tasks';
    return done == 0 ? '$tasks · ${muGrouped(level.karma.toInt())} karma' : '$tasks · $done done';
  }

  void _openLevel(BuildContext context, UserLevel level) {
    showMuSheet<void>(
      context,
      builder: (context) {
        final mu = context.mu;
        final c = mu.colors;
        return Padding(
          padding: const EdgeInsets.fromLTRB(MuSpacing.space5, 0, MuSpacing.space5, MuSpacing.space6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_meta(level).toUpperCase(), style: mu.text.eyebrow),
              const SizedBox(height: 6),
              Text(levelLabel(level.name), style: mu.text.title2),
              const SizedBox(height: MuSpacing.space3),
              if (level.tasks.isEmpty)
                Text('No tasks in this level yet', style: mu.text.body.copyWith(color: c.ink2))
              else
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: level.tasks.length,
                    separatorBuilder: (_, _) => Divider(color: c.line, height: 1),
                    itemBuilder: (_, i) {
                      final t = level.tasks[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: MuSpacing.space3),
                        child: Row(
                          children: [
                            Icon(
                              t.completed ? LucideIcons.checkCircle2 : LucideIcons.circle,
                              size: MuSizes.iconMd,
                              color: t.completed ? c.success : c.ink3,
                            ),
                            const SizedBox(width: MuSpacing.space3),
                            Expanded(
                              child: Text(
                                t.taskName,
                                style: mu.text.body.copyWith(
                                  color: t.completed ? c.ink3 : c.ink,
                                  decoration: t.completed ? TextDecoration.lineThrough : null,
                                ),
                              ),
                            ),
                            const SizedBox(width: MuSpacing.space2),
                            Text(
                              '+${muGrouped(t.karma.toInt())}',
                              style: mu.text.code.copyWith(color: c.voltText, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
