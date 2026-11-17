// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ActivityEntryDto _$ActivityEntryDtoFromJson(Map<String, dynamic> json) =>
    _ActivityEntryDto(
      id: json['id'] as String,
      action: json['action'] as String,
      createdAt: json['created_at'] as String,
      label: json['label'] as String? ?? '',
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const <String>[],
      actor: json['actor'] as Map<String, dynamic>?,
      title: json['title'] as String?,
      audienceSize: (json['audience_size'] as num?)?.toInt(),
      audienceLabel: json['audience_label'] as String?,
      oldData: json['old_data'] as Map<String, dynamic>?,
      newData: json['new_data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ActivityEntryDtoToJson(_ActivityEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'action': instance.action,
      'created_at': instance.createdAt,
      'label': instance.label,
      'roles': instance.roles,
      'actor': instance.actor,
      'title': instance.title,
      'audience_size': instance.audienceSize,
      'audience_label': instance.audienceLabel,
      'old_data': instance.oldData,
      'new_data': instance.newData,
    };
