// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_distribution_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KarmaDistributionEntryDto _$KarmaDistributionEntryDtoFromJson(
  Map<String, dynamic> json,
) => _KarmaDistributionEntryDto(
  taskType: json['task_type'] as String,
  karma: json['karma'] as num,
);

Map<String, dynamic> _$KarmaDistributionEntryDtoToJson(
  _KarmaDistributionEntryDto instance,
) => <String, dynamic>{'task_type': instance.taskType, 'karma': instance.karma};
