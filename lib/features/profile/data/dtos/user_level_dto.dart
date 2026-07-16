import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/level_task_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_level.dart';

part 'user_level_dto.freezed.dart';
part 'user_level_dto.g.dart';

@freezed
abstract class UserLevelDto with _$UserLevelDto {
  const factory UserLevelDto({
    required String name,
    required num karma,
    @Default([]) List<LevelTaskDto> tasks,
  }) = _UserLevelDto;

  const UserLevelDto._();

  factory UserLevelDto.fromJson(Map<String, dynamic> json) =>
      _$UserLevelDtoFromJson(json);

  UserLevel toDomain() => UserLevel(
        name: name,
        karma: karma,
        tasks: tasks.map((t) => t.toDomain()).toList(),
      );
}
