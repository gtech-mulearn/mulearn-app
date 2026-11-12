import 'package:dio/dio.dart';
import 'package:mulearn_app/core/auth/jwt_claims.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

/// Tags every request with the signed-in user's id (or `anon`) so the HTTP
/// cache keys entries per user ([CacheConfig.keyBuilder]) — one account's
/// cached responses are never served to another on the same device.
///
/// Must run before the cache interceptor (which runs before auth, so it
/// can't see the Authorization header itself).
class CacheScopeInterceptor extends Interceptor {
  CacheScopeInterceptor(this._tokenStorage);

  /// `RequestOptions.extra` key holding the scope.
  static const extraKey = 'mu_cache_scope';

  final TokenStorage _tokenStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.readAccessToken();
    options.extra[extraKey] = (token == null ? null : jwtClaim(token, 'id')) ?? 'anon';
    handler.next(options);
  }
}
