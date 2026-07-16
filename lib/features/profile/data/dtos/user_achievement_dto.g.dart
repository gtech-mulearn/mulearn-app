// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_achievement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserAchievementDto _$UserAchievementDtoFromJson(Map<String, dynamic> json) =>
    _UserAchievementDto(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      achievement: AchievementDto.fromJson(
        json['achievement'] as Map<String, dynamic>,
      ),
      isIssued: json['is_issued'] as bool? ?? false,
      vcUrl: json['vc_url'] as String?,
    );

Map<String, dynamic> _$UserAchievementDtoToJson(_UserAchievementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'achievement': instance.achievement,
      'is_issued': instance.isIssued,
      'vc_url': instance.vcUrl,
    };
