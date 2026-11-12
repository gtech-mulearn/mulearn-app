import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/leaderboard/domain/entities/student_leaderboard_entry.dart';

part 'student_leaderboard_entry_dto.freezed.dart';
part 'student_leaderboard_entry_dto.g.dart';

/// One row of `GET /api/v1/leaderboard/students[-monthly]/`, built by
/// mu_celery/leaderboard_cron.py: `{muid, full_name, total_karma,
/// institution, profile_pic}`; `institution` is null for a student with no
/// college link.
@freezed
abstract class StudentLeaderboardEntryDto with _$StudentLeaderboardEntryDto {
  const factory StudentLeaderboardEntryDto({
    required String fullName,
    required num totalKarma,
    String? institution,
    String? muid,
    String? profilePic,
  }) = _StudentLeaderboardEntryDto;

  const StudentLeaderboardEntryDto._();

  factory StudentLeaderboardEntryDto.fromJson(Map<String, dynamic> json) =>
      _$StudentLeaderboardEntryDtoFromJson(json);

  StudentLeaderboardEntry toDomain() => StudentLeaderboardEntry(
        fullName: fullName,
        totalKarma: totalKarma,
        institution: institution,
        muid: muid,
        profilePic: profilePic,
      );
}
