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

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchStudents(Map<String, Object> query) async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.students, queryParameters: query));
}
