// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_linked_task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventLinkedTaskDto _$EventLinkedTaskDtoFromJson(Map<String, dynamic> json) =>
    _EventLinkedTaskDto(
      id: json['id'] as String,
      title: json['title'] as String? ?? '',
      hashtag: json['hashtag'] as String?,
      description: json['description'] as String?,
      karma: json['karma'] as num?,
      active: json['active'] as bool? ?? false,
      ig: json['ig'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$EventLinkedTaskDtoToJson(_EventLinkedTaskDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hashtag': instance.hashtag,
      'description': instance.description,
      'karma': instance.karma,
      'active': instance.active,
      'ig': instance.ig,
    };
