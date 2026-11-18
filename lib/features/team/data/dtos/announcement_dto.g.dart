// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementDto _$AnnouncementDtoFromJson(Map<String, dynamic> json) =>
    _AnnouncementDto(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      expiresAt: json['expires_at'] as String,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      targetType: json['target_type'] as String? ?? 'global',
      source: json['source'] as String? ?? 'system',
      url: json['url'] as String?,
      targetDetails: json['target_details'] as Map<String, dynamic>?,
      createdByName: json['created_by_name'] as String?,
    );

Map<String, dynamic> _$AnnouncementDtoToJson(_AnnouncementDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'expires_at': instance.expiresAt,
      'title': instance.title,
      'description': instance.description,
      'target_type': instance.targetType,
      'source': instance.source,
      'url': instance.url,
      'target_details': instance.targetDetails,
      'created_by_name': instance.createdByName,
    };
