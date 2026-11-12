import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/repositories/auth_repository_impl.dart';

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
    when(() => cache.clean()).thenAnswer((_) async {});
  });

  AuthRepositoryImpl repoWith(FakeHttpAdapter adapter) => AuthRepositoryImpl(
        remote: AuthRemoteDataSource(fakeDio(adapter)),
        tokenStorage: tokens,
        cacheStore: cache,
      );

  test('sign-out revokes the refresh token on the server, then clears everything', () async {
    final adapter = FakeHttpAdapter({
      'POST /api/v1/auth/logout/': (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': ['Logged out successfully']},
            'response': <String, dynamic>{},
          }),
    });

    await repoWith(adapter).signOut();

    expect(adapter.requests.single.data, {'refreshToken': 'r'});
    expect(await tokens.readAccessToken(), isNull);
    expect(await tokens.readRefreshToken(), isNull);
    verify(() => cache.clean()).called(1);
  });

  test('sign-out still clears locally when the logout call fails', () async {
    final adapter = FakeHttpAdapter({
      'POST /api/v1/auth/logout/': (_) => const FakeResponse(-1, null),
    });

    await repoWith(adapter).signOut();

    expect(await tokens.readRefreshToken(), isNull);
    verify(() => cache.clean()).called(1);
  });

  test('sign-out with no stored session skips the server call', () async {
    await tokens.clear();
    final adapter = FakeHttpAdapter({});

    await repoWith(adapter).signOut();

    expect(adapter.requests, isEmpty);
    verify(() => cache.clean()).called(1);
  });
}
