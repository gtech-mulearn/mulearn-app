import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';

part 'push_campaign_dto.freezed.dart';
part 'push_campaign_dto.g.dart';

/// One item of `GET /api/v1/push/admin/campaigns/` `response.campaigns`
/// (`_campaign_dict`, `api/push/views.py`). `audience` is `{type, ids}`;
/// `created_by` is the creator's full name.
@freezed
abstract class PushCampaignDto with _$PushCampaignDto {
  const factory PushCampaignDto({
    required String id,
    required String createdAt,
    @Default('') String title,
    @Default('') String body,
    @Default('draft') String status,
    @Default(true) bool respectQuietHours,
    @Default(0) int targetCount,
    @Default(0) int sentCount,
    @Default(0) int skippedCount,
    @Default(0) int failedCount,
    String? route,
    Map<String, dynamic>? audience,
    String? scheduledAt,
    String? sentAt,
    String? createdBy,
  }) = _PushCampaignDto;

  const PushCampaignDto._();

  factory PushCampaignDto.fromJson(Map<String, dynamic> json) =>
      _$PushCampaignDtoFromJson(json);

  PushCampaign toDomain() {
    final scheduled = scheduledAt;
    final sent = sentAt;
    return PushCampaign(
      id: id,
      title: title,
      body: body,
      route: route,
      audienceType: _audienceType(audience?['type'] as String?),
      audienceIds: [
        for (final id in audience?['ids'] as List<dynamic>? ?? const []) '$id',
      ],
      status: _status(status),
      scheduledAt: scheduled == null ? null : DateTime.parse(scheduled).toUtc(),
      respectQuietHours: respectQuietHours,
      targetCount: targetCount,
      sentCount: sentCount,
      skippedCount: skippedCount,
      failedCount: failedCount,
      createdAt: DateTime.parse(createdAt).toUtc(),
      sentAt: sent == null ? null : DateTime.parse(sent).toUtc(),
      createdBy: createdBy,
    );
  }

  static AudienceType _audienceType(String? value) => AudienceType.values
      .firstWhere((t) => t.name == value, orElse: () => AudienceType.all);

  /// An unknown status reads as `failed`, which never offers Send or Cancel.
  static CampaignStatus _status(String value) => CampaignStatus.values
      .firstWhere((s) => s.name == value, orElse: () => CampaignStatus.failed);
}
