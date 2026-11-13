import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

/// One item of the merged notification feed — a personal notification or a
/// broadcast the user's audience matches. Pure-Dart domain entity (rules.md
/// §2).
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String title,
    required String description,
    required bool isBroadcast,
    required bool read,
    required DateTime createdAt,

    /// e.g. `LC_INVITE`, `EVENT_PUBLISHED`; null for broadcasts.
    String? type,

    /// e.g. `LC`, `EVENTS`, `KARMA`, `SYSTEM`.
    String? category,

    /// What the notification is about (`learning_circle`, `event`, ...) and
    /// its id; both null for broadcasts.
    String? entityType,
    String? entityId,

    /// A relative path or an https URL chosen by the sender, if any.
    String? redirectUrl,
  }) = _AppNotification;
}

/// One page of the feed.
typedef NotificationPage = ({List<AppNotification> items, bool hasNext});
