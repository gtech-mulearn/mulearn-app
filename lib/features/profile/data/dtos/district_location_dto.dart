import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/profile/data/dtos/state_location_dto.dart';
import 'package:mulearn_app/features/profile/domain/entities/district_location.dart';

part 'district_location_dto.freezed.dart';
part 'district_location_dto.g.dart';

@freezed
abstract class DistrictLocationDto with _$DistrictLocationDto {
  const factory DistrictLocationDto({
    required String id,
    required String name,
    required StateLocationDto state,
  }) = _DistrictLocationDto;

  const DistrictLocationDto._();

  factory DistrictLocationDto.fromJson(Map<String, dynamic> json) =>
      _$DistrictLocationDtoFromJson(json);

  DistrictLocation toDomain() =>
      DistrictLocation(id: id, name: name, state: state.toDomain());
}
