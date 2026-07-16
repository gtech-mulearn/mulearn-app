import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group_level.dart';

part 'interest_group_level_dto.freezed.dart';
part 'interest_group_level_dto.g.dart';

@freezed
abstract class InterestGroupLevelDto with _$InterestGroupLevelDto {
  const factory InterestGroupLevelDto({
    required String unit,
    required int count,
  }) = _InterestGroupLevelDto;

  const InterestGroupLevelDto._();

  factory InterestGroupLevelDto.fromJson(Map<String, dynamic> json) =>
      _$InterestGroupLevelDtoFromJson(json);

  InterestGroupLevel toDomain() =>
      InterestGroupLevel(unit: unit, count: count);
}
