import 'package:freezed_annotation/freezed_annotation.dart';

part 'college_leaderboard_entry.freezed.dart';

/// A single row in the college leaderboard — pure-Dart domain entity
/// (rules.md §2). Confirmed against a real `GET /api/v1/leaderboard/college/`
/// response.
@freezed
abstract class CollegeLeaderboardEntry with _$CollegeLeaderboardEntry {
  const factory CollegeLeaderboardEntry({
    required String code,
    required String title,
    required int totalStudents,
    required num totalKarma,
  }) = _CollegeLeaderboardEntry;
}
