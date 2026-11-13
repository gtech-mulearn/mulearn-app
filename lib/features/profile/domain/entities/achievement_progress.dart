import 'package:freezed_annotation/freezed_annotation.dart';

part 'achievement_progress.freezed.dart';

/// The rule engine's view of one achievement for the signed-in user
/// (`achievement/eligible/`, `achievement/progress/`).
@freezed
abstract class AchievementProgress with _$AchievementProgress {
  const factory AchievementProgress({
    required String achievementId,
    required String name,
    required bool eligible,
    @Default(false) bool claimed,

    /// e.g. "total_karma: 0/500".
    String? reason,
    num? current,
    num? required,

    /// 0–100.
    int? percentage,
  }) = _AchievementProgress;
}

/// What a successful claim returned.
@freezed
abstract class ClaimResult with _$ClaimResult {
  const factory ClaimResult({
    required String achievementName,
    required bool vcPending,
    required String message,
  }) = _ClaimResult;
}
