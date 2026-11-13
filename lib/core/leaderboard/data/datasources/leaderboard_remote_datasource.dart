import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the leaderboard endpoints, returning the unwrapped
/// `response` payload (a bare array for all four). DTO parsing happens in
/// the repository.
///
/// Requests carry [_cacheOptions] (see `CacheConfig.leaderboard`) to force
/// client-side caching regardless of the backend's missing `Cache-Control`
/// header — see that doc comment for why.
class LeaderboardRemoteDataSource {
  const LeaderboardRemoteDataSource(this._dio, this._cacheOptions);

  final Dio _dio;
  final CacheOptions _cacheOptions;

  Future<List<dynamic>> fetchStudentLeaderboard({required bool monthly}) =>
      _fetchList(
        monthly ? ApiPaths.studentLeaderboardMonthly : ApiPaths.studentLeaderboard,
      );

  Future<List<dynamic>> fetchCollegeLeaderboard({required bool monthly}) =>
      _fetchList(
        monthly ? ApiPaths.collegeLeaderboardMonthly : ApiPaths.collegeLeaderboard,
      );

  Future<List<dynamic>> _fetchList(String path) async {
    final response = await _dio.get<dynamic>(path, options: _cacheOptions.toOptions());
    return ApiEnvelope.unwrapList(response);
  }
}
