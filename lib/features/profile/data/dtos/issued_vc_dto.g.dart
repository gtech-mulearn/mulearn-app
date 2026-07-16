// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issued_vc_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_IssuedVcDto _$IssuedVcDtoFromJson(Map<String, dynamic> json) => _IssuedVcDto(
  message: json['message'] as String,
  subjectInfo: IssuedVcSubjectInfoDto.fromJson(
    json['subject_info'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$IssuedVcDtoToJson(_IssuedVcDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'subject_info': instance.subjectInfo,
    };
