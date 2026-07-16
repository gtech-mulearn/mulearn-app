import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/badges_data.dart';

part 'badges_data_dto.freezed.dart';
part 'badges_data_dto.g.dart';

@freezed
abstract class BadgesDataDto with _$BadgesDataDto {
  const factory BadgesDataDto({
    required String fullName,
    @Default([]) List<String> completedTasks,
  }) = _BadgesDataDto;

  const BadgesDataDto._();

  factory BadgesDataDto.fromJson(Map<String, dynamic> json) =>
      _$BadgesDataDtoFromJson(json);

  BadgesData toDomain() =>
      BadgesData(fullName: fullName, completedTasks: completedTasks);
}
