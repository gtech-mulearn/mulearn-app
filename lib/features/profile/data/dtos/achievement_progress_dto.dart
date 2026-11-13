import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/achievement_progress.dart';

part 'achievement_progress_dto.freezed.dart';
part 'achievement_progress_dto.g.dart';

/// One item of `achievement/eligible/` or `achievement/progress/`
/// (achievement_views.py:442-554). `progress` comes from the rule engine:
/// most rule types report `current`, `required` and `percentage`.
@freezed
abstract class AchievementProgressDto with _$AchievementProgressDto {
  const factory AchievementProgressDto({
    required String achievementId,
    @Default('') String achievementName,
    @Default(false) bool eligible,
    @Default(false) bool claimed,
    String? reason,
    Map<String, dynamic>? progress,
  }) = _AchievementProgressDto;

  const AchievementProgressDto._();

  factory AchievementProgressDto.fromJson(Map<String, dynamic> json) => _$AchievementProgressDtoFromJson(json);

  AchievementProgress toDomain() {
    final current = progress?['current'] as num?;
    final required = progress?['required'] as num?;
    final percentage = (progress?['percentage'] as num?)?.round() ??
        (current != null && required != null && required > 0 ? (current / required * 100).clamp(0, 100).round() : null);
    return AchievementProgress(
      achievementId: achievementId,
      name: achievementName,
      eligible: eligible,
      claimed: claimed,
      reason: reason,
      current: current,
      required: required,
      percentage: percentage,
    );
  }
}
