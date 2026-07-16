import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/task_interest_group.dart';
import 'package:mulearn_app/features/profile/domain/entities/task_submission_channel.dart';

part 'level_task.freezed.dart';

/// A single task within a [UserLevel]'s Mu-Voyage progression — pure-Dart
/// domain entity (rules.md §2). Confirmed against a real
/// `GET /api/v1/dashboard/profile/get-user-levels/` response.
@freezed
abstract class LevelTask with _$LevelTask {
  const factory LevelTask({
    required String taskName,
    required bool active,
    required bool completed,
    required num karma,
    String? discordLink,
    String? hashtag,
    String? taskDescription,
    TaskInterestGroup? interestGroup,
    TaskSubmissionChannel? submissionChannel,
  }) = _LevelTask;
}
