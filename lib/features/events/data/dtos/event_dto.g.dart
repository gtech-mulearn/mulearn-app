// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventDto _$EventDtoFromJson(Map<String, dynamic> json) => _EventDto(
  id: json['id'] as String,
  title: json['title'] as String,
  slug: json['slug'] as String,
  status: json['status'] as String,
  eventScope: json['event_scope'] as String,
  eventType: json['event_type'] as String,
  startDatetime: json['start_datetime'] as String,
  endDatetime: json['end_datetime'] as String,
  venue: EventVenueDto.fromJson(json['venue'] as Map<String, dynamic>),
  organizer: EventOrganizerDto.fromJson(
    json['organizer'] as Map<String, dynamic>,
  ),
  isFeatured: json['is_featured'] as bool? ?? false,
  isCollaboration: json['is_collaboration'] as bool? ?? false,
  interestCount: (json['interest_count'] as num?)?.toInt() ?? 0,
  viewerInterestStatus: json['viewer_interest_status'] as String? ?? 'none',
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  coverImage: json['cover_image'] as String?,
  bannerImage: json['banner_image'] as String?,
  description: json['description'] as String?,
  categoryName: json['category_name'] as String?,
  registrationUrl: json['registration_url'] as String?,
  registrationDeadline: json['registration_deadline'] as String?,
  minKarma: (json['min_karma'] as num?)?.toInt(),
  userLimit: (json['user_limit'] as num?)?.toInt(),
);

Map<String, dynamic> _$EventDtoToJson(_EventDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'status': instance.status,
  'event_scope': instance.eventScope,
  'event_type': instance.eventType,
  'start_datetime': instance.startDatetime,
  'end_datetime': instance.endDatetime,
  'venue': instance.venue,
  'organizer': instance.organizer,
  'is_featured': instance.isFeatured,
  'is_collaboration': instance.isCollaboration,
  'interest_count': instance.interestCount,
  'viewer_interest_status': instance.viewerInterestStatus,
  'tags': instance.tags,
  'cover_image': instance.coverImage,
  'banner_image': instance.bannerImage,
  'description': instance.description,
  'category_name': instance.categoryName,
  'registration_url': instance.registrationUrl,
  'registration_deadline': instance.registrationDeadline,
  'min_karma': instance.minKarma,
  'user_limit': instance.userLimit,
};
