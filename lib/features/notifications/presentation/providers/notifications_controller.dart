import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/notifications/unread_notifications.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/notifications_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

export 'notifications_repository_provider.dart';

part 'notifications_controller.g.dart';

/// The inbox, page by page. Lives only while the Notifications screen is
/// open: it loads on open, on pull-to-refresh and on scroll-to-end, and never
/// refetches in the background (no polling; Plan 3 Global Constraints).
///
/// Read and archive are optimistic and roll back on failure, rethrowing the
/// backend's error for the screen's toast. The badge is adjusted locally
/// through [UnreadNotifications], so these actions cost no extra count
/// request.
@Riverpod(retry: noRetry)
class NotificationsController extends _$NotificationsController {
  int _page = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<AppNotification>> build() async {
    _page = 1;
    _inFlight = null;
    final page = await ref.watch(notificationsRepositoryProvider).getPage(1);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  /// Refetches page 1. On failure the loaded items stay and the error is
  /// rethrown (pull-to-refresh shows it as a toast).
  Future<void> refresh() async {
    final repository = ref.read(notificationsRepositoryProvider);
    final page = await repository.getPage(1);
    if (!ref.mounted) return;
    _page = 1;
    state = AsyncData(PagedState(items: page.items, hasMore: page.hasNext));
  }

  /// Loads the next page, or retries it after a failure. Calls made while a
  /// page is in flight share that request.
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    final repository = ref.read(notificationsRepositoryProvider);
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _page + 1;
    try {
      final page = await repository.getPage(next);
      if (!ref.mounted) return;
      _page = next;
      state = AsyncData(PagedState(
        items: mergeUniqueBy(current.items, page.items, (n) => n.id),
        hasMore: page.hasNext,
      ));
    } on Object catch (e, st) {
      appLogger.w('Loading more notifications failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }

  /// Marks one item read. Already-read items send nothing.
  Future<void> markRead(String id) async {
    final current = state.value;
    final index = current?.items.indexWhere((n) => n.id == id) ?? -1;
    if (current == null || index < 0 || current.items[index].read) return;
    final target = current.items[index];
    final repository = ref.read(notificationsRepositoryProvider);
    final unread = ref.read(unreadNotificationsProvider.notifier);
    _replace(index, target.copyWith(read: true));
    try {
      await repository.markRead(id);
      unread.onRead(wasUnread: true, isBroadcast: target.isBroadcast);
    } on Object {
      if (ref.mounted) _replaceById(id, target);
      rethrow;
    }
  }

  /// Marks everything read on the server, then every loaded item.
  Future<void> markAllRead() async {
    final repository = ref.read(notificationsRepositoryProvider);
    final unread = ref.read(unreadNotificationsProvider.notifier);
    await repository.markAllRead();
    unread.onAllRead();
    if (!ref.mounted) return;
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(items: [for (final n in current.items) n.copyWith(read: true)]));
  }

  /// Hides one item; it comes back at its place if the server refuses.
  Future<void> archive(String id) async {
    final current = state.value;
    final index = current?.items.indexWhere((n) => n.id == id) ?? -1;
    if (current == null || index < 0) return;
    final target = current.items[index];
    final repository = ref.read(notificationsRepositoryProvider);
    final unread = ref.read(unreadNotificationsProvider.notifier);
    state = AsyncData(current.copyWith(items: [...current.items]..removeAt(index)));
    try {
      await repository.archive(id);
      unread.onArchived(wasUnread: !target.read, isBroadcast: target.isBroadcast);
    } on Object {
      if (ref.mounted) {
        final now = state.value;
        if (now != null && now.items.every((n) => n.id != id)) {
          final at = index.clamp(0, now.items.length);
          state = AsyncData(now.copyWith(items: [...now.items]..insert(at, target)));
        }
      }
      rethrow;
    }
  }

  void _replace(int index, AppNotification value) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(items: [...current.items]..[index] = value));
  }

  void _replaceById(String id, AppNotification value) {
    final current = state.value;
    final index = current?.items.indexWhere((n) => n.id == id) ?? -1;
    if (index >= 0) _replace(index, value);
  }
}
