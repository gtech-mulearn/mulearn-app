import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'package:mulearn_app/features/leaderboard/data/dtos/college_leaderboard_entry_dto.dart';
import 'package:mulearn_app/features/leaderboard/data/dtos/student_leaderboard_entry_dto.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/student_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  const LeaderboardRepositoryImpl(this._remote);

  final LeaderboardRemoteDataSource _remote;

  @override
  Future<List<StudentLeaderboardEntry>> getStudentLeaderboard({
    required bool monthly,
  }) =>
      _guard(() async {
        final items =
            await _remote.fetchStudentLeaderboard(monthly: monthly);
        return parseEachOrReport(
          items,
          (json) => StudentLeaderboardEntryDto.fromJson(json).toDomain(),
          what: 'StudentLeaderboardEntryDto',
        );
      });

  @override
  Future<List<CollegeLeaderboardEntry>> getCollegeLeaderboard({
    required bool monthly,
  }) =>
      _guard(() async {
        final items =
            await _remote.fetchCollegeLeaderboard(monthly: monthly);
        return parseEachOrReport(
          items,
          (json) => CollegeLeaderboardEntryDto.fromJson(json).toDomain(),
          what: 'CollegeLeaderboardEntryDto',
        );
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

}
