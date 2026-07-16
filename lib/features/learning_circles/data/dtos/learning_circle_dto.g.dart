// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_circle_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearningCircleDto _$LearningCircleDtoFromJson(Map<String, dynamic> json) =>
    _LearningCircleDto(
      id: json['id'] as String,
      ig: json['ig'] as String?,
      title: json['title'] as String?,
      totalMembers: (json['total_members'] as num?)?.toInt(),
      org: json['org'] as String?,
    );

Map<String, dynamic> _$LearningCircleDtoToJson(_LearningCircleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ig': instance.ig,
      'title': instance.title,
      'total_members': instance.totalMembers,
      'org': instance.org,
    };
