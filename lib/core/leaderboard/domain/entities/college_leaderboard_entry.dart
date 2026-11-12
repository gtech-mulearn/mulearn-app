import 'package:freezed_annotation/freezed_annotation.dart';

part 'college_leaderboard_entry.freezed.dart';

/// A single row in the college leaderboard — pure-Dart domain entity
/// (rules.md §2). Confirmed against a real `GET /api/v1/leaderboard/college/`
/// response. `code` and `title` are nullable — the `-monthly/` variant of
/// this endpoint returns `null` for them on some rows (confirmed live),
/// unlike the all-time endpoint this DTO was originally checked against.
@freezed
abstract class CollegeLeaderboardEntry with _$CollegeLeaderboardEntry {
  const factory CollegeLeaderboardEntry({
    required int totalStudents,
    required num totalKarma,
    String? code,
    String? title,
  }) = _CollegeLeaderboardEntry;
}
