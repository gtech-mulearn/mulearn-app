// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_application_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorApplicationDto _$MentorApplicationDtoFromJson(
  Map<String, dynamic> json,
) => _MentorApplicationDto(
  id: json['id'] as String,
  status: json['status'] as String,
  mentorTier: json['mentor_tier'] as String,
);

Map<String, dynamic> _$MentorApplicationDtoToJson(
  _MentorApplicationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'mentor_tier': instance.mentorTier,
};
