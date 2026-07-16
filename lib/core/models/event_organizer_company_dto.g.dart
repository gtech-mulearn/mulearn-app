// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_organizer_company_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventOrganizerCompanyDto _$EventOrganizerCompanyDtoFromJson(
  Map<String, dynamic> json,
) => _EventOrganizerCompanyDto(
  id: json['id'] as String,
  title: json['title'] as String,
  orgType: json['org_type'] as String,
);

Map<String, dynamic> _$EventOrganizerCompanyDtoToJson(
  _EventOrganizerCompanyDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'org_type': instance.orgType,
};
