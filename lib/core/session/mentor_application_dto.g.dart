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
  organization: json['organization'] as String?,
  rejectionReason: json['rejection_reason'] as String?,
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$MentorApplicationDtoToJson(
  _MentorApplicationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'status': instance.status,
  'mentor_tier': instance.mentorTier,
  'organization': instance.organization,
  'rejection_reason': instance.rejectionReason,
  'created_at': instance.createdAt,
};
