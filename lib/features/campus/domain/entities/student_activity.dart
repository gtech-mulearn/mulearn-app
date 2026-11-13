import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_activity.freezed.dart';

/// One karma entry of a student (`campus/students/<muid>/activity/`);
/// [status] is `Approved`, `Pending` or `Rejected`.
@freezed
abstract class StudentActivity with _$StudentActivity {
  const factory StudentActivity({
    required String id,
    required String taskName,
    required int karma,
    required String status,
    required DateTime createdAt,
    String? igName,
  }) = _StudentActivity;
}
