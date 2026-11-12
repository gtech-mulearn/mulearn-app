// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_notifications.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(UnreadNotifications)
const unreadNotificationsProvider = UnreadNotificationsProvider._();

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
final class UnreadNotificationsProvider
    extends $AsyncNotifierProvider<UnreadNotifications, int> {
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
  const UnreadNotificationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'unreadNotificationsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unreadNotificationsHash();

  @$internal
  @override
  UnreadNotifications create() => UnreadNotifications();
}

String _$unreadNotificationsHash() =>
    r'cd767e6cfdfe80a2d20149a3436f667ba4b329c1';

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

abstract class _$UnreadNotifications extends $AsyncNotifier<int> {
  FutureOr<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
