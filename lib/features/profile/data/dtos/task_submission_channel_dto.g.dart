// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_submission_channel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TaskSubmissionChannelDto _$TaskSubmissionChannelDtoFromJson(
  Map<String, dynamic> json,
) => _TaskSubmissionChannelDto(
  id: json['id'] as String?,
  name: json['name'] as String?,
  discordId: json['discord_id'] as String?,
);

Map<String, dynamic> _$TaskSubmissionChannelDtoToJson(
  _TaskSubmissionChannelDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'discord_id': instance.discordId,
};
