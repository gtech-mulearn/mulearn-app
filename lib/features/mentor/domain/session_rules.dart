import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

/// How early Join appears before a session starts.
const joinWindow = Duration(minutes: 15);

/// Join shows for a scheduled online or hybrid session with a link, from
/// [joinWindow] before it starts until it ends.
bool canJoinSession(MentorSession s, DateTime now) =>
    s.status == SessionStatus.scheduled &&
    s.mode != SessionMode.offline &&
    s.meetingLink != null &&
    !now.isBefore(s.startsAt.subtract(joinWindow)) &&
    now.isBefore(s.endsAt);

bool hasStarted(MentorSession s, DateTime now) => !now.isBefore(s.startsAt);

/// The statuses an edit is allowed on (`MentorSessionUpdateAPI`).
const editableStatuses = {SessionStatus.scheduled, SessionStatus.pendingApproval, SessionStatus.requested};
