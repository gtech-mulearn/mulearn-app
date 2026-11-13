// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentRequestDto _$StudentRequestDtoFromJson(Map<String, dynamic> json) =>
    _StudentRequestDto(
      id: json['id'] as String,
      startsAt: json['starts_at'] as String,
      endsAt: json['ends_at'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      mode: json['mode'] as String?,
      entityName: json['entity_name'] as String? ?? '',
      meetingLink: json['meeting_link'] as String?,
      venue: json['venue'] as String?,
      requestedByName: json['requested_by_name'] as String? ?? '',
      requestedByMuid: json['requested_by_muid'] as String? ?? '',
    );

Map<String, dynamic> _$StudentRequestDtoToJson(_StudentRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'title': instance.title,
      'description': instance.description,
      'mode': instance.mode,
      'entity_name': instance.entityName,
      'meeting_link': instance.meetingLink,
      'venue': instance.venue,
      'requested_by_name': instance.requestedByName,
      'requested_by_muid': instance.requestedByMuid,
    };
