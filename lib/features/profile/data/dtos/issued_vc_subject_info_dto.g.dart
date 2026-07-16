// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issued_vc_subject_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IssuedVcSubjectInfoDto _$IssuedVcSubjectInfoDtoFromJson(
  Map<String, dynamic> json,
) => _IssuedVcSubjectInfoDto(
  courseName: json['course_name'] as String,
  credentialId: json['credential_id'] as String,
  credentialType: json['credential_type'] as String,
  did: json['did'] as String,
  fullName: json['full_name'] as String,
  s3Url: json['s3_url'] as String,
  templateId: json['template_id'] as String,
  type: json['type'] as String,
  completedDate: json['completed_date'] as String?,
  description: json['description'] as String?,
  email: json['email'] as String?,
);

Map<String, dynamic> _$IssuedVcSubjectInfoDtoToJson(
  _IssuedVcSubjectInfoDto instance,
) => <String, dynamic>{
  'course_name': instance.courseName,
  'credential_id': instance.credentialId,
  'credential_type': instance.credentialType,
  'did': instance.did,
  'full_name': instance.fullName,
  's3_url': instance.s3Url,
  'template_id': instance.templateId,
  'type': instance.type,
  'completed_date': instance.completedDate,
  'description': instance.description,
  'email': instance.email,
};
