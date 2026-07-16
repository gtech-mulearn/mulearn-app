import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/student_leaderboard_entry.dart';

/// Leaderboard repository contract (rules.md §2/§5). Throws [ApiException]
/// on failure.
abstract interface class LeaderboardRepository {
  /// `GET /api/v1/leaderboard/students/` (all-time) or
  /// `/students-monthly/` (this month).
  Future<List<StudentLeaderboardEntry>> getStudentLeaderboard({
    required bool monthly,
  });

  /// `GET /api/v1/leaderboard/college/` (all-time) or
  /// `/college-monthly/` (this month).
  Future<List<CollegeLeaderboardEntry>> getCollegeLeaderboard({
    required bool monthly,
  });
}
