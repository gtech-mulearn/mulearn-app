import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/learning_circles/data/datasources/learning_circles_remote_datasource.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/attendee_report_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/circle_invite_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/circle_members_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/join_request_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/learning_circle_detail_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/learning_circle_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/meeting_detail_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/meeting_dto.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/meeting_report_dto.dart';
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
import 'package:mulearn_app/features/learning_circles/domain/repositories/learning_circles_repository.dart';

class LearningCirclesRepositoryImpl implements LearningCirclesRepository {
  const LearningCirclesRepositoryImpl(this._remote);

  final LearningCirclesRemoteDataSource _remote;

  @override
  Future<LearningCirclePage> getCircles({int page = 1}) => _guard(() async {
        final payload = await _remote.fetchCircles(page: page);
        final items = payload['data'] as List<dynamic>;
        final pagination = payload['pagination'] as Map<String, dynamic>?;
        return LearningCirclePage(
          circles: _parseSkippingErrors(
            items,
            (json) => LearningCircleDto.fromJson(json).toDomain(),
          ),
          hasNext: pagination?['isNext'] as bool? ?? false,
        );
      });

  @override
  Future<List<LearningCircle>> getMyCircles() => _guard(() async {
        final items = await _remote.fetchMyCircles();
        return _parseSkippingErrors(
          items,
          (json) => LearningCircleDto.fromJson(json).toDomain(),
        );
      });

  @override
  Future<LearningCircleDetail> getCircleDetail(String id) => _guard(() async {
        final json = await _remote.fetchCircleDetail(id);
        return LearningCircleDetailDto.fromJson(json).toDomain();
      });

  @override
  Future<String> createCircle({
    required String igId,
    required String orgId,
    required String title,
    required String description,
  }) =>
      _guard(() => _remote.createCircle(
            igId: igId,
            orgId: orgId,
            title: title,
            description: description,
          ));

  @override
  Future<void> editCircle(
    String id, {
    String? igId,
    String? orgId,
    String? title,
    String? description,
  }) =>
      _guard(() => _remote.editCircle(
            id,
            igId: igId,
            orgId: orgId,
            title: title,
            description: description,
          ));

  @override
  Future<void> deleteCircle(String id) => _guard(() => _remote.deleteCircle(id));

  @override
  Future<CircleMembers> getCircleMembers(String id) => _guard(() async {
        final json = await _remote.fetchCircleMembers(id);
        return CircleMembersDto.fromJson(json).toDomain();
      });

  @override
  Future<void> approveMember(
    String id, {
    required String muid,
    required bool accept,
  }) =>
      _guard(() => _remote.approveMember(id, muid: muid, accept: accept));

  @override
  Future<void> transferLead(String id, {required String muid}) =>
      _guard(() => _remote.transferLead(id, muid: muid));

  @override
  Future<void> requestToJoin(String id) => _guard(() => _remote.requestToJoin(id));

  @override
  Future<List<JoinRequest>> getJoinRequests(String id) => _guard(() async {
        final items = await _remote.fetchJoinRequests(id);
        return _parseSkippingErrors(
          items,
          (json) => JoinRequestDto.fromJson(json).toDomain(),
        );
      });

  @override
  Future<void> respondToJoinRequest(
    String id, {
    required String linkId,
    required bool accept,
  }) =>
      _guard(() =>
          _remote.respondToJoinRequest(id, linkId: linkId, accept: accept));

  @override
  Future<void> sendInvite(String id, {required String muid}) =>
      _guard(() => _remote.sendInvite(id, muid: muid));

  @override
  Future<List<CircleInvite>> getSentInvites(String id) => _guard(() async {
        final items = await _remote.fetchSentInvites(id);
        return _parseSkippingErrors(
          items,
          (json) => CircleInviteDto.fromJson(json).toDomain(),
        );
      });

  @override
  Future<List<CircleInvite>> getMyPendingInvites() => _guard(() async {
        final items = await _remote.fetchMyPendingInvites();
        return _parseSkippingErrors(
          items,
          (json) => CircleInviteDto.fromJson(json).toDomain(),
        );
      });

  @override
  Future<void> respondToInvite(String linkId, {required bool accept}) =>
      _guard(() => _remote.respondToInvite(linkId, accept: accept));

  @override
  Future<List<Meeting>> getCircleMeetings(String circleId) => _guard(() async {
        final items = await _remote.fetchCircleMeetings(circleId);
        return _parseSkippingErrors(
          items,
          (json) => MeetingDto.fromJson(json).toDomain(),
        );
      });

  @override
  Future<MeetingDetail> getMeetingDetail(String id) => _guard(() async {
        final json = await _remote.fetchMeetingDetail(id);
        return MeetingDetailDto.fromJson(json).toDomain();
      });

  @override
  Future<void> createMeeting(String circleId, MeetingForm form) =>
      _guard(() => _remote.createMeeting(circleId, form));

  @override
  Future<void> editMeeting(String id, MeetingForm form) =>
      _guard(() => _remote.editMeeting(id, form));

  @override
  Future<void> deleteMeeting(String id) => _guard(() => _remote.deleteMeeting(id));

  @override
  Future<void> rsvpMeeting(String id) => _guard(() => _remote.rsvpMeeting(id));

  @override
  Future<void> joinMeetingWithCode(String id, String code) =>
      _guard(() => _remote.joinMeetingWithCode(id, code));

  @override
  Future<void> leaveMeeting(String id) => _guard(() => _remote.leaveMeeting(id));

  @override
  Future<AttendeeReport> getAttendeeReport(String meetingId) => _guard(() async {
        final json = await _remote.fetchAttendeeReport(meetingId);
        return AttendeeReportDto.fromJson(json).toDomain();
      });

  @override
  Future<void> submitAttendeeReport(
    String meetingId, {
    String? report,
    String? reportLink,
  }) =>
      _guard(() => _remote.submitAttendeeReport(
            meetingId,
            report: report,
            reportLink: reportLink,
          ));

  @override
  Future<MeetingReport> getMeetingReport(String meetingId) => _guard(() async {
        final json = await _remote.fetchMeetingReport(meetingId);
        return MeetingReportDto.fromJson(json).toDomain();
      });

  @override
  Future<void> submitMeetingReport(
    String meetingId, {
    required String report,
    required Map<String, bool> attendees,
  }) =>
      _guard(() => _remote.submitMeetingReport(
            meetingId,
            report: report,
            attendees: attendees,
          ));

  /// Parses each row with [parse], skipping (and logging) any row that
  /// throws instead of letting one malformed record crash the whole list —
  /// confirmed live as necessary (rules.md §3/§9): `/user-circles/`'s
  /// populated item shape has never been directly observed (only an empty
  /// `[]` response was confirmed live), and a real account's circle there
  /// threw `type 'Null' is not a subtype of type 'String'` on `id`,
  /// meaning that endpoint's rows don't reliably match `/list/`'s shape
  /// this DTO was modeled on.
  List<T> _parseSkippingErrors<T>(
    List<dynamic> items,
    T Function(Map<String, dynamic>) parse,
  ) {
    final results = <T>[];
    for (final item in items) {
      try {
        results.add(parse(item as Map<String, dynamic>));
      } on Object catch (e, st) {
        appLogger.e(
          'Skipping malformed learning-circle list row. Raw row: $item',
          error: e,
          stackTrace: st,
        );
      }
    }
    return results;
  }

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } on Object catch (e, st) {
      // Riverpod's generated FutureProviders swallow thrown errors straight
      // into AsyncError without printing them anywhere, so a parsing bug
      // here would otherwise be invisible in the console — log it before
      // rethrowing so it still shows up in `flutter run`'s output.
      appLogger.e('LearningCirclesRepository action failed', error: e, stackTrace: st);
      rethrow;
    }
  }
}
