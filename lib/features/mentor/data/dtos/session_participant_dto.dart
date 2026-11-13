import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';

part 'session_participant_dto.freezed.dart';
part 'session_participant_dto.g.dart';

/// One row of `GET session/participant/list/<session_id>/`.
@freezed
abstract class SessionParticipantDto with _$SessionParticipantDto {
  const factory SessionParticipantDto({
    required String id,
    @Default('') String userId,
    @Default('') String userFullName,
    @Default('') String muId,
    @Default('') String participantRole,
    String? attendanceStatus,
    String? progressNote,
    String? feedback,
    int? contributedMinutes,
  }) = _SessionParticipantDto;

  const SessionParticipantDto._();

  factory SessionParticipantDto.fromJson(Map<String, dynamic> json) => _$SessionParticipantDtoFromJson(json);

  SessionParticipant toDomain() => SessionParticipant(
        linkId: id,
        userId: userId,
        fullName: userFullName,
        muid: muId,
        role: participantRole,
        attendance: AttendanceStatus.fromWire(attendanceStatus),
        progressNote: (progressNote ?? '').trim().isEmpty ? null : progressNote,
        feedback: (feedback ?? '').trim().isEmpty ? null : feedback,
        contributedMinutes: contributedMinutes,
      );
}
