import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/interest_group_level_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group.dart';
import 'package:mulearn_app/features/profile/domain/entities/interest_group_level.dart';

part 'interest_group_dto.freezed.dart';
part 'interest_group_dto.g.dart';

/// Raw API shape of an entry in `user-profile`'s `interest_groups` array —
/// confirmed against a real response (rules.md §3/§9): `{id, name, karma,
/// level}`, not the bare string this project's DTO originally guessed.
/// `selected` (when explicitly `false`) filters the entry out — mirrors the
/// reference dashboard's `interest_groups` transform.
@freezed
abstract class InterestGroupDto with _$InterestGroupDto {
  const factory InterestGroupDto({
    required String name,
    String? id,
    int? karma,
    InterestGroupLevelDto? level,
    bool? selected,
  }) = _InterestGroupDto;

  const InterestGroupDto._();

  factory InterestGroupDto.fromJson(Map<String, dynamic> json) =>
      _$InterestGroupDtoFromJson(json);

  InterestGroup toDomain() => InterestGroup(
        name: name,
        id: id,
        karma: karma,
        level: level?.toDomain() ??
            const InterestGroupLevel(unit: 'level', count: 1),
      );
}
