// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_report_attendee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingReportAttendeeDto _$MeetingReportAttendeeDtoFromJson(
  Map<String, dynamic> json,
) => _MeetingReportAttendeeDto(
  userId: json['user_id'] as String,
  fullName: json['full_name'] as String,
  muid: json['muid'] as String,
  isLcApproved: json['is_lc_approved'] as bool? ?? false,
  report: json['report'] as String?,
  reportLink: json['report_link'] as String?,
);

Map<String, dynamic> _$MeetingReportAttendeeDtoToJson(
  _MeetingReportAttendeeDto instance,
) => <String, dynamic>{
  'user_id': instance.userId,
  'full_name': instance.fullName,
  'muid': instance.muid,
  'is_lc_approved': instance.isLcApproved,
  'report': instance.report,
  'report_link': instance.reportLink,
};
