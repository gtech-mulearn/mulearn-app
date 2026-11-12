import 'package:mulearn_app/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:mulearn_app/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notifications_controller.g.dart';

@riverpod
NotificationsRemoteDataSource notificationsRemoteDataSource(Ref ref) =>
    const NotificationsRemoteDataSource();

/// Presentation depends on the [NotificationsRepository] contract
/// (rules.md §2/§5).
@riverpod
NotificationsRepository notificationsRepository(Ref ref) =>
    NotificationsRepositoryImpl(ref.watch(notificationsRemoteDataSourceProvider));

/// The notification inbox, plus its own mutations (mirrors
/// `CircleActionsController`'s single-notifier-per-feature pattern) — mark
/// all read (repository round-trip, then a self-refresh) and mark-one-read
/// (an optimistic local update, since there's no backend to persist
/// per-item read-state to yet either).
@riverpod
class NotificationsController extends _$NotificationsController {
  @override
  Future<List<AppNotification>> build() =>
      ref.watch(notificationsRepositoryProvider).getNotifications();

  Future<void> markAllRead() async {
    await ref.read(notificationsRepositoryProvider).markAllRead();
    ref.invalidateSelf();
    await future;
  }

  void markRead(String id) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData([
      for (final notification in current)
        if (notification.id == id) notification.copyWith(read: true) else notification,
    ]);
  }
}
