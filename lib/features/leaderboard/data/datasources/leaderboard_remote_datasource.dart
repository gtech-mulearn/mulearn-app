import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the leaderboard endpoints, returning the unwrapped
/// `response` payload (a bare array for all four). DTO parsing happens in
/// the repository.
class LeaderboardRemoteDataSource {
  const LeaderboardRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<dynamic>> fetchStudentLeaderboard({required bool monthly}) =>
      _fetchList(
        monthly ? ApiPaths.studentLeaderboardMonthly : ApiPaths.studentLeaderboard,
      );

  Future<List<dynamic>> fetchCollegeLeaderboard({required bool monthly}) =>
      _fetchList(
        monthly ? ApiPaths.collegeLeaderboardMonthly : ApiPaths.collegeLeaderboard,
      );

  Future<List<dynamic>> _fetchList(String path) async {
    final response = await _dio.get<dynamic>(path);
    return ApiEnvelope.unwrapList(response);
  }
}
