import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

/// A scheduled session a learner can join (`session/available/`): the
/// session and the mentor running it.
class AvailableSession {
  const AvailableSession({required this.session, required this.mentorName});

  final MentorSession session;
  final String mentorName;
}

/// Where the learner stands in a session they joined or asked for.
enum LearnerAttendance {
  /// Joined (or invited), not marked yet.
  joined('INVITED'),

  /// The mentor marked them present.
  attended('ATTENDED'),

  /// The mentor marked them absent.
  absent('ABSENT'),
  unknown('');

  const LearnerAttendance(this.wire);
  final String wire;

  static LearnerAttendance fromWire(String? v) => values.firstWhere(
    (e) => e != unknown && e.wire == v?.toUpperCase(),
    orElse: () => unknown,
  );
}

/// One of the learner's sessions (`session/participant/history/`): what
/// they joined or requested, how they did, and their feedback.
class SessionRecord {
  const SessionRecord({
    required this.session,
    required this.attendance,
    this.feedback,
  });

  /// Built from the row's `session_*` fields (its id is the session's).
  final MentorSession session;
  final LearnerAttendance attendance;

  /// What they wrote, once sent (the backend allows one).
  final String? feedback;

  /// Feedback is taken only for sessions they attended.
  bool get canGiveFeedback =>
      attendance == LearnerAttendance.attended && feedback == null;
}

/// A session the learner asked a mentor for (`session/student/my-requests/`).
class MySessionRequest {
  const MySessionRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.groupName,
    required this.mode,
    required this.startsAt,
    required this.endsAt,
    required this.status,
    this.meetingLink,
    this.venue,
  });

  final String id;
  final String title;
  final String description;
  final String groupName;
  final SessionMode mode;
  final DateTime startsAt;
  final DateTime endsAt;

  /// Requested (waiting), Scheduled (approved), Rejected, …
  final SessionStatus status;
  final String? meetingLink;
  final String? venue;
}

/// An Interest Group the learner is in: the only scope they can ask in.
typedef IgChoice = ({String id, String name});

/// A request for a session (`StudentSessionRequestSerializer`).
class SessionRequestDraft {
  const SessionRequestDraft({
    required this.igId,
    required this.title,
    required this.description,
    required this.mode,
    required this.startsAt,
    required this.endsAt,
    this.meetingLink,
    this.venue,
  });

  final String igId;
  final String title;
  final String description;
  final SessionMode mode;
  final DateTime startsAt;
  final DateTime endsAt;
  final String? meetingLink;
  final String? venue;

  Map<String, Object?> toJson() => {
    'session_type': SessionType.igSession.wire,
    'entity_id': igId,
    'title': title,
    'description': description,
    'mode': mode.wire,
    'starts_at': startsAt.toUtc().toIso8601String(),
    'ends_at': endsAt.toUtc().toIso8601String(),
    // The backend refuses a venue online and a link offline.
    if (mode != SessionMode.offline && (meetingLink ?? '').isNotEmpty)
      'meeting_link': meetingLink,
    if (mode != SessionMode.online && (venue ?? '').isNotEmpty) 'venue': venue,
  };
}
