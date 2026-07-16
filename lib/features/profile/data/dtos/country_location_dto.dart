import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/domain/entities/country_location.dart';

part 'country_location_dto.freezed.dart';
part 'country_location_dto.g.dart';

@freezed
abstract class CountryLocationDto with _$CountryLocationDto {
  const factory CountryLocationDto({
    required String id,
    required String name,
  }) = _CountryLocationDto;

  const CountryLocationDto._();

  factory CountryLocationDto.fromJson(Map<String, dynamic> json) =>
      _$CountryLocationDtoFromJson(json);

  CountryLocation toDomain() => CountryLocation(id: id, name: name);
}
