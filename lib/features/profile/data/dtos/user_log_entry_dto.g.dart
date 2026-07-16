// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_log_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserLogEntryDto _$UserLogEntryDtoFromJson(Map<String, dynamic> json) =>
    _UserLogEntryDto(
      taskName: json['task_name'] as String,
      karma: json['karma'] as num,
      createdDate: json['created_date'] as String,
    );

Map<String, dynamic> _$UserLogEntryDtoToJson(_UserLogEntryDto instance) =>
    <String, dynamic>{
      'task_name': instance.taskName,
      'karma': instance.karma,
      'created_date': instance.createdDate,
    };
