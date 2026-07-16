import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/leaderboard/data/datasources/leaderboard_remote_datasource.dart';
import 'package:mulearn_app/features/leaderboard/data/repositories/leaderboard_repository_impl.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/student_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leaderboard_controller.g.dart';

@riverpod
LeaderboardRemoteDataSource leaderboardRemoteDataSource(Ref ref) =>
    LeaderboardRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [LeaderboardRepository] contract (rules.md
/// §2/§5).
@riverpod
LeaderboardRepository leaderboardRepository(Ref ref) =>
    LeaderboardRepositoryImpl(ref.watch(leaderboardRemoteDataSourceProvider));

@riverpod
Future<List<StudentLeaderboardEntry>> studentLeaderboard(
  Ref ref, {
  required bool monthly,
}) =>
    ref
        .watch(leaderboardRepositoryProvider)
        .getStudentLeaderboard(monthly: monthly);

@riverpod
Future<List<CollegeLeaderboardEntry>> collegeLeaderboard(
  Ref ref, {
  required bool monthly,
}) =>
    ref
        .watch(leaderboardRepositoryProvider)
        .getCollegeLeaderboard(monthly: monthly);
