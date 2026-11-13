import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the home dashboard's endpoints, returning the
/// unwrapped `response` payload. DTO parsing happens in the repository.
class DashboardRemoteDataSource {
  const DashboardRemoteDataSource(this._dio);

  final Dio _dio;


  /// `GET /api/v1/dashboard/events/featured/` — items live under
  /// `response.data`, a `pagination` sibling key sits alongside it.
  /// `GET mentor/overview/` — Home reads only the upcoming-session counts.
  Future<Map<String, dynamic>> fetchMentorOverview() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(MentorPaths.overview));

  /// `GET campus/home-summary/` — Home reads the campus and its first stat.
  Future<Map<String, dynamic>> fetchCampusSummary() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(CampusPaths.homeSummary));

  Future<Map<String, dynamic>> fetchLearnerSummary() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ApiPaths.learnerSummary));

  Future<List<dynamic>> fetchFeaturedEvents() async {
    final response = await _dio.get<dynamic>(ApiPaths.featuredEvents);
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['data'] as List<dynamic>;
  }

}
