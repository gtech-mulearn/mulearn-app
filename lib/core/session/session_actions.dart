import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_actions.g.dart';

/// Session-wide actions any screen may trigger.
@riverpod
class SessionActions extends _$SessionActions {
  @override
  void build() {}

  /// Signs out everywhere it matters:
  /// 1. flips the app to signed-out first, so the router redirects at once
  ///    and every user-scoped provider resets;
  /// 2. clears the stored tokens and the HTTP response cache, before any
  ///    network call, so a slow revoke can't leave this device signed in
  ///    (app killed mid-call) or wipe the next user's tokens on return;
  /// 3. revokes the refresh token on the server (best effort; a failure is
  ///    logged, never blocks; the call needs no access token).
  /// The access token stays valid server-side until it expires (15 min),
  /// which is why the local copy is always removed.
  Future<void> signOut() async {
    ref.read(appAuthControllerProvider.notifier).setSignedOut();
    final tokens = ref.read(tokenStorageProvider);
    final datasource = ref.read(sessionRemoteDataSourceProvider);
    final cache = ref.read(cacheStoreProvider);
    String? refreshToken;
    try {
      refreshToken = await tokens.readRefreshToken();
      await tokens.clear();
      await cache.clean();
    } on Object catch (e, st) {
      appLogger.e('Failed to clear local session on sign-out', error: e, stackTrace: st);
    }
    if (refreshToken == null || refreshToken.isEmpty) return;
    try {
      await datasource.logout(refreshToken);
    } on Object catch (e) {
      appLogger.w('Server logout failed; the session was already cleared locally', error: e);
    }
  }
}
