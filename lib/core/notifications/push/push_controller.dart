import 'dart:async';
import 'dart:io' show Platform;

import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/config/app_version.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/notifications/push/push_messaging.dart';
import 'package:mulearn_app/core/notifications/push/push_remote_datasource.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'push_controller.g.dart';

/// The device side: Firebase in builds that have its config, a no-op
/// otherwise (the app works the same, just without pushes).
@Riverpod(keepAlive: true)
PushMessaging pushMessaging(Ref ref) => FirebasePushMessaging.firebaseReady
    ? FirebasePushMessaging()
    : const NoopPushMessaging();

@Riverpod(keepAlive: true)
PushRemoteDataSource pushRemoteDataSource(Ref ref) =>
    PushRemoteDataSource(ref.watch(dioProvider));

/// What the app can do about pushes on this device right now.
enum PushStatus {
  /// No Firebase config in this build.
  unavailable,

  /// The system hasn't been asked yet (Android 13+ / iOS).
  notDetermined,
  granted,

  /// The user said no; only system settings can change it.
  denied,
}

/// Owns this device's push registration.
///
/// - Signed in with permission: registers the FCM token with the backend
///   once per app start, and again whenever FCM rotates it.
/// - Never asks for permission by itself: [requestPermission] runs from a
///   user action (the "Turn on notifications" tile).
/// - [unregisterForSignOut] runs before the session is cleared.
@Riverpod(keepAlive: true)
class PushController extends _$PushController {
  String? _registered;

  @override
  Future<PushStatus> build() async {
    final messaging = ref.watch(pushMessagingProvider);
    if (!messaging.available) return PushStatus.unavailable;
    try {
      await messaging.init();
    } on Object catch (e, st) {
      appLogger.w(
        'push: init failed; pushes stay off',
        error: e,
        stackTrace: st,
      );
      return PushStatus.unavailable;
    }
    final refresh = messaging.tokenRefresh.listen((_) {
      _registered = null;
      unawaited(sync());
    });
    ref
      ..onDispose(refresh.cancel)
      ..listen(appAuthControllerProvider, (previous, next) {
        if (next.value ?? false) unawaited(sync());
        if (next.value == false) _registered = null;
      });
    final status = _fromPermission(await messaging.permission());
    if (status == PushStatus.granted) unawaited(sync());
    return status;
  }

  static PushStatus _fromPermission(PushPermission p) => switch (p) {
    PushPermission.granted => PushStatus.granted,
    PushPermission.denied => PushStatus.denied,
    PushPermission.notDetermined => PushStatus.notDetermined,
  };

  Future<void>? _syncing;

  /// Registers this device's token for the signed-in user, if allowed.
  /// Concurrent calls (app start, sign-in, token refresh) share one request.
  Future<void> sync() =>
      _syncing ??= _sync().whenComplete(() => _syncing = null);

  Future<void> _sync() async {
    final messaging = ref.read(pushMessagingProvider);
    if (!messaging.available) return;
    final signedIn = ref.read(appAuthControllerProvider).value ?? false;
    if (!signedIn) return;
    if (await messaging.permission() != PushPermission.granted) return;
    try {
      final token = await messaging.token();
      if (token == null || token.isEmpty || token == _registered) return;
      final version = await ref.read(appVersionProvider.future);
      await ref
          .read(pushRemoteDataSourceProvider)
          .registerDevice(
            token: token,
            platform: Platform.isIOS ? 'ios' : 'android',
            appVersion: version.name,
          );
      _registered = token;
    } on Object catch (e) {
      // Offline or server busy: the next app start or token refresh retries.
      appLogger.w('push: device registration failed', error: e);
    }
  }

  /// Shows the system prompt (or reports the current answer).
  Future<PushStatus> requestPermission() async {
    final messaging = ref.read(pushMessagingProvider);
    if (!messaging.available) return PushStatus.unavailable;
    final status = _fromPermission(await messaging.requestPermission());
    state = AsyncData(status);
    if (status == PushStatus.granted) await sync();
    return status;
  }

  /// Before sign-out clears the session: tell the server to stop pushing to
  /// this device, then drop the token so a shared phone never receives the
  /// previous account's pushes even if the server call failed.
  Future<void> unregisterForSignOut() async {
    final messaging = ref.read(pushMessagingProvider);
    if (!messaging.available) return;
    try {
      final token = await messaging.token();
      if (token != null && token.isNotEmpty) {
        await ref
            .read(pushRemoteDataSourceProvider)
            .unregisterDevice(token)
            .timeout(const Duration(seconds: 3));
      }
    } on Object catch (e) {
      appLogger.w('push: unregister on sign-out failed', error: e);
    }
    try {
      await messaging.deleteToken();
    } on Object catch (e) {
      appLogger.w('push: deleting the FCM token failed', error: e);
    }
    _registered = null;
  }
}
