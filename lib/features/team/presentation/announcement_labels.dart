import 'package:mulearn_app/features/team/domain/entities/announcement.dart';

/// How an announcement's origin reads in lists and on the detail.
String announcementSourceLabel(AnnouncementSource source) => switch (source) {
  AnnouncementSource.team => 'Team',
  AnnouncementSource.learningCircle => 'Learning circle',
  AnnouncementSource.event => 'Event',
  AnnouncementSource.project => 'Project',
  AnnouncementSource.system => 'System',
};
