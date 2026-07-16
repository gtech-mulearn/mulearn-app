import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the home dashboard's endpoints, returning the
/// unwrapped `response` payload. DTO parsing happens in the repository.
class DashboardRemoteDataSource {
  const DashboardRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/profile/karma-feed/`.
  Future<Map<String, dynamic>> fetchKarmaFeed() async {
    final response = await _dio.get<dynamic>(ApiPaths.karmaFeed);
    return ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/events/featured/` — items live under
  /// `response.data`, a `pagination` sibling key sits alongside it.
  Future<List<dynamic>> fetchFeaturedEvents() async {
    final response = await _dio.get<dynamic>(ApiPaths.featuredEvents);
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['data'] as List<dynamic>;
  }

  /// `GET /api/v1/dashboard/profile/user-profile/` — reused as-is; this
  /// feature only projects a few fields out of it (see
  /// [MyProgressSummaryDto]).
  Future<Map<String, dynamic>> fetchMyProgressSummary() async {
    final response = await _dio.get<dynamic>(ApiPaths.userProfile);
    return ApiEnvelope.unwrapObject(response);
  }
}
