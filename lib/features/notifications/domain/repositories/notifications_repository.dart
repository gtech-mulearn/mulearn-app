import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';

/// Notifications repository contract (rules.md §2/§5).
///
/// There is no backend `notifications` endpoint yet — see
/// [NotificationsRemoteDataSource] for the placeholder implementation this
/// contract is currently backed by. The contract itself is real and stable
/// so the presentation layer never has to change when a backend lands.
abstract interface class NotificationsRepository {
  /// All notifications for the current user, newest first.
  Future<List<AppNotification>> getNotifications();

  /// Marks every notification read. With no backend to persist read-state
  /// to, implementations may treat this as a local/no-op operation until a
  /// backend endpoint exists.
  Future<void> markAllRead();
}
