import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// The campus workspace endpoints (`api/dashboard/campus/urls.py`).
class CampusRemoteDataSource {
  const CampusRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchSummary() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.homeSummary));

  Future<Map<String, dynamic>> fetchWeeklyKarma() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.weeklyKarma));

  Future<Map<String, dynamic>> fetchCircles(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.circles, queryParameters: query));

  Future<Map<String, dynamic>> fetchIgs(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.igs, queryParameters: query));

  Future<Map<String, dynamic>> fetchOrgLinks() async => ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(CampusPaths.orgLinks, queryParameters: {'pageIndex': 1, 'perPage': 50}),
      );

  Future<Response<dynamic>> verifyOrgLink(String id) => _dio.patch<dynamic>(CampusPaths.orgLink(id), data: {'verified': true});

  Future<Map<String, dynamic>> fetchPendingEvents() async => ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          CampusPaths.events,
          queryParameters: {'status': 'pending_campus_approval', 'pageIndex': 1, 'perPage': 50},
        ),
      );

  Future<Response<dynamic>> approveEvent(String id) => _dio.post<dynamic>(CampusPaths.eventApprove(id), data: <String, dynamic>{});

  Future<Response<dynamic>> rejectEvent(String id, String reason) =>
      _dio.post<dynamic>(CampusPaths.eventReject(id), data: {'reason': reason});

  Future<List<dynamic>> fetchInvites() async => ApiEnvelope.unwrapList(await _dio.get<dynamic>(CampusPaths.myInvites));

  Future<Response<dynamic>> acceptInvite(String eventId, String id) =>
      _dio.post<dynamic>(CampusPaths.inviteAccept(eventId, id), data: <String, dynamic>{});

  Future<Response<dynamic>> rejectInvite(String eventId, String id, String reason) =>
      _dio.post<dynamic>(CampusPaths.inviteReject(eventId, id), data: {'reason': reason});

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchStudentActivity(String muid, Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.studentActivity(muid), queryParameters: query));

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchStudents(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.students, queryParameters: query));
}
