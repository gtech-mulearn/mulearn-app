import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/student_leaderboard_entry.dart';

part 'student_leaderboard_entry_dto.freezed.dart';
part 'student_leaderboard_entry_dto.g.dart';

@freezed
abstract class StudentLeaderboardEntryDto with _$StudentLeaderboardEntryDto {
  const factory StudentLeaderboardEntryDto({
    required String fullName,
    required num totalKarma,
    required String institution,
    String? profilePic,
  }) = _StudentLeaderboardEntryDto;

  const StudentLeaderboardEntryDto._();

  factory StudentLeaderboardEntryDto.fromJson(Map<String, dynamic> json) =>
      _$StudentLeaderboardEntryDtoFromJson(json);

  StudentLeaderboardEntry toDomain() => StudentLeaderboardEntry(
        fullName: fullName,
        totalKarma: totalKarma,
        institution: institution,
        profilePic: profilePic,
      );
}
