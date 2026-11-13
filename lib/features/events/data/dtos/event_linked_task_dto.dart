import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/events/domain/entities/event_linked_task.dart';

part 'event_linked_task_dto.freezed.dart';
part 'event_linked_task_dto.g.dart';

/// One `linked_tasks[]` item of the event detail (LinkedTaskSerializer):
/// `{id, title, description, hashtag, karma, bonus_time, bonus_karma, active,
/// ig}`; `ig` is a MinimalIGSerializer object or null. A new task stays
/// `active: false` until an admin approves it (recorded on dev).
@freezed
abstract class EventLinkedTaskDto with _$EventLinkedTaskDto {
  const factory EventLinkedTaskDto({
    required String id,
    @Default('') String title,
    String? hashtag,
    String? description,
    num? karma,
    @Default(false) bool active,
    Map<String, dynamic>? ig,
  }) = _EventLinkedTaskDto;

  const EventLinkedTaskDto._();

  factory EventLinkedTaskDto.fromJson(Map<String, dynamic> json) => _$EventLinkedTaskDtoFromJson(json);

  EventLinkedTask toDomain() => EventLinkedTask(
        id: id,
        title: title,
        hashtag: hashtag,
        description: description,
        karma: karma,
        igName: ig?['name'] as String?,
      );
}
