import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/meeting_detail_dto.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_attendee.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/membership_rules.dart';

import '../../support/fixtures.dart';

/// LearningCircleRSVPAPI.delete (learningcircle_views.py:431): no RSVP removal
/// after joining or within 30 minutes of the start. The app offers the
/// action only when it can tell it will be accepted (like the dashboard's
/// can_remove_rsvp), and the backend still decides.
void main() {
  // dev: meet_time 2026-11-13T13:00:00Z, not started, the student is a member.
  final recorded = MeetingDetailDto.fromJson(loadFixtureResponse('dev/meeting_detail')! as Map<String, dynamic>).toDomain();
  final start = DateTime.utc(2026, 11, 13, 13);
  const me = 'u-me';
  MeetingDetail rsvpd({bool joined = false}) => recorded.copyWith(attendees: [
        ...recorded.attendees,
        MeetingAttendee(userId: me, fullName: 'Me', isJoined: joined, isReportSubmitted: false),
      ]);

  test('cancel RSVP is offered only before the 30-minute cutoff', () {
    expect(meetingViewerState(rsvpd(), myUserId: me, now: start.subtract(const Duration(minutes: 31))).canCancelRsvp, isTrue);
    expect(meetingViewerState(rsvpd(), myUserId: me, now: start.subtract(const Duration(minutes: 29))).canCancelRsvp, isFalse);
  });

  test('after joining there is no cancel, only leave', () {
    final state = meetingViewerState(rsvpd(joined: true).copyWith(isStarted: true), myUserId: me, now: start);

    expect(state.canCancelRsvp, isFalse);
    expect(state.canLeave, isTrue);
  });

  test('a member who has not answered can RSVP before the start', () {
    final state = meetingViewerState(recorded, myUserId: me, now: start.subtract(const Duration(hours: 2)));

    expect(state.isRsvpd, isFalse);
    expect(state.canRsvp, isTrue);
    expect(state.canJoinWithCode, isFalse);
  });

  test('once it has started, a member joins with the code', () {
    final state = meetingViewerState(recorded.copyWith(isStarted: true), myUserId: me, now: start);

    expect(state.canRsvp, isFalse);
    expect(state.canJoinWithCode, isTrue);
  });

  test('non-members get neither RSVP nor join', () {
    final state = meetingViewerState(recorded.copyWith(isMember: false), myUserId: me, now: start);

    expect(state.membersOnly, isTrue);
    expect(state.canRsvp || state.canJoinWithCode, isFalse);
  });
}
