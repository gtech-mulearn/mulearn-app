import 'package:mulearn_app/features/learning_circles/domain/entities/attendee_report.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_invite.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_members.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/join_request.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_page.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report.dart';

abstract interface class LearningCirclesRepository {
  // --- Circles ---
  Future<LearningCirclePage> getCircles({int page = 1});
  Future<List<LearningCircle>> getMyCircles();
  Future<LearningCircleDetail> getCircleDetail(String id);
  Future<String> createCircle({
    required String igId,
    required String orgId,
    required String title,
    required String description,
  });
  Future<void> editCircle(
    String id, {
    String? igId,
    String? orgId,
    String? title,
    String? description,
  });
  Future<void> deleteCircle(String id);

  // --- Members & leadership ---
  Future<CircleMembers> getCircleMembers(String id);
  Future<void> approveMember(String id, {required String muid, required bool accept});
  Future<void> transferLead(String id, {required String muid});

  // --- Joining ---
  Future<void> requestToJoin(String id);
  Future<List<JoinRequest>> getJoinRequests(String id);
  Future<void> respondToJoinRequest(
    String id, {
    required String linkId,
    required bool accept,
  });

  // --- Invites ---
  Future<void> sendInvite(String id, {required String muid});
  Future<List<CircleInvite>> getSentInvites(String id);
  Future<List<CircleInvite>> getMyPendingInvites();
  Future<void> respondToInvite(String linkId, {required bool accept});

  // --- Meetings ---
  Future<List<Meeting>> getCircleMeetings(String circleId);
  Future<MeetingDetail> getMeetingDetail(String id);
  Future<void> createMeeting(String circleId, MeetingForm form);
  Future<void> editMeeting(String id, MeetingForm form);
  Future<void> deleteMeeting(String id);
  Future<void> rsvpMeeting(String id);
  Future<void> joinMeetingWithCode(String id, String code);
  Future<void> leaveMeeting(String id);

  // --- Reports ---
  Future<AttendeeReport> getAttendeeReport(String meetingId);
  Future<void> submitAttendeeReport(
    String meetingId, {
    String? report,
    String? reportLink,
  });
  Future<MeetingReport> getMeetingReport(String meetingId);
  Future<void> submitMeetingReport(
    String meetingId, {
    required String report,
    required Map<String, bool> attendees,
  });
}
