// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_location_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StateLocationDto _$StateLocationDtoFromJson(Map<String, dynamic> json) =>
    _StateLocationDto(
      id: json['id'] as String,
      name: json['name'] as String,
      country: CountryLocationDto.fromJson(
        json['country'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$StateLocationDtoToJson(_StateLocationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };
