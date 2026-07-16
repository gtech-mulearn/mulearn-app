// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_org_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSearchOrgDto _$UserSearchOrgDtoFromJson(Map<String, dynamic> json) =>
    _UserSearchOrgDto(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String?,
      orgType: json['org_type'] as String?,
    );

Map<String, dynamic> _$UserSearchOrgDtoToJson(_UserSearchOrgDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'code': instance.code,
      'org_type': instance.orgType,
    };
