// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CalendarEntryDto _$CalendarEntryDtoFromJson(Map<String, dynamic> json) =>
    _CalendarEntryDto(
      id: json['id'] as String,
      title: json['title'] as String,
      start: json['start'] as String,
      end: json['end'] as String,
      status: json['status'] as String? ?? '',
      venueType: json['venue_type'] as String?,
      organiserName: json['organiser_name'] as String?,
      categoryName: json['category_name'] as String?,
      isFeatured: json['is_featured'] as bool? ?? false,
    );

Map<String, dynamic> _$CalendarEntryDtoToJson(_CalendarEntryDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'start': instance.start,
      'end': instance.end,
      'status': instance.status,
      'venue_type': instance.venueType,
      'organiser_name': instance.organiserName,
      'category_name': instance.categoryName,
      'is_featured': instance.isFeatured,
    };
