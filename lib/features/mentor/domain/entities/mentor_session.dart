import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

part 'mentor_session.freezed.dart';

/// One mentorship session the mentor created (`MentorshipSession`). Times
/// are UTC instants; screens show them in local time.
@freezed
abstract class MentorSession with _$MentorSession {
  const factory MentorSession({
    required String id,
    required String entityId,
    required String entityName,
    required SessionType type,
    required String title,
    required String description,
    required SessionMode mode,
    required DateTime startsAt,
    required DateTime endsAt,
    required SessionStatus status,
    required bool isRecurring,
    int? maxParticipants,
    String? meetingLink,
    String? venue,
  }) = _MentorSession;
}
