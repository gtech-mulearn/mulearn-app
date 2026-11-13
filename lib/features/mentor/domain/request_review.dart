import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/student_request.dart';

/// The body of `POST session/student-requests/<id>/verify/`
/// (`MentorStudentRequestVerifySerializer`): the decision, plus — when
/// approving — only the details the mentor changed from the proposal.
Map<String, Object?> verifyBody(
  StudentSessionRequest original, {
  required bool approve,
  DateTime? startsLocal,
  DateTime? endsLocal,
  SessionMode? mode,
  String? meetingLink,
  String? venue,
}) {
  if (!approve) return {'status': 'REJECTED'};
  final link = meetingLink?.trim();
  final place = venue?.trim();
  return {
    'status': 'APPROVED',
    if (startsLocal != null && !startsLocal.toUtc().isAtSameMomentAs(original.startsAt))
      'starts_at': startsLocal.toUtc().toIso8601String(),
    if (endsLocal != null && !endsLocal.toUtc().isAtSameMomentAs(original.endsAt))
      'ends_at': endsLocal.toUtc().toIso8601String(),
    if (mode != null && mode != SessionMode.unknown && mode != original.mode) 'mode': mode.wire,
    if (link != null && link != (original.meetingLink ?? '')) 'meeting_link': link,
    if (place != null && place != (original.venue ?? '')) 'venue': place,
  };
}
