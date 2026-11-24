import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/presentation/campaign_labels.dart';

/// How an announcement's origin reads in lists and on the detail.
String announcementSourceLabel(AnnouncementSource source) => switch (source) {
  AnnouncementSource.team => 'Team',
  AnnouncementSource.learningCircle => 'Learning circle',
  AnnouncementSource.event => 'Event',
  AnnouncementSource.project => 'Project',
  AnnouncementSource.system => 'System',
};

/// Who sees an announcement: everyone for a global one (the backend names
/// it "Global (All Users)"), else the target's name.
String announcementAudienceLabel(Announcement a) {
  if (a.targetType == 'global') return 'Everyone';
  final name = a.targetName;
  return name == null ? 'Everyone' : roleLabel(name);
}
