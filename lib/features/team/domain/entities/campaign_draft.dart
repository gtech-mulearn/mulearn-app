import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';

part 'campaign_draft.freezed.dart';

/// What the team fills in to create a campaign.
@freezed
abstract class CampaignDraft with _$CampaignDraft {
  const factory CampaignDraft({
    required String title,
    required String body,
    required AudienceType audienceType,
    String? route,
    @Default(<String>[]) List<String> audienceIds,
    DateTime? scheduledAt,
    @Default(true) bool respectQuietHours,
  }) = _CampaignDraft;
}
