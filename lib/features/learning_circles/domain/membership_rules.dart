import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';

/// The viewer's place in a circle. The backend decides every action; these
/// only shape what the app offers.
enum CircleRole { creator, lead, member, visitor }

CircleRole circleRole({required String? myMuid, required String? creatorMuid, required List<CircleMember> members}) {
  if (myMuid == null) return CircleRole.visitor;
  if (creatorMuid != null && myMuid == creatorMuid) return CircleRole.creator;
  for (final m in members) {
    if (m.muid == myMuid) return m.isLeader ? CircleRole.lead : CircleRole.member;
  }
  return CircleRole.visitor;
}

/// CircleMemberRemoveAPI: only the lead or creator removes, never themselves
/// ("Use the leave endpoint instead") nor the creator.
bool canRemoveMember({
  required CircleRole viewer,
  required CircleMember member,
  required String? myMuid,
  required String? creatorMuid,
}) =>
    (viewer == CircleRole.lead || viewer == CircleRole.creator) && member.muid != myMuid && member.muid != creatorMuid;

/// What the viewer can do on a meeting, like the dashboard's
/// meeting-detail-view (RSVP before the start; cancel only until 30 minutes
/// before and before joining; join with the code once started; leave after
/// joining).
class MeetingViewerState {
  const MeetingViewerState({
    required this.isRsvpd,
    required this.hasJoined,
    required this.canRsvp,
    required this.canCancelRsvp,
    required this.canJoinWithCode,
    required this.canLeave,
    required this.membersOnly,
  });

  final bool isRsvpd;
  final bool hasJoined;
  final bool canRsvp;
  final bool canCancelRsvp;
  final bool canJoinWithCode;
  final bool canLeave;

  /// Not a member: only circle members can RSVP or join.
  final bool membersOnly;
}

/// RSVPs can't be removed within this long of the start
/// (LearningCircleRSVPAPI.delete).
const rsvpCancelCutoff = Duration(minutes: 30);

MeetingViewerState meetingViewerState(MeetingDetail meeting, {required String? myUserId, required DateTime now}) {
  final attendee = myUserId == null ? null : meeting.attendees.where((a) => a.userId == myUserId).firstOrNull;
  final isRsvpd = attendee != null;
  final hasJoined = attendee?.isJoined ?? false;
  final active = !meeting.isEnded;
  final start = DateTime.tryParse(meeting.meetTime);
  final beforeCutoff = start != null && now.isBefore(start.subtract(rsvpCancelCutoff));
  final member = meeting.isMember;
  return MeetingViewerState(
    isRsvpd: isRsvpd,
    hasJoined: hasJoined,
    canRsvp: member && active && !meeting.isStarted && !isRsvpd,
    canCancelRsvp: member && active && !meeting.isStarted && isRsvpd && !hasJoined && beforeCutoff,
    canJoinWithCode: member && active && meeting.isStarted && !hasJoined,
    canLeave: active && hasJoined,
    membersOnly: !member && active,
  );
}
