import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';

/// Notifications datasource.
///
/// No backend endpoint exists yet for notifications — there's nothing in
/// `ApiPaths`, no FCM/push package in `pubspec.yaml`, no server-side feed to
/// call. This class is the single, clearly-documented placeholder for that
/// gap: it returns an empty list until a real `notifications` endpoint is
/// added, at which point only this file (plus `markAllRead`) needs to
/// change — the rest of the feature (entity, repository contract,
/// controller, screen) is already real and doesn't fake any content.
class NotificationsRemoteDataSource {
  const NotificationsRemoteDataSource();

  /// No backend endpoint exists yet for notifications. Returns an empty
  /// list until one is added.
  Future<List<AppNotification>> fetchNotifications() async => const [];

  /// No backend endpoint exists yet to persist read-state. No-op until one
  /// is added.
  Future<void> markAllRead() async {}
}
