import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/notifications/presentation/providers/notifications_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_notifications.g.dart';

/// How long a fetched unread count is trusted before a trigger refetches it.
const Duration unreadStaleAfter = Duration(minutes: 5);

/// The unread badge (`GET /api/v1/notification/unread-count/`: unread,
/// non-archived personal rows; broadcasts aren't counted).
///
/// Never polled. About 70k members share one backend (user, 2026-11-13) and
/// the backend has no push or WebSocket for notifications, so the count is
/// fetched only on user-driven triggers:
/// - sign-in / cold start: this provider's build;
/// - app resume and Home becoming visible: [refreshIfStale];
/// - pull-to-refresh and opening the inbox: [refresh].
/// The inbox's own read/archive actions adjust it locally ([onRead],
/// [onAllRead], [onArchived]) instead of refetching. See
/// `docs/backend-and-ops-todo.md` (push) for the real-time fix.
@Riverpod(keepAlive: true, retry: noRetry)
class UnreadNotifications extends _$UnreadNotifications {
  DateTime? _fetchedAt;
  Future<void>? _inFlight;

  @override
  Future<int> build() async {
    final repository = ref.watch(notificationsRepositoryProvider);
    final now = ref.watch(clockProvider);
    _fetchedAt = null;
    _inFlight = null;
    if (!await ref.watch(appAuthControllerProvider.future)) return 0;
    final count = await repository.getUnreadCount();
    _fetchedAt = now();
    return count;
  }

  /// Fetches only if the last successful fetch is older than
  /// [unreadStaleAfter] (and none is under way).
  Future<void> refreshIfStale() {
    final fetchedAt = _fetchedAt;
    if (_inFlight != null) return _inFlight!;
    if (fetchedAt == null && state.isLoading) return Future.value(); // the first load is running
    if (fetchedAt != null && ref.read(clockProvider)().difference(fetchedAt) < unreadStaleAfter) {
      return Future.value();
    }
    return refresh();
  }

  /// Fetches now. Concurrent calls share one request; a failure keeps the
  /// last known count and isn't retried (the next trigger tries again).
  Future<void> refresh() => _inFlight ??= _fetch().whenComplete(() => _inFlight = null);

  Future<void> _fetch() async {
    if (ref.read(appAuthControllerProvider).value != true) return;
    final repository = ref.read(notificationsRepositoryProvider);
    final now = ref.read(clockProvider);
    try {
      final count = await repository.getUnreadCount();
      if (!ref.mounted) return;
      _fetchedAt = now();
      state = AsyncData(count);
    } on Object catch (e, st) {
      appLogger.w('Unread notification count unavailable; keeping the last value', error: e, stackTrace: st);
    }
  }

  /// One item was marked read.
  void onRead({required bool wasUnread, required bool isBroadcast}) {
    if (wasUnread && !isBroadcast) _adjust(-1);
  }

  /// One item was archived.
  void onArchived({required bool wasUnread, required bool isBroadcast}) {
    if (wasUnread && !isBroadcast) _adjust(-1);
  }

  /// Everything was marked read.
  void onAllRead() {
    if (state.hasValue) state = const AsyncData(0);
  }

  void _adjust(int delta) {
    final current = state.value;
    if (current == null) return;
    final next = current + delta;
    state = AsyncData(next < 0 ? 0 : next);
  }
}
