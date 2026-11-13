// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_organizer_ig_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventOrganizerIgDto _$EventOrganizerIgDtoFromJson(Map<String, dynamic> json) =>
    _EventOrganizerIgDto(
      id: json['id'] as String,
      name: json['name'] as String,
      iconImage: json['icon_image'] as String?,
    );

Map<String, dynamic> _$EventOrganizerIgDtoToJson(
  _EventOrganizerIgDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon_image': instance.iconImage,
};
