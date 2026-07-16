import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_leaderboard_entry.freezed.dart';

/// A single row in the student leaderboard — pure-Dart domain entity
/// (rules.md §2). Confirmed against a real `GET /api/v1/leaderboard/students/`
/// response.
@freezed
abstract class StudentLeaderboardEntry with _$StudentLeaderboardEntry {
  const factory StudentLeaderboardEntry({
    required String fullName,
    required num totalKarma,
    required String institution,
    String? profilePic,
  }) = _StudentLeaderboardEntry;
}
