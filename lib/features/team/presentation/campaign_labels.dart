import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';

/// How a campaign's status reads in pills and on the detail.
String campaignStatusLabel(CampaignStatus status) => switch (status) {
  CampaignStatus.draft => 'Draft',
  CampaignStatus.scheduled => 'Scheduled',
  CampaignStatus.sending => 'Sending',
  CampaignStatus.sent => 'Sent',
  CampaignStatus.cancelled => 'Cancelled',
  CampaignStatus.failed => 'Failed',
};

/// Who a campaign goes to, short enough for a list row.
String campaignAudienceLabel(PushCampaign c) {
  final n = c.audienceIds.length;
  return switch (c.audienceType) {
    AudienceType.all => 'Everyone',
    AudienceType.roles => n <= 2 ? c.audienceIds.join(', ') : '$n roles',
    AudienceType.igs => n == 1 ? '1 interest group' : '$n interest groups',
    AudienceType.colleges => n == 1 ? '1 college' : '$n colleges',
    AudienceType.muids => n == 1 ? '1 μID' : '$n μIDs',
  };
}
