// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarSessionDto _$CalendarSessionDtoFromJson(Map<String, dynamic> json) =>
    _CalendarSessionDto(
      id: json['id'] as String,
      title: json['title'] as String,
      startsAt: json['starts_at'] as String,
      endsAt: json['ends_at'] as String,
      status: json['status'] as String? ?? '',
      mode: json['mode'] as String?,
      meetingLink: json['meeting_link'] as String?,
      venue: json['venue'] as String?,
      mentorName: json['mentor_name'] as String?,
      menteeCount: (json['mentee_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CalendarSessionDtoToJson(_CalendarSessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'starts_at': instance.startsAt,
      'ends_at': instance.endsAt,
      'status': instance.status,
      'mode': instance.mode,
      'meeting_link': instance.meetingLink,
      'venue': instance.venue,
      'mentor_name': instance.mentorName,
      'mentee_count': instance.menteeCount,
    };
