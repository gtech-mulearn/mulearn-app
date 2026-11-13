import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/utils/level_label.dart';

/// The API's level is "lvl1"…"lvl7" (get-user-levels/, user-profile level);
/// the dashboard parses the digits (level.utils.ts parseLevelNumber).
void main() {
  test('reads the digits', () {
    expect(levelNumber('lvl1'), 1);
    expect(levelNumber('lvl7'), 7);
    expect(levelNumber('lvl10'), 10);
  });

  test('defaults to 1 when missing or nonsense', () {
    expect(levelNumber(null), 1);
    expect(levelNumber(''), 1);
    expect(levelNumber('lvl0'), 1);
    expect(levelNumber('beginner'), 1);
  });

  test('labels it for people', () {
    expect(levelLabel('lvl1'), 'Level 1');
    expect(levelLabel('lvl10'), 'Level 10');
    expect(levelLabel(null), 'Level 1');
  });
}
