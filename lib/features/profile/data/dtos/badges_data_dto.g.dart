// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badges_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BadgesDataDto _$BadgesDataDtoFromJson(Map<String, dynamic> json) =>
    _BadgesDataDto(
      fullName: json['full_name'] as String,
      completedTasks:
          (json['completed_tasks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BadgesDataDtoToJson(_BadgesDataDto instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'completed_tasks': instance.completedTasks,
    };
