// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrgLinkRequestDto _$OrgLinkRequestDtoFromJson(Map<String, dynamic> json) =>
    _OrgLinkRequestDto(
      id: json['id'] as String,
      fullName: json['full_name'] as String? ?? '',
      muid: json['muid'] as String? ?? '',
      orgTitle: json['org_title'] as String? ?? '',
      graduationYear: json['graduation_year'] as String?,
      isAlumni: json['is_alumni'] as bool? ?? false,
      linkCreatedAt: json['link_created_at'] as String?,
    );

Map<String, dynamic> _$OrgLinkRequestDtoToJson(_OrgLinkRequestDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'muid': instance.muid,
      'org_title': instance.orgTitle,
      'graduation_year': instance.graduationYear,
      'is_alumni': instance.isAlumni,
      'link_created_at': instance.linkCreatedAt,
    };

_PendingCampusEventDto _$PendingCampusEventDtoFromJson(
  Map<String, dynamic> json,
) => _PendingCampusEventDto(
  id: json['id'] as String,
  title: json['title'] as String? ?? '',
  startDatetime: json['start_datetime'] as String?,
  endDatetime: json['end_datetime'] as String?,
  venueCity: json['venue_city'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$PendingCampusEventDtoToJson(
  _PendingCampusEventDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'start_datetime': instance.startDatetime,
  'end_datetime': instance.endDatetime,
  'venue_city': instance.venueCity,
  'tags': instance.tags,
};

_CollabInviteDto _$CollabInviteDtoFromJson(Map<String, dynamic> json) =>
    _CollabInviteDto(
      id: json['id'] as String,
      eventId: json['event_id'] as String,
      eventTitle: json['event_title'] as String? ?? '',
      eventStartDatetime: json['event_start_datetime'] as String?,
      roleLabel: json['role_label'] as String? ?? '',
      entityDetail: json['entity_detail'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$CollabInviteDtoToJson(_CollabInviteDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'event_title': instance.eventTitle,
      'event_start_datetime': instance.eventStartDatetime,
      'role_label': instance.roleLabel,
      'entity_detail': instance.entityDetail,
    };
