import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/profile/domain/entities/level_task.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';
import 'package:mulearn_app/features/profile/domain/level_status.dart';

import '../../support/fixtures.dart';

/// Journey showed lvl2–lvl6 "CLEARED" and lvl7 "YOU ARE HERE" for a 0-karma
/// lvl1 student (spec §13; seen again on the phone 2026-11-13): every dev
/// level has 0 tasks, and "all tasks done" was true for an empty level.
/// The status now follows the user's level from user-profile.
void main() {
  final recorded = [
    for (final l in (loadFixtureResponse('dev/get_user_levels')! as List<dynamic>).cast<Map<String, dynamic>>())
      UserLevel(name: l['name'] as String, karma: l['karma'] as num),
  ];

  test('a lvl1 learner is at Level 1; nothing is cleared', () {
    expect(recorded.map((l) => l.name), ['lvl1', 'lvl2', 'lvl3', 'lvl4', 'lvl5', 'lvl6', 'lvl7']);

    expect(levelStatuses(recorded, currentLevel: 'lvl1'),
        [LevelStatus.current, for (var i = 0; i < 6; i++) LevelStatus.locked]);
  });

  test('levels below the current one are cleared', () {
    expect(levelStatuses(recorded, currentLevel: 'lvl3'), [
      LevelStatus.cleared,
      LevelStatus.cleared,
      LevelStatus.current,
      for (var i = 0; i < 4; i++) LevelStatus.locked,
    ]);
  });

  test('statuses follow the level number, not the list order', () {
    final shuffled = [recorded[2], recorded[0], recorded[1]];

    expect(levelStatuses(shuffled, currentLevel: 'lvl2'), [LevelStatus.locked, LevelStatus.cleared, LevelStatus.current]);
  });

  test("finishing a level's tasks doesn't move the user; their level does", () {
    final done = [
      const UserLevel(
        name: 'lvl1',
        karma: 20,
        tasks: [LevelTask(taskName: 't', active: true, completed: true, karma: 20)],
      ),
      const UserLevel(name: 'lvl2', karma: 200),
    ];

    expect(levelStatuses(done, currentLevel: 'lvl1'), [LevelStatus.current, LevelStatus.locked]);
  });

  test('an unknown level counts as Level 1', () {
    expect(levelStatuses(recorded.take(2).toList(), currentLevel: null), [LevelStatus.current, LevelStatus.locked]);
  });
}
