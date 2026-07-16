import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/country_location_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/state_location.dart';

part 'state_location_dto.freezed.dart';
part 'state_location_dto.g.dart';

@freezed
abstract class StateLocationDto with _$StateLocationDto {
  const factory StateLocationDto({
    required String id,
    required String name,
    required CountryLocationDto country,
  }) = _StateLocationDto;

  const StateLocationDto._();

  factory StateLocationDto.fromJson(Map<String, dynamic> json) =>
      _$StateLocationDtoFromJson(json);

  StateLocation toDomain() =>
      StateLocation(id: id, name: name, country: country.toDomain());
}
