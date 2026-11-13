/// The API's level names are "lvl1"…"lvl7" (`get-user-levels/`,
/// `user-profile.level`). Like the dashboard (`level.utils.ts`
/// `parseLevelNumber`), read the digits; 1 when missing or below 1.
int levelNumber(String? level) {
  final digits = RegExp(r'\d+').firstMatch(level ?? '');
  final parsed = digits == null ? null : int.tryParse(digits.group(0)!);
  return parsed == null || parsed < 1 ? 1 : parsed;
}

/// "Level N" for people.
String levelLabel(String? level) => 'Level ${levelNumber(level)}';
