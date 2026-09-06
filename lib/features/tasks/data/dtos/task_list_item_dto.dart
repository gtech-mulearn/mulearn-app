import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';

part 'task_list_item_dto.freezed.dart';
part 'task_list_item_dto.g.dart';

/// Raw shape of one entry in `GET /api/v1/dashboard/task/list/`'s
/// `start_journey`/`become_expert`/`events` arrays — confirmed live:
/// `{id, hashtag, title, description, karma, channel, discord_id, type,
/// variable_karma, level, ig, event, event_id, company_name, completed}`.
/// Only the fields the UI actually surfaces are modeled; `event`/`event_id`/
/// `company_name`/`variable_karma` aren't consumed yet — safer to add them
/// when there's a concrete use than to guess a type for a field always seen
/// `null` so far (the same mistake that broke `karma_distribution`
/// elsewhere: assuming an always-null field's real shape).
@freezed
abstract class TaskListItemDto with _$TaskListItemDto {
  const factory TaskListItemDto({
    required String id,
    required String title,
    String? hashtag,
    String? description,
    num? karma,
    String? channel,
    String? discordId,
    String? type,
    String? level,
    String? ig,
    @Default(false) bool completed,
  }) = _TaskListItemDto;

  const TaskListItemDto._();

  factory TaskListItemDto.fromJson(Map<String, dynamic> json) =>
      _$TaskListItemDtoFromJson(json);

  TaskCatalogItem toDomain(TaskCategory category) => TaskCatalogItem(
        id: id,
        title: title,
        karma: karma ?? 0,
        completed: completed,
        category: category,
        description: description,
        hashtag: hashtag,
        channel: channel,
        discordId: discordId,
        type: type,
        level: level,
        interestGroupName: ig,
      );
}
