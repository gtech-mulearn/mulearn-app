import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';

part 'activity_campaign.freezed.dart';

/// A campaign's live status and counts, as the activity log reports them for
/// the campaign a row is about. Sent, skipped and failed keep changing after
/// the send is logged, so these are as of the last load.
@freezed
abstract class ActivityCampaign with _$ActivityCampaign {
  const factory ActivityCampaign({
    required CampaignStatus status,
    required int targetCount,
    required int sentCount,
    required int skippedCount,
    required int failedCount,
  }) = _ActivityCampaign;
}
