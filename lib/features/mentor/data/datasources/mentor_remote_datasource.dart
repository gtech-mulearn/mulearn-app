import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// The mentor workspace endpoints (`api/dashboard/mentor/urls.py`).
class MentorRemoteDataSource {
  const MentorRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, dynamic>> fetchOverview() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.overview));

  Future<Map<String, dynamic>> fetchAnalytics() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.analyticsPersonal));

  Future<Map<String, dynamic>> fetchProfileCompletion() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.profileCompletion));

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchSessions(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.sessions, queryParameters: query));

  Future<Map<String, dynamic>> fetchSession(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.session(id)));

  Future<Response<dynamic>> createSession(Map<String, Object?> body) => _dio.post<dynamic>(MentorPaths.sessionCreate, data: body);

  Future<Response<dynamic>> updateSession(String id, Map<String, Object?> body) =>
      _dio.patch<dynamic>(MentorPaths.sessionUpdate(id), data: body);

  Future<Response<dynamic>> deleteSession(String id) => _dio.delete<dynamic>(MentorPaths.sessionUpdate(id));

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchParticipants(String sessionId, Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.participants(sessionId), queryParameters: query));

  Future<Response<dynamic>> updateParticipant(String linkId, Map<String, Object?> body) =>
      _dio.patch<dynamic>(MentorPaths.participantUpdate(linkId), data: body);

  Future<Response<dynamic>> addParticipant(String sessionId, String muid) =>
      _dio.post<dynamic>(MentorPaths.participantAdd(sessionId), data: {'muid': muid});

  Future<Response<dynamic>> completeSession(String id) =>
      _dio.post<dynamic>(MentorPaths.sessionComplete(id), data: <String, dynamic>{});

  /// PATCH, as the dashboard sends it (POST gets 405).
  Future<Response<dynamic>> verifyRequest(String id, Map<String, Object?> body) =>
      _dio.patch<dynamic>(MentorPaths.studentRequestVerify(id), data: body);

  /// `[{id, name}]`.
  Future<List<dynamic>> fetchIgDropdown() async => ApiEnvelope.unwrapList(await _dio.get<dynamic>(MentorPaths.igDropdown));

  /// `{data, pagination}` of REQUESTED sessions in the mentor's scopes.
  Future<Map<String, dynamic>> fetchStudentRequests(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.studentRequests, queryParameters: query));
}
