import 'package:mulearn_app/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/repositories/notifications_repository.dart';

/// Thin pass-through to [NotificationsRemoteDataSource] (rules.md §2/§5).
/// No DTO layer — the datasource already deals in the domain entity
/// directly since there's no backend response shape to model yet.
class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._remote);

  final NotificationsRemoteDataSource _remote;

  @override
  Future<List<AppNotification>> getNotifications() => _remote.fetchNotifications();

  @override
  Future<void> markAllRead() => _remote.markAllRead();
}
