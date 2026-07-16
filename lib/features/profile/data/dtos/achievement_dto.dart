import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/achievement.dart';

part 'achievement_dto.freezed.dart';
part 'achievement_dto.g.dart';

/// Modeled from the reference dashboard's source (rules.md §3/§9 — not
/// live-tested end-to-end: the test account has no achievements).
@freezed
abstract class AchievementDto with _$AchievementDto {
  const factory AchievementDto({
    required String id,
    required String achievementName,
    String? description,
    String? icon,
    String? levelId,
    @Default([]) List<String> tags,
    String? templateId,
  }) = _AchievementDto;

  const AchievementDto._();

  factory AchievementDto.fromJson(Map<String, dynamic> json) =>
      _$AchievementDtoFromJson(json);

  Achievement toDomain() => Achievement(
        id: id,
        achievementName: achievementName,
        description: description,
        icon: icon,
        levelId: levelId,
        tags: tags,
        templateId: templateId,
      );
}
