// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_profile_completion_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorProfileCompletionDto _$MentorProfileCompletionDtoFromJson(
  Map<String, dynamic> json,
) => _MentorProfileCompletionDto(
  percentage: (json['percentage'] as num?)?.toInt() ?? 0,
  checklist:
      json['checklist'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$MentorProfileCompletionDtoToJson(
  _MentorProfileCompletionDto instance,
) => <String, dynamic>{
  'percentage': instance.percentage,
  'checklist': instance.checklist,
};
