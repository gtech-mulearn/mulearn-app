import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/task_interest_group_dto.dart';
import 'package:mulearn_app/features/profile/data/dtos/task_submission_channel_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/level_task.dart';

part 'level_task_dto.freezed.dart';
part 'level_task_dto.g.dart';

@freezed
abstract class LevelTaskDto with _$LevelTaskDto {
  const factory LevelTaskDto({
    required String taskName,
    required bool active,
    required bool completed,
    required num karma,
    String? discordLink,
    String? hashtag,
    String? taskDescription,
    TaskInterestGroupDto? interestGroup,
    TaskSubmissionChannelDto? submissionChannel,
  }) = _LevelTaskDto;

  const LevelTaskDto._();

  factory LevelTaskDto.fromJson(Map<String, dynamic> json) =>
      _$LevelTaskDtoFromJson(json);

  LevelTask toDomain() => LevelTask(
        taskName: taskName,
        active: active,
        completed: completed,
        karma: karma,
        discordLink: discordLink,
        hashtag: hashtag,
        taskDescription: taskDescription,
        interestGroup: interestGroup?.toDomain(),
        submissionChannel: submissionChannel?.toDomain(),
      );
}
