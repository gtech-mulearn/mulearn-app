// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_progress_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AchievementProgressDto _$AchievementProgressDtoFromJson(
  Map<String, dynamic> json,
) => _AchievementProgressDto(
  achievementId: json['achievement_id'] as String,
  achievementName: json['achievement_name'] as String? ?? '',
  eligible: json['eligible'] as bool? ?? false,
  claimed: json['claimed'] as bool? ?? false,
  reason: json['reason'] as String?,
  progress: json['progress'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AchievementProgressDtoToJson(
  _AchievementProgressDto instance,
) => <String, dynamic>{
  'achievement_id': instance.achievementId,
  'achievement_name': instance.achievementName,
  'eligible': instance.eligible,
  'claimed': instance.claimed,
  'reason': instance.reason,
  'progress': instance.progress,
};
