import 'package:mulearn_app/core/utils/count_format.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
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

/// A role title as people read it: the backend's "Admins" is "Admin".
String roleLabel(String title) => title == 'Admins' ? 'Admin' : title;

/// Role titles joined for a line of text, "Admin + Fellow".
String rolesLabel(Iterable<String> titles, {String separator = ', '}) =>
    titles.map(roleLabel).join(separator);

/// Who a campaign goes to, short enough for a list row.
String campaignAudienceLabel(PushCampaign c) {
  final n = c.audienceIds.length;
  return switch (c.audienceType) {
    AudienceType.all => 'Everyone',
    AudienceType.roles => n <= 2 ? rolesLabel(c.audienceIds) : '$n roles',
    AudienceType.igs => countOf(n, 'interest group'),
    AudienceType.colleges => countOf(n, 'college'),
    AudienceType.muids => countOf(n, 'μID'),
    AudienceType.custom => 'Custom audience',
  };
}

/// When a scheduled campaign goes out, as people say it: "Tomorrow · 6:00 PM".
/// Both times are local.
String campaignScheduledLabel(DateTime scheduled, DateTime now) =>
    '${formatDayHeading(scheduled, now)} · ${formatTime(scheduled)}';

/// The time on a campaign row: when it was sent, when it goes out if that is
/// still ahead, else how long ago it was scheduled or created. Local times.
String campaignRowTime(PushCampaign c, DateTime now) {
  final sent = c.sentAt?.toLocal();
  if (sent != null) return formatAgo(sent, now);
  final scheduled = c.scheduledAt?.toLocal();
  if (scheduled != null && scheduled.isAfter(now)) {
    return campaignScheduledLabel(scheduled, now);
  }
  return formatAgo(scheduled ?? c.createdAt.toLocal(), now);
}
