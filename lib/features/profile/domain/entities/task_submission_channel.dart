import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_submission_channel.freezed.dart';

/// The Discord channel a [LevelTask]'s submissions go to — pure-Dart domain
/// entity (rules.md §2). All fields nullable, mirroring a real response.
@freezed
abstract class TaskSubmissionChannel with _$TaskSubmissionChannel {
  const factory TaskSubmissionChannel({
    String? id,
    String? name,
    String? discordId,
  }) = _TaskSubmissionChannel;
}
