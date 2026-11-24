// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_campaign_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PushCampaignDto _$PushCampaignDtoFromJson(Map<String, dynamic> json) =>
    _PushCampaignDto(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      status: json['status'] as String? ?? 'draft',
      respectQuietHours: json['respect_quiet_hours'] as bool? ?? true,
      targetCount: (json['target_count'] as num?)?.toInt() ?? 0,
      sentCount: (json['sent_count'] as num?)?.toInt() ?? 0,
      skippedCount: (json['skipped_count'] as num?)?.toInt() ?? 0,
      failedCount: (json['failed_count'] as num?)?.toInt() ?? 0,
      route: json['route'] as String?,
      audience: json['audience'] as Map<String, dynamic>?,
      scheduledAt: json['scheduled_at'] as String?,
      sentAt: json['sent_at'] as String?,
      createdBy: json['created_by'] as String?,
    );

Map<String, dynamic> _$PushCampaignDtoToJson(_PushCampaignDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'title': instance.title,
      'body': instance.body,
      'status': instance.status,
      'respect_quiet_hours': instance.respectQuietHours,
      'target_count': instance.targetCount,
      'sent_count': instance.sentCount,
      'skipped_count': instance.skippedCount,
      'failed_count': instance.failedCount,
      'route': instance.route,
      'audience': instance.audience,
      'scheduled_at': instance.scheduledAt,
      'sent_at': instance.sentAt,
      'created_by': instance.createdBy,
    };
