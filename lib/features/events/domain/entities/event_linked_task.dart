import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_linked_task.freezed.dart';

/// A task linked to an event (`linked_tasks`, LinkedTaskSerializer).
@freezed
abstract class EventLinkedTask with _$EventLinkedTask {
  const factory EventLinkedTask({
    required String id,
    required String title,
    String? hashtag,
    String? description,
    num? karma,
    String? igName,
  }) = _EventLinkedTask;
}
