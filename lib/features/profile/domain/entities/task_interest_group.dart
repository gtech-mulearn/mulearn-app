import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_interest_group.freezed.dart';

/// A `{id, name}` reference to the interest group a [LevelTask] belongs to —
/// pure-Dart domain entity (rules.md §2). Both fields nullable — confirmed
/// against a real response where tasks without an assigned interest group
/// return `{id: null, name: null}`.
@freezed
abstract class TaskInterestGroup with _$TaskInterestGroup {
  const factory TaskInterestGroup({
    String? id,
    String? name,
  }) = _TaskInterestGroup;
}
