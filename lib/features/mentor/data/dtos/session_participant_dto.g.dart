// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_participant_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SessionParticipantDto _$SessionParticipantDtoFromJson(
  Map<String, dynamic> json,
) => _SessionParticipantDto(
  id: json['id'] as String,
  userId: json['user_id'] as String? ?? '',
  userFullName: json['user_full_name'] as String? ?? '',
  muId: json['mu_id'] as String? ?? '',
  participantRole: json['participant_role'] as String? ?? '',
  attendanceStatus: json['attendance_status'] as String?,
  progressNote: json['progress_note'] as String?,
  feedback: json['feedback'] as String?,
  contributedMinutes: (json['contributed_minutes'] as num?)?.toInt(),
);

Map<String, dynamic> _$SessionParticipantDtoToJson(
  _SessionParticipantDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'user_id': instance.userId,
  'user_full_name': instance.userFullName,
  'mu_id': instance.muId,
  'participant_role': instance.participantRole,
  'attendance_status': instance.attendanceStatus,
  'progress_note': instance.progressNote,
  'feedback': instance.feedback,
  'contributed_minutes': instance.contributedMinutes,
};
