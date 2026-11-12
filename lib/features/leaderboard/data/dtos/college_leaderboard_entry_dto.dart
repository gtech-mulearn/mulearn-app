import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';

part 'college_leaderboard_entry_dto.freezed.dart';
part 'college_leaderboard_entry_dto.g.dart';

/// Raw shape of a college-leaderboard row. The `/college/` (all-time) and
/// `/college-monthly/` endpoints are NOT the same shape (confirmed live):
/// all-time sends `{id, code, title, total_students, total_karma}`, monthly
/// sends `{id, code, total_karma, students}` — no `title` at all, and the
/// member-count key is `students`, not `total_students`. `totalStudents`
/// and `title` are nullable to cover the monthly shape; [_normalize] maps
/// `students` onto `total_students` so real monthly data isn't silently
/// dropped to 0.
@freezed
abstract class CollegeLeaderboardEntryDto with _$CollegeLeaderboardEntryDto {
  const factory CollegeLeaderboardEntryDto({
    String? code,
    String? title,
    int? totalStudents,
    num? totalKarma,
  }) = _CollegeLeaderboardEntryDto;

  const CollegeLeaderboardEntryDto._();

  factory CollegeLeaderboardEntryDto.fromJson(Map<String, dynamic> json) =>
      _$CollegeLeaderboardEntryDtoFromJson(_normalize(json));

  static Map<String, dynamic> _normalize(Map<String, dynamic> json) {
    if (json['total_students'] == null && json['students'] != null) {
      return {...json, 'total_students': json['students']};
    }
    return json;
  }

  CollegeLeaderboardEntry toDomain() => CollegeLeaderboardEntry(
        code: code,
        title: title,
        totalStudents: totalStudents ?? 0,
        totalKarma: totalKarma ?? 0,
      );
}
