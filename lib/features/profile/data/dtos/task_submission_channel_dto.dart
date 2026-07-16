import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/task_submission_channel.dart';

part 'task_submission_channel_dto.freezed.dart';
part 'task_submission_channel_dto.g.dart';

@freezed
abstract class TaskSubmissionChannelDto with _$TaskSubmissionChannelDto {
  const factory TaskSubmissionChannelDto({
    String? id,
    String? name,
    String? discordId,
  }) = _TaskSubmissionChannelDto;

  const TaskSubmissionChannelDto._();

  factory TaskSubmissionChannelDto.fromJson(Map<String, dynamic> json) =>
      _$TaskSubmissionChannelDtoFromJson(json);

  TaskSubmissionChannel toDomain() =>
      TaskSubmissionChannel(id: id, name: name, discordId: discordId);
}
