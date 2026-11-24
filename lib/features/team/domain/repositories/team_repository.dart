import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/domain/entities/campaign_draft.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';

/// Everything the Team workspace reads and writes. Failures throw
/// `ApiException`.
abstract interface class TeamRepository {
  Future<AnnouncementPage> announcements(int page);

  Future<void> sendToEveryone({
    required String title,
    required String description,
    String? redirectUrl,
    int? expiresInDays,
  });

  Future<Announcement> updateAnnouncement(
    String id, {
    String? title,
    String? description,
    String? url,
    DateTime? expiresAt,
  });

  Future<void> deleteAnnouncement(String id);

  Future<void> deleteAllAnnouncements();

  Future<List<PushCampaign>> campaigns();

  /// Sends `scheduled_at` as a UTC ISO time with `Z`.
  Future<PushCampaign> createCampaign(CampaignDraft draft);

  Future<void> campaignAction(String id, CampaignAction action);

  /// Pushes to the caller's own devices; returns the backend's success
  /// message. A failure throws `ApiException` with the backend's message.
  Future<String> sendTestPush();

  Future<ActivityPage> activity(int pageIndex, {String? action});

  Future<List<ReferenceOption>> roles();

  /// The interest group's `name` is the option's title.
  Future<List<ReferenceOption>> interestGroups();

  /// Empty below 2 characters, without a request.
  Future<List<ReferenceOption>> searchColleges(String query);
}
