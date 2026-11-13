// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorSessionDto _$MentorSessionDtoFromJson(Map<String, dynamic> json) =>
    _MentorSessionDto(
      id: json['id'] as String,
      startsAt: json['starts_at'] as String,
      endsAt: json['ends_at'] as String,
      entityId: json['entity_id'] as String? ?? '',
      entityName: json['entity_name'] as String? ?? '',
      sessionType: json['session_type'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String?,
      mode: json['mode'] as String?,
      status: json['status'] as String?,
      maxParticipants: (json['max_participants'] as num?)?.toInt(),
      meetingLink: json['meeting_link'] as String?,
      venue: json['venue'] as String?,
      isRecurring: json['is_recurring'] as bool? ?? false,
    );

Map<String, dynamic> _$MentorSessionDtoToJson(_MentorSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'entity_id': instance.entityId,
      'entity_name': instance.entityName,
      'session_type': instance.sessionType,
      'title': instance.title,
      'description': instance.description,
      'mode': instance.mode,
      'status': instance.status,
      'max_participants': instance.maxParticipants,
      'meeting_link': instance.meetingLink,
      'venue': instance.venue,
      'is_recurring': instance.isRecurring,
    };
