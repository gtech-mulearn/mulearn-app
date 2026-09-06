import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_notification.freezed.dart';

/// What a notification is about — drives the icon-square color mapping on
/// [NotificationsScreen] (DESIGN_SPEC.md §2 "14 — Notifications").
enum NotificationKind {
  /// Karma awarded/approved on a task.
  karma,

  /// Level-up / level-progress nudge.
  level,

  /// Learning-circle activity (join requests, circle updates).
  circle,

  /// Event-related activity (reminders, registration, results).
  event,
}

/// A single notification inbox item — pure-Dart domain entity (rules.md
/// §2).
@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required NotificationKind kind,
    required String title,
    required String body,
    required DateTime timestamp,
    required bool read,

    /// Route to push when tapped, e.g. [RoutePaths.profile]. Null when the
    /// notification has no associated destination.
    String? targetRoute,
  }) = _AppNotification;
}
