import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
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
        return _parseSkippingErrors(
          items,
          (json) => StudentLeaderboardEntryDto.fromJson(json).toDomain(),
        );
      });

  @override
  Future<List<CollegeLeaderboardEntry>> getCollegeLeaderboard({
    required bool monthly,
  }) =>
      _guard(() async {
        final items =
            await _remote.fetchCollegeLeaderboard(monthly: monthly);
        return _parseSkippingErrors(
          items,
          (json) => CollegeLeaderboardEntryDto.fromJson(json).toDomain(),
        );
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  /// Skips rows that don't match the expected DTO shape instead of crashing
  /// the whole leaderboard — the all-time endpoints return a wider, older
  /// data set than the monthly ones, so they're more likely to include a
  /// row with a deleted/incomplete profile (e.g. a null `institution` or
  /// `total_karma`) than the monthly endpoints' more recent-activity-only
  /// set — mirrors the same defensive pattern used in
  /// `EventsRepositoryImpl`/`LearningCirclesRepositoryImpl`.
  List<T> _parseSkippingErrors<T>(
    List<dynamic> items,
    T Function(Map<String, dynamic>) parse,
  ) {
    final results = <T>[];
    for (final item in items) {
      try {
        results.add(parse(item as Map<String, dynamic>));
      } on Object catch (e, st) {
        appLogger.e('Skipping malformed leaderboard row', error: e, stackTrace: st);
      }
    }
    return results;
  }
}
