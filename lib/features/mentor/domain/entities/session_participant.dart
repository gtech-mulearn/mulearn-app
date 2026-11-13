import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_participant.freezed.dart';

/// `MentorshipSessionUserLink.AttendanceStatus`.
enum AttendanceStatus {
  invited('INVITED'),
  attended('ATTENDED'),
  absent('ABSENT'),
  unknown('');

  const AttendanceStatus(this.wire);
  final String wire;

  static AttendanceStatus fromWire(String? value) =>
      values.firstWhere((e) => e != unknown && e.wire == value?.toUpperCase(), orElse: () => unknown);

  /// The dashboard's labels (`session-participants-dialog.tsx`).
  String get label => switch (this) {
        AttendanceStatus.invited => 'Invited',
        AttendanceStatus.attended => 'Attended',
        AttendanceStatus.absent => 'Absent',
        AttendanceStatus.unknown => 'Unknown',
      };
}

/// One person linked to a session (`session/participant/list/<id>/`);
/// [linkId] is the id the update endpoint takes.
@freezed
abstract class SessionParticipant with _$SessionParticipant {
  const factory SessionParticipant({
    required String linkId,
    required String userId,
    required String fullName,
    required String muid,
    required String role,
    required AttendanceStatus attendance,
    String? progressNote,
    String? feedback,
    int? contributedMinutes,
  }) = _SessionParticipant;
}
