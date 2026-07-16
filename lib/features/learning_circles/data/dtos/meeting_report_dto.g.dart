// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_report_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingReportDto _$MeetingReportDtoFromJson(Map<String, dynamic> json) =>
    _MeetingReportDto(
      isReportSubmitted: json['is_report_submitted'] as bool? ?? false,
      attendees:
          (json['attendees'] as List<dynamic>?)
              ?.map(
                (e) => MeetingReportAttendeeDto.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
      report: json['report'] as String?,
    );

Map<String, dynamic> _$MeetingReportDtoToJson(_MeetingReportDto instance) =>
    <String, dynamic>{
      'is_report_submitted': instance.isReportSubmitted,
      'attendees': instance.attendees,
      'report': instance.report,
    };
