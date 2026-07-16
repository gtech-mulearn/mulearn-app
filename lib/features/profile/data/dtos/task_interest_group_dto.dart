import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/task_interest_group.dart';

part 'task_interest_group_dto.freezed.dart';
part 'task_interest_group_dto.g.dart';

@freezed
abstract class TaskInterestGroupDto with _$TaskInterestGroupDto {
  const factory TaskInterestGroupDto({
    String? id,
    String? name,
  }) = _TaskInterestGroupDto;

  const TaskInterestGroupDto._();

  factory TaskInterestGroupDto.fromJson(Map<String, dynamic> json) =>
      _$TaskInterestGroupDtoFromJson(json);

  TaskInterestGroup toDomain() => TaskInterestGroup(id: id, name: name);
}
