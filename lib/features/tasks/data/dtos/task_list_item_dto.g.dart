// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskListItemDto _$TaskListItemDtoFromJson(Map<String, dynamic> json) =>
    _TaskListItemDto(
      id: json['id'] as String,
      title: json['title'] as String,
      hashtag: json['hashtag'] as String?,
      description: json['description'] as String?,
      karma: json['karma'] as num?,
      channel: json['channel'] as String?,
      discordId: json['discord_id'] as String?,
      type: json['type'] as String?,
      level: json['level'] as String?,
      ig: json['ig'] as String?,
      completed: json['completed'] as bool? ?? false,
    );

Map<String, dynamic> _$TaskListItemDtoToJson(_TaskListItemDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'hashtag': instance.hashtag,
      'description': instance.description,
      'karma': instance.karma,
      'channel': instance.channel,
      'discord_id': instance.discordId,
      'type': instance.type,
      'level': instance.level,
      'ig': instance.ig,
      'completed': instance.completed,
    };
