// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationDto _$NotificationDtoFromJson(Map<String, dynamic> json) =>
    _NotificationDto(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      type: json['type'] as String?,
      category: json['category'] as String?,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      entityType: json['entity_type'] as String?,
      entityId: json['entity_id'] as String?,
      isRead: json['is_read'] as bool? ?? false,
      source: json['source'] as String? ?? 'personal',
      redirectUrl: json['redirect_url'] as String?,
    );

Map<String, dynamic> _$NotificationDtoToJson(_NotificationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'type': instance.type,
      'category': instance.category,
      'title': instance.title,
      'description': instance.description,
      'entity_type': instance.entityType,
      'entity_id': instance.entityId,
      'is_read': instance.isRead,
      'source': instance.source,
      'redirect_url': instance.redirectUrl,
    };
