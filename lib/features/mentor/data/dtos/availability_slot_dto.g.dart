// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'availability_slot_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AvailabilitySlotDto _$AvailabilitySlotDtoFromJson(Map<String, dynamic> json) =>
    _AvailabilitySlotDto(
      id: json['id'] as String,
      weekday: (json['weekday'] as num).toInt(),
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      timezone: json['timezone'] as String? ?? defaultTimezone,
      isActive: json['is_active'] as bool? ?? true,
      igId: json['ig_id'] as String?,
      igName: json['ig_name'] as String?,
    );

Map<String, dynamic> _$AvailabilitySlotDtoToJson(
  _AvailabilitySlotDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'weekday': instance.weekday,
  'start_time': instance.startTime,
  'end_time': instance.endTime,
  'timezone': instance.timezone,
  'is_active': instance.isActive,
  'ig_id': instance.igId,
  'ig_name': instance.igName,
};
