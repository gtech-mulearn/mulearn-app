// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'featured_event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FeaturedEventDto _$FeaturedEventDtoFromJson(Map<String, dynamic> json) =>
    _FeaturedEventDto(
      id: json['id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      status: json['status'] as String,
      eventScope: json['event_scope'] as String,
      startDatetime: json['start_datetime'] as String,
      endDatetime: json['end_datetime'] as String,
      venue: EventVenueDto.fromJson(json['venue'] as Map<String, dynamic>),
      organizer: EventOrganizerDto.fromJson(
        json['organizer'] as Map<String, dynamic>,
      ),
      isCollaboration: json['is_collaboration'] as bool? ?? false,
      interestCount: (json['interest_count'] as num?)?.toInt() ?? 0,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      coverImage: json['cover_image'] as String?,
      minKarma: (json['min_karma'] as num?)?.toInt(),
    );

Map<String, dynamic> _$FeaturedEventDtoToJson(_FeaturedEventDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'slug': instance.slug,
      'status': instance.status,
      'event_scope': instance.eventScope,
      'start_datetime': instance.startDatetime,
      'end_datetime': instance.endDatetime,
      'venue': instance.venue,
      'organizer': instance.organizer,
      'is_collaboration': instance.isCollaboration,
      'interest_count': instance.interestCount,
      'tags': instance.tags,
      'cover_image': instance.coverImage,
      'min_karma': instance.minKarma,
    };
