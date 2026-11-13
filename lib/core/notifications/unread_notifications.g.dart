// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_notifications.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// `GET /api/v1/notification/unread-count/` → `{unread_count}`.

@ProviderFor(fetchUnreadCount)
const fetchUnreadCountProvider = FetchUnreadCountProvider._();

/// `GET /api/v1/notification/unread-count/` → `{unread_count}`.

final class FetchUnreadCountProvider
    extends
        $FunctionalProvider<
          Future<int> Function(),
          Future<int> Function(),
          Future<int> Function()
        >
    with $Provider<Future<int> Function()> {
  /// `GET /api/v1/notification/unread-count/` → `{unread_count}`.
  const FetchUnreadCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchUnreadCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchUnreadCountHash();

  @$internal
  @override
  $ProviderElement<Future<int> Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<int> Function() create(Ref ref) {
    return fetchUnreadCount(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<int> Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<int> Function()>(value),
    );
  }
}

String _$fetchUnreadCountHash() => r'6bd81b65f874d84681203f99e007957179c1221a';

/// The unread badge: unread, non-archived personal notifications
/// (`UnreadCountView`; broadcasts aren't counted). In core because Home and
/// the inbox both use it.
///
/// Never polled. About 70k members share one backend (user, 2026-11-13) and
/// the backend has no push or WebSocket for notifications, so the count is
/// fetched only on user-driven triggers:
/// - sign-in / cold start: this provider's build;
/// - app resume and the Home tab being selected: [refreshIfStale];
/// - pull-to-refresh and opening the inbox: [refresh].
/// The inbox's own read/archive actions adjust it locally ([onRead],
/// [onAllRead], [onArchived]) instead of refetching. Real-time updates need
/// push (`docs/backend-and-ops-todo.md`).

@ProviderFor(UnreadNotifications)
const unreadNotificationsProvider = UnreadNotificationsProvider._();

/// The unread badge: unread, non-archived personal notifications
/// (`UnreadCountView`; broadcasts aren't counted). In core because Home and
/// the inbox both use it.
///
/// Never polled. About 70k members share one backend (user, 2026-11-13) and
/// the backend has no push or WebSocket for notifications, so the count is
/// fetched only on user-driven triggers:
/// - sign-in / cold start: this provider's build;
/// - app resume and the Home tab being selected: [refreshIfStale];
/// - pull-to-refresh and opening the inbox: [refresh].
/// The inbox's own read/archive actions adjust it locally ([onRead],
/// [onAllRead], [onArchived]) instead of refetching. Real-time updates need
/// push (`docs/backend-and-ops-todo.md`).
final class UnreadNotificationsProvider
    extends $AsyncNotifierProvider<UnreadNotifications, int> {
  /// The unread badge: unread, non-archived personal notifications
  /// (`UnreadCountView`; broadcasts aren't counted). In core because Home and
  /// the inbox both use it.
  ///
  /// Never polled. About 70k members share one backend (user, 2026-11-13) and
  /// the backend has no push or WebSocket for notifications, so the count is
  /// fetched only on user-driven triggers:
  /// - sign-in / cold start: this provider's build;
  /// - app resume and the Home tab being selected: [refreshIfStale];
  /// - pull-to-refresh and opening the inbox: [refresh].
  /// The inbox's own read/archive actions adjust it locally ([onRead],
  /// [onAllRead], [onArchived]) instead of refetching. Real-time updates need
  /// push (`docs/backend-and-ops-todo.md`).
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
    r'a0ce99d3f60176590045b5cc56158ea682b8a493';

/// The unread badge: unread, non-archived personal notifications
/// (`UnreadCountView`; broadcasts aren't counted). In core because Home and
/// the inbox both use it.
///
/// Never polled. About 70k members share one backend (user, 2026-11-13) and
/// the backend has no push or WebSocket for notifications, so the count is
/// fetched only on user-driven triggers:
/// - sign-in / cold start: this provider's build;
/// - app resume and the Home tab being selected: [refreshIfStale];
/// - pull-to-refresh and opening the inbox: [refresh].
/// The inbox's own read/archive actions adjust it locally ([onRead],
/// [onAllRead], [onArchived]) instead of refetching. Real-time updates need
/// push (`docs/backend-and-ops-todo.md`).

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
