// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingDetailDto _$MeetingDetailDtoFromJson(Map<String, dynamic> json) =>
    _MeetingDetailDto(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      mode: json['mode'] as String,
      meetPlace: json['meet_place'] as String,
      meetTime: json['meet_time'] as String,
      ig: json['ig'] as String,
      createdById: json['created_by_id'] as String,
      isStarted: json['is_started'] as bool? ?? false,
      isEnded: json['is_ended'] as bool? ?? false,
      isMember: json['is_member'] as bool? ?? false,
      isReportNeeded: json['is_report_needed'] as bool? ?? false,
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      attendees:
          (json['attendees'] as List<dynamic>?)
              ?.map(
                (e) => MeetingAttendeeDto.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      meetLink: json['meet_link'] as String?,
      reportDescription: json['report_description'] as String?,
      meetCode: json['meet_code'] as String?,
      isRecurring: json['is_recurring'] as bool? ?? false,
    );

Map<String, dynamic> _$MeetingDetailDtoToJson(_MeetingDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'mode': instance.mode,
      'meet_place': instance.meetPlace,
      'meet_time': instance.meetTime,
      'ig': instance.ig,
      'created_by_id': instance.createdById,
      'is_started': instance.isStarted,
      'is_ended': instance.isEnded,
      'is_member': instance.isMember,
      'is_report_needed': instance.isReportNeeded,
      'duration': instance.duration,
      'attendees': instance.attendees,
      'meet_link': instance.meetLink,
      'report_description': instance.reportDescription,
      'meet_code': instance.meetCode,
      'is_recurring': instance.isRecurring,
    };
