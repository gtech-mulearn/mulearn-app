import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';

part 'college_leaderboard_entry_dto.freezed.dart';
part 'college_leaderboard_entry_dto.g.dart';

@freezed
abstract class CollegeLeaderboardEntryDto with _$CollegeLeaderboardEntryDto {
  const factory CollegeLeaderboardEntryDto({
    required String code,
    required String title,
    required int totalStudents,
    required num totalKarma,
  }) = _CollegeLeaderboardEntryDto;

  const CollegeLeaderboardEntryDto._();

  factory CollegeLeaderboardEntryDto.fromJson(Map<String, dynamic> json) =>
      _$CollegeLeaderboardEntryDtoFromJson(json);

  CollegeLeaderboardEntry toDomain() => CollegeLeaderboardEntry(
        code: code,
        title: title,
        totalStudents: totalStudents,
        totalKarma: totalKarma,
      );
}
