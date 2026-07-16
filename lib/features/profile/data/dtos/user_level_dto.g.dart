// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserLevelDto _$UserLevelDtoFromJson(Map<String, dynamic> json) =>
    _UserLevelDto(
      name: json['name'] as String,
      karma: json['karma'] as num,
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((e) => LevelTaskDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserLevelDtoToJson(_UserLevelDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'karma': instance.karma,
      'tasks': instance.tasks,
    };
