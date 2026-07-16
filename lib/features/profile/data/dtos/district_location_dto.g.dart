// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DistrictLocationDto _$DistrictLocationDtoFromJson(Map<String, dynamic> json) =>
    _DistrictLocationDto(
      id: json['id'] as String,
      name: json['name'] as String,
      state: StateLocationDto.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DistrictLocationDtoToJson(
  _DistrictLocationDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'state': instance.state,
};
