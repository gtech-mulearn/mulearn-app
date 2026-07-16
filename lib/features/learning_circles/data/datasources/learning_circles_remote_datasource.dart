import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_form.dart';

class LearningCirclesRemoteDataSource {
  LearningCirclesRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/ig/list/` — only `{id, name}` is read here for
  /// the create-circle IG dropdown; the richer catalog shape is the
  /// `interest_groups` feature's concern, not duplicated here (rules.md §2:
  /// this datasource independently calls the same shared endpoint rather
  /// than importing that feature).
  Future<List<dynamic>> fetchIgOptions() async {
    final response = await _dio.get<dynamic>(ApiPaths.interestGroupsList);
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['interestGroup'] as List<dynamic>;
  }

  // --- Circles ---

  Future<Map<String, dynamic>> fetchCircles({int page = 1}) async {
    final response = await _dio.get<dynamic>(
      ApiPaths.circlesList,
      queryParameters: {'page': page},
    );
    return ApiEnvelope.unwrapObject(response);
  }

  Future<List<dynamic>> fetchMyCircles() async {
    final response = await _dio.get<dynamic>(ApiPaths.userCircles);
    return ApiEnvelope.unwrapList(response);
  }

  Future<Map<String, dynamic>> fetchCircleDetail(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.circleDetail(id));
    return ApiEnvelope.unwrapObject(response);
  }

  Future<String> createCircle({
    required String igId,
    required String orgId,
    required String title,
    required String description,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.circlesCreate,
      data: {'ig': igId, 'org': orgId, 'title': title, 'description': description},
    );
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['circle_id'] as String;
  }

  Future<void> editCircle(
    String id, {
    String? igId,
    String? orgId,
    String? title,
    String? description,
  }) async {
    final response = await _dio.put<dynamic>(
      ApiPaths.circleEdit(id),
      data: {
        if (igId != null) 'ig': igId,
        if (orgId != null) 'org': orgId,
        if (title != null) 'title': title,
        if (description != null) 'description': description,
      },
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> deleteCircle(String id) async {
    final response = await _dio.delete<dynamic>(ApiPaths.circleDelete(id));
    ApiEnvelope.unwrapObject(response);
  }

  // --- Members & leadership ---

  Future<Map<String, dynamic>> fetchCircleMembers(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.circleMembers(id));
    return ApiEnvelope.unwrapObject(response);
  }

  Future<void> approveMember(
    String id, {
    required String muid,
    required bool accept,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.circleMembersAdd(id),
      data: {'muid': muid, 'flag': accept},
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> transferLead(String id, {required String muid}) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.circleTransferLead(id),
      data: {'muid': muid},
    );
    ApiEnvelope.unwrapObject(response);
  }

  // --- Joining ---

  Future<void> requestToJoin(String id) async {
    final response = await _dio.post<dynamic>(ApiPaths.circleJoin(id), data: {});
    ApiEnvelope.unwrapObject(response);
  }

  Future<List<dynamic>> fetchJoinRequests(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.circleJoin(id));
    return ApiEnvelope.unwrapList(response);
  }

  Future<void> respondToJoinRequest(
    String id, {
    required String linkId,
    required bool accept,
  }) async {
    final response = await _dio.patch<dynamic>(
      ApiPaths.circleJoin(id),
      data: {'link_id': linkId, 'action': accept ? 'accept' : 'reject'},
    );
    ApiEnvelope.unwrapObject(response);
  }

  // --- Invites ---

  Future<void> sendInvite(String id, {required String muid}) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.circleInvite(id),
      data: {'muid': muid},
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<List<dynamic>> fetchSentInvites(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.circleInviteSent(id));
    return ApiEnvelope.unwrapList(response);
  }

  Future<List<dynamic>> fetchMyPendingInvites() async {
    final response = await _dio.get<dynamic>(ApiPaths.circleInviteStatus);
    return ApiEnvelope.unwrapList(response);
  }

  Future<void> respondToInvite(String linkId, {required bool accept}) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.circleInviteRespond(linkId),
      data: {'is_accepted': accept},
    );
    ApiEnvelope.unwrapObject(response);
  }

  // --- Meetings ---

  Future<List<dynamic>> fetchCircleMeetings(String circleId) async {
    final response = await _dio.get<dynamic>(ApiPaths.meetingList(circleId));
    return ApiEnvelope.unwrapList(response);
  }

  Future<Map<String, dynamic>> fetchMeetingDetail(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.meetingDetail(id));
    return ApiEnvelope.unwrapObject(response);
  }

  Future<void> createMeeting(String circleId, MeetingForm form) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.meetingCreate(circleId),
      data: _meetingFormBody(form),
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> editMeeting(String id, MeetingForm form) async {
    final response = await _dio.put<dynamic>(
      ApiPaths.meetingEdit(id),
      data: _meetingFormBody(form),
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> deleteMeeting(String id) async {
    final response = await _dio.delete<dynamic>(ApiPaths.meetingDelete(id));
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> rsvpMeeting(String id) async {
    final response = await _dio.post<dynamic>(ApiPaths.meetingRsvp(id), data: {});
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> joinMeetingWithCode(String id, String code) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.meetingJoin(id),
      data: {'meet_code': code},
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<void> leaveMeeting(String id) async {
    final response = await _dio.delete<dynamic>(ApiPaths.meetingLeave(id));
    ApiEnvelope.unwrapObject(response);
  }

  // --- Reports ---

  Future<Map<String, dynamic>> fetchAttendeeReport(String meetingId) async {
    final response =
        await _dio.get<dynamic>(ApiPaths.meetingAttendeeReport(meetingId));
    return ApiEnvelope.unwrapObject(response);
  }

  Future<void> submitAttendeeReport(
    String meetingId, {
    String? report,
    String? reportLink,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.meetingAttendeeReport(meetingId),
      data: {
        if (report != null) 'report': report,
        if (reportLink != null) 'report_link': reportLink,
      },
    );
    ApiEnvelope.unwrapObject(response);
  }

  Future<Map<String, dynamic>> fetchMeetingReport(String meetingId) async {
    final response = await _dio.get<dynamic>(ApiPaths.meetingReport(meetingId));
    return ApiEnvelope.unwrapObject(response);
  }

  Future<void> submitMeetingReport(
    String meetingId, {
    required String report,
    required Map<String, bool> attendees,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.meetingReport(meetingId),
      data: {'report': report, 'attendees': attendees},
    );
    ApiEnvelope.unwrapObject(response);
  }

  Map<String, dynamic> _meetingFormBody(MeetingForm form) => {
        'title': form.title,
        'description': form.description,
        'mode': form.mode,
        'meet_place': form.meetPlace,
        'meet_time': form.meetTime,
        'duration': form.duration,
        'is_recurring': form.isRecurring,
        'is_report_needed': form.isReportNeeded,
        'coord_x': form.coordX ?? 0,
        'coord_y': form.coordY ?? 0,
        if (form.platform != null) 'platform': form.platform,
        if (form.meetLink != null) 'meet_link': form.meetLink,
        if (form.recurrenceType != null) 'recurrence_type': form.recurrenceType,
        if (form.recurrence != null) 'recurrence': form.recurrence,
        if (form.reportDescription != null)
          'report_description': form.reportDescription,
      };
}
