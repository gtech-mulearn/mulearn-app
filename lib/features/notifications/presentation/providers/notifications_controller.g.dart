// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The inbox, page by page. Lives only while the Notifications screen is
/// open: it loads on open, on pull-to-refresh and on scroll-to-end, and never
/// refetches in the background (no polling; Plan 3 Global Constraints).
///
/// Read and archive are optimistic and roll back on failure, rethrowing the
/// backend's error for the screen's toast. The badge is adjusted locally
/// through [UnreadNotifications], so these actions cost no extra count
/// request.

@ProviderFor(NotificationsController)
const notificationsControllerProvider = NotificationsControllerProvider._();

/// The inbox, page by page. Lives only while the Notifications screen is
/// open: it loads on open, on pull-to-refresh and on scroll-to-end, and never
/// refetches in the background (no polling; Plan 3 Global Constraints).
///
/// Read and archive are optimistic and roll back on failure, rethrowing the
/// backend's error for the screen's toast. The badge is adjusted locally
/// through [UnreadNotifications], so these actions cost no extra count
/// request.
final class NotificationsControllerProvider
    extends
        $AsyncNotifierProvider<
          NotificationsController,
          PagedState<AppNotification>
        > {
  /// The inbox, page by page. Lives only while the Notifications screen is
  /// open: it loads on open, on pull-to-refresh and on scroll-to-end, and never
  /// refetches in the background (no polling; Plan 3 Global Constraints).
  ///
  /// Read and archive are optimistic and roll back on failure, rethrowing the
  /// backend's error for the screen's toast. The badge is adjusted locally
  /// through [UnreadNotifications], so these actions cost no extra count
  /// request.
  const NotificationsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'notificationsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$notificationsControllerHash();

  @$internal
  @override
  NotificationsController create() => NotificationsController();
}

String _$notificationsControllerHash() =>
    r'a6ab0e0b108df842db7e7853b0266ba9c3362bf7';

/// The inbox, page by page. Lives only while the Notifications screen is
/// open: it loads on open, on pull-to-refresh and on scroll-to-end, and never
/// refetches in the background (no polling; Plan 3 Global Constraints).
///
/// Read and archive are optimistic and roll back on failure, rethrowing the
/// backend's error for the screen's toast. The badge is adjusted locally
/// through [UnreadNotifications], so these actions cost no extra count
/// request.

abstract class _$NotificationsController
    extends $AsyncNotifier<PagedState<AppNotification>> {
  FutureOr<PagedState<AppNotification>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<PagedState<AppNotification>>,
              PagedState<AppNotification>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<PagedState<AppNotification>>,
                PagedState<AppNotification>
              >,
              AsyncValue<PagedState<AppNotification>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
