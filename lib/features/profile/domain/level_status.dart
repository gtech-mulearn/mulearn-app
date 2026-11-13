import 'package:mulearn_app/core/utils/level_label.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';

/// Where a level stands for the user on Journey.
enum LevelStatus { cleared, current, locked }

/// One status per level in [levels], from the user's own level
/// (`user-profile.level`, e.g. "lvl3"): lower levels are cleared, theirs is
/// current, higher ones are locked. Matched by level number, so list order
/// doesn't matter. Task completion doesn't decide it (spec §13: an empty
/// level used to count as cleared, which put a 0-karma learner at lvl7).
List<LevelStatus> levelStatuses(List<UserLevel> levels, {required String? currentLevel}) {
  final current = levelNumber(currentLevel);
  return [
    for (final level in levels)
      switch (levelNumber(level.name)) {
        final n when n < current => LevelStatus.cleared,
        final n when n == current => LevelStatus.current,
        _ => LevelStatus.locked,
      },
  ];
}
