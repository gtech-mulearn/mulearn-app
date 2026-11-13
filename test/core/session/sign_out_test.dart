import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

class MockCacheStore extends Mock implements CacheStore {}

/// Authserver LogoutAPIView: POST /api/v1/auth/logout/ {refreshToken}
/// revokes every refresh token issued before it (verified live on dev:
/// a later get-access-token gets "Token has been invalidated").
void main() {
  late TokenStorage tokens;
  late MockCacheStore cache;

  setUp(() async {
    tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    cache = MockCacheStore();
    when(cache.clean).thenAnswer((_) async {});
  });

  ProviderContainer containerWith(FakeHttpAdapter adapter) {
    final container = ProviderContainer(overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      cacheStoreProvider.overrideWithValue(cache),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  const ok = FakeResponse(200, {
    'hasError': false,
    'statusCode': 200,
    'message': {'general': ['Logged out successfully']},
    'response': <String, dynamic>{},
  });

  test('sign-out revokes the refresh token on the server, then clears everything', () async {
    final adapter = FakeHttpAdapter({'POST /api/v1/auth/logout/': (_) => ok});
    final c = containerWith(adapter);
    await c.read(appAuthControllerProvider.future);

    await c.read(sessionActionsProvider.notifier).signOut();

    expect(adapter.requests.single.data, {'refreshToken': 'r'});
    expect(await tokens.readAccessToken(), isNull);
    expect(await tokens.readRefreshToken(), isNull);
    verify(cache.clean).called(1);
    expect(c.read(appAuthControllerProvider).value, isFalse);
  });

  test('sign-out flips the router state before any network call', () async {
    late ProviderContainer c;
    bool? signedInDuringLogout;
    final adapter = FakeHttpAdapter({
      'POST /api/v1/auth/logout/': (_) {
        signedInDuringLogout = c.read(appAuthControllerProvider).value;
        return ok;
      },
    });
    c = containerWith(adapter);
    await c.read(appAuthControllerProvider.future);

    await c.read(sessionActionsProvider.notifier).signOut();

    expect(signedInDuringLogout, isFalse);
  });

  test('sign-out clears the local session before the server call', () async {
    // A slow revoke must not leave this device signed in (app killed
    // mid-call), nor wipe the next user's tokens when it finally returns.
    late FakeSecureStorage storage;
    storage = FakeSecureStorage();
    tokens = TokenStorage(storage);
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    Map<String, String>? storedDuringLogout;
    var cacheCleanedBeforeLogout = false;
    var logoutCalled = false;
    when(cache.clean).thenAnswer((_) async => cacheCleanedBeforeLogout = !logoutCalled);
    final adapter = FakeHttpAdapter({
      'POST /api/v1/auth/logout/': (_) {
        logoutCalled = true;
        storedDuringLogout = Map.of(storage.values);
        return ok;
      },
    });
    final c = containerWith(adapter);
    await c.read(appAuthControllerProvider.future);

    await c.read(sessionActionsProvider.notifier).signOut();

    expect(adapter.requests.single.data, {'refreshToken': 'r'});
    expect(storedDuringLogout, isEmpty);
    expect(cacheCleanedBeforeLogout, isTrue);
  });

  test('sign-out still clears locally when the logout call fails', () async {
    final c = containerWith(FakeHttpAdapter({'POST /api/v1/auth/logout/': (_) => const FakeResponse(-1, null)}));
    await c.read(appAuthControllerProvider.future);

    await c.read(sessionActionsProvider.notifier).signOut();

    expect(await tokens.readRefreshToken(), isNull);
    verify(cache.clean).called(1);
  });

  test('sign-out with no stored session skips the server call', () async {
    await tokens.clear();
    final adapter = FakeHttpAdapter({});
    final c = containerWith(adapter);

    await c.read(sessionActionsProvider.notifier).signOut();

    expect(adapter.requests, isEmpty);
    verify(cache.clean).called(1);
  });
}
