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

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchStudentActivity(String muid, Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.studentActivity(muid), queryParameters: query));

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchStudents(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.students, queryParameters: query));
}
