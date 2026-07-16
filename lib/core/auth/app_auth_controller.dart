import 'package:mulearn_app/core/network/session_event_bus.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_auth_controller.g.dart';

/// Coarse, app-wide authentication signal used by the router (rules.md §4:
/// auth state is genuinely cross-feature, so it lives in `core/`, which is what
/// lets `core/router/` guard routes without importing `features/`).
///
/// The value is simply "is there a usable session?". It bootstraps from secure
/// storage on startup, and listens to the [SessionEventBus] so an unrecoverable
/// token-refresh failure (emitted by the auth interceptor) flips the app to
/// signed-out — which the router `redirect` picks up automatically.
///
/// The auth *feature* controller drives the transitions via [setSignedIn] /
/// [setSignedOut] after performing the actual sign-in/out work.
@Riverpod(keepAlive: true)
class AppAuthController extends _$AppAuthController {
  @override
  Future<bool> build() async {
    final bus = ref.watch(sessionEventBusProvider);
    final sub = bus.events.listen((event) {
      if (event == SessionEvent.expired) {
        state = const AsyncData(false);
      }
    });
    ref.onDispose(sub.cancel);

    return ref.watch(tokenStorageProvider).hasSession();
  }

  void setSignedIn() => state = const AsyncData(true);
  void setSignedOut() => state = const AsyncData(false);
}
