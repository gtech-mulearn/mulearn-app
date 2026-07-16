import 'package:freezed_annotation/freezed_annotation.dart';

part 'badges_data.freezed.dart';

/// Completed-task badges for a user — pure-Dart domain entity (rules.md §2).
/// Confirmed against a real response: `completed_tasks` is an array of task
/// title strings, not objects.
@freezed
abstract class BadgesData with _$BadgesData {
  const factory BadgesData({
    required String fullName,
    @Default([]) List<String> completedTasks,
  }) = _BadgesData;
}
