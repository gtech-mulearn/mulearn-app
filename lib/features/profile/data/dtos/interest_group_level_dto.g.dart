// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_group_level_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InterestGroupLevelDto _$InterestGroupLevelDtoFromJson(
  Map<String, dynamic> json,
) => _InterestGroupLevelDto(
  unit: json['unit'] as String,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$InterestGroupLevelDtoToJson(
  _InterestGroupLevelDto instance,
) => <String, dynamic>{'unit': instance.unit, 'count': instance.count};
