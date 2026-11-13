import 'package:freezed_annotation/freezed_annotation.dart';

part 'campus_student.freezed.dart';

/// One learner at the campus (`campus/student-details/`).
@freezed
abstract class CampusStudent with _$CampusStudent {
  const factory CampusStudent({
    required String fullName,
    required String muid,
    required int karma,
    required String level,
    required bool isAlumni,
    required int igCount,
    required int lcCount,
    int? rank,
    DateTime? joinedAt,
    DateTime? lastKarmaAt,
    String? graduationYear,
    String? department,
  }) = _CampusStudent;
}
