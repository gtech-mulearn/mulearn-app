import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';

/// Notifications repository contract (rules.md §2/§5). Failures throw
/// `ApiException` with the backend's message.
abstract interface class NotificationsRepository {
  /// One page of the merged feed, newest first. [page] starts at 1.
  Future<NotificationPage> getPage(int page);

  Future<void> markRead(String id);

  Future<void> markAllRead();

  Future<void> archive(String id);
}
