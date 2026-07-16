import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/location_option.dart';

part 'location_option_dto.freezed.dart';
part 'location_option_dto.g.dart';

/// Raw `{id, name}` API shape for the country/state/district cascading
/// lookups (rules.md §2) — a different key (`name`, not `title`) from
/// [ReferenceOptionDto]. Lives in `core/` alongside [LocationOption].
@freezed
abstract class LocationOptionDto with _$LocationOptionDto {
  const factory LocationOptionDto({
    required String id,
    required String name,
  }) = _LocationOptionDto;

  const LocationOptionDto._();

  factory LocationOptionDto.fromJson(Map<String, dynamic> json) =>
      _$LocationOptionDtoFromJson(json);

  LocationOption toDomain() => LocationOption(id: id, name: name);
}
