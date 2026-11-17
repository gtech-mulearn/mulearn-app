import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_campaign.freezed.dart';

enum CampaignStatus { draft, scheduled, sending, sent, cancelled, failed }

/// Who a campaign goes to. `roles` ids are role titles, `igs` and `colleges`
/// ids are record ids, `muids` ids are μIDs (`api/push/audience.py`).
/// `custom` is a type this app doesn't know; it is shown, never created.
enum AudienceType { all, roles, igs, colleges, muids, custom }

/// What can be done to a saved campaign.
enum CampaignAction { send, cancel }

/// A push campaign (`PushCampaign`, `api/push/views.py`).
@freezed
abstract class PushCampaign with _$PushCampaign {
  const factory PushCampaign({
    required String id,
    required String title,
    required String body,
    required AudienceType audienceType,
    required List<String> audienceIds,
    required CampaignStatus status,
    required bool respectQuietHours,
    required int targetCount,
    required int sentCount,
    required int skippedCount,
    required int failedCount,
    required DateTime createdAt,
    String? route,
    DateTime? scheduledAt,
    DateTime? sentAt,
    String? createdBy,
  }) = _PushCampaign;
}
