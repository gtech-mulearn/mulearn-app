import 'package:freezed_annotation/freezed_annotation.dart';

part 'announcement.freezed.dart';

/// Where an announcement came from (`broadcast_source` in the backend).
enum AnnouncementSource { team, learningCircle, event, project, system }

/// One announcement (a broadcast notification) as the team manages it.
@freezed
abstract class Announcement with _$Announcement {
  const factory Announcement({
    required String id,
    required String title,
    required String description,
    required String targetType,
    required AnnouncementSource source,
    required DateTime createdAt,
    required DateTime expiresAt,
    String? url,
    String? targetName,
    String? createdByName,
  }) = _Announcement;
}

/// One page of announcements; [total] is the backend's `count`.
typedef AnnouncementPage = ({
  List<Announcement> items,
  bool hasNext,
  int total,
});
