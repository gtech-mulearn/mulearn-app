import 'dart:convert';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/auth/jwt_claims.dart';
import 'package:mulearn_app/core/network/cache_config.dart';
import 'package:mulearn_app/core/network/cache_scope_interceptor.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

/// An unsigned JWT carrying an `id` claim, like the authserver's tokens.
String jwtFor(String id) {
  String part(Map<String, Object> json) =>
      base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'HS256'})}.${part({'id': id, 'muid': '$id@mulearn'})}.sig';
}

void main() {
  test('jwtClaim reads a claim and tolerates malformed tokens', () {
    expect(jwtClaim(jwtFor('u1'), 'id'), 'u1');
    expect(jwtClaim('not-a-jwt', 'id'), isNull);
    expect(jwtClaim('a.%%%.c', 'id'), isNull);
  });

  test('cache keys differ per user for the same URL', () {
    final url = Uri.parse(
      'https://dev.mulearn.org/api/v1/leaderboard/students/',
    );
    final scope = CacheScope();
    final key = CacheConfig.keyBuilder(scope);

    expect(key(url: url), startsWith('anon|'));
    scope.current = 'u1';
    final u1 = key(url: url);
    scope.current = 'u2';
    expect(key(url: url), isNot(u1));
  });

  test('a response cached for one user is not served to another', () async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: jwtFor('user-a'), refreshToken: 'r');
    final adapter = FakeHttpAdapter({
      'GET /api/v1/leaderboard/students/': (_) => const FakeResponse(200, {
        'hasError': false,
        'statusCode': 200,
        'message': {'general': <String>[]},
        'response': <Object>[],
      }),
    });
    final scope = CacheScope();
    final dio = fakeDio(adapter)
      ..interceptors.addAll([
        CacheScopeInterceptor(tokens, scope),
        DioCacheInterceptor(
          options: CacheConfig.leaderboard(MemCacheStore(), scope),
        ),
      ]);

    await dio.get<dynamic>('/api/v1/leaderboard/students/');
    await dio.get<dynamic>('/api/v1/leaderboard/students/');
    expect(
      adapter.requests,
      hasLength(1),
      reason: 'the same user is served from cache',
    );

    await tokens.saveTokens(accessToken: jwtFor('user-b'), refreshToken: 'r');
    await dio.get<dynamic>('/api/v1/leaderboard/students/');
    expect(
      adapter.requests,
      hasLength(2),
      reason: "user B never gets user A's cached response",
    );
  });
}
