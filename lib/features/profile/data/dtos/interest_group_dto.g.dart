// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interest_group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InterestGroupDto _$InterestGroupDtoFromJson(Map<String, dynamic> json) =>
    _InterestGroupDto(
      name: json['name'] as String,
      id: json['id'] as String?,
      karma: (json['karma'] as num?)?.toInt(),
      level: json['level'] == null
          ? null
          : InterestGroupLevelDto.fromJson(
              json['level'] as Map<String, dynamic>,
            ),
      selected: json['selected'] as bool?,
    );

Map<String, dynamic> _$InterestGroupDtoToJson(_InterestGroupDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'karma': instance.karma,
      'level': instance.level,
      'selected': instance.selected,
    };
