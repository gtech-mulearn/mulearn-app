// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_task_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LevelTaskDto _$LevelTaskDtoFromJson(Map<String, dynamic> json) =>
    _LevelTaskDto(
      taskName: json['task_name'] as String,
      active: json['active'] as bool,
      completed: json['completed'] as bool,
      karma: json['karma'] as num,
      discordLink: json['discord_link'] as String?,
      hashtag: json['hashtag'] as String?,
      taskDescription: json['task_description'] as String?,
      interestGroup: json['interest_group'] == null
          ? null
          : TaskInterestGroupDto.fromJson(
              json['interest_group'] as Map<String, dynamic>,
            ),
      submissionChannel: json['submission_channel'] == null
          ? null
          : TaskSubmissionChannelDto.fromJson(
              json['submission_channel'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$LevelTaskDtoToJson(_LevelTaskDto instance) =>
    <String, dynamic>{
      'task_name': instance.taskName,
      'active': instance.active,
      'completed': instance.completed,
      'karma': instance.karma,
      'discord_link': instance.discordLink,
      'hashtag': instance.hashtag,
      'task_description': instance.taskDescription,
      'interest_group': instance.interestGroup,
      'submission_channel': instance.submissionChannel,
    };
