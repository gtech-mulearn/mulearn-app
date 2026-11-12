import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_leaderboard_entry.freezed.dart';

/// A single row in the student leaderboard — pure-Dart domain entity
/// (rules.md §2). [institution] is null for a student with no college link;
/// [muid] opens the student's public profile.
@freezed
abstract class StudentLeaderboardEntry with _$StudentLeaderboardEntry {
  const factory StudentLeaderboardEntry({
    required String fullName,
    required num totalKarma,
    String? institution,
    String? muid,
    String? profilePic,
  }) = _StudentLeaderboardEntry;
}
