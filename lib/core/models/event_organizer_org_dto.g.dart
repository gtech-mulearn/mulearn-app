// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_organizer_org_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventOrganizerOrgDto _$EventOrganizerOrgDtoFromJson(
  Map<String, dynamic> json,
) => _EventOrganizerOrgDto(
  id: json['id'] as String,
  title: json['title'] as String,
  orgType: json['org_type'] as String,
);

Map<String, dynamic> _$EventOrganizerOrgDtoToJson(
  _EventOrganizerOrgDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'org_type': instance.orgType,
};
