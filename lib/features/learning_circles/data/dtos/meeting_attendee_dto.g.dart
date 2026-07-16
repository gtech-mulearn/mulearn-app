// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_attendee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeetingAttendeeDto _$MeetingAttendeeDtoFromJson(Map<String, dynamic> json) =>
    _MeetingAttendeeDto(
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      isJoined: json['is_joined'] as bool? ?? false,
      isReportSubmitted: json['is_report_submitted'] as bool? ?? false,
      profilePic: json['profile_pic'] as String?,
      isSameOrg: json['is_same_org'] as bool?,
    );

Map<String, dynamic> _$MeetingAttendeeDtoToJson(_MeetingAttendeeDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'is_joined': instance.isJoined,
      'is_report_submitted': instance.isReportSubmitted,
      'profile_pic': instance.profilePic,
      'is_same_org': instance.isSameOrg,
    };
