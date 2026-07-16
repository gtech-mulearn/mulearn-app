// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingDto _$MeetingDtoFromJson(Map<String, dynamic> json) => _MeetingDto(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  mode: json['mode'] as String,
  meetPlace: json['meet_place'] as String,
  meetTime: json['meet_time'] as String,
  circleId: json['circle_id'] as String,
  igName: json['ig_name'] as String,
  createdBy: json['created_by'] as String,
  isStarted: json['is_started'] as bool? ?? false,
  isEnded: json['is_ended'] as bool? ?? false,
  attendeesCount: (json['attendees_count'] as num?)?.toInt() ?? 0,
  org: json['org'] as String?,
  meetLink: json['meet_link'] as String?,
  isRecurring: json['is_recurring'] as bool? ?? false,
  isJoined: json['is_joined'] as bool? ?? false,
  isRsvp: json['is_rsvp'] as bool? ?? false,
);

Map<String, dynamic> _$MeetingDtoToJson(_MeetingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'mode': instance.mode,
      'meet_place': instance.meetPlace,
      'meet_time': instance.meetTime,
      'circle_id': instance.circleId,
      'ig_name': instance.igName,
      'created_by': instance.createdBy,
      'is_started': instance.isStarted,
      'is_ended': instance.isEnded,
      'attendees_count': instance.attendeesCount,
      'org': instance.org,
      'meet_link': instance.meetLink,
      'is_recurring': instance.isRecurring,
      'is_joined': instance.isJoined,
      'is_rsvp': instance.isRsvp,
    };
