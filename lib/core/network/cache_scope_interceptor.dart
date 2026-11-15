import 'package:dio/dio.dart';
import 'package:mulearn_app/core/auth/jwt_claims.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

/// The user the HTTP cache is keyed for right now: the signed-in user's id,
/// or `anon`. [CacheScopeInterceptor] updates it on every request and
/// [CacheConfig.keyBuilder] prefixes every cache key with it.
/// (dio_cache_interceptor 4's key builder sees only the URL, headers and
/// body, not `RequestOptions.extra`, and a header would reach the server.)
class CacheScope {
  /// The current scope.
  String current = 'anon';
}

/// Tags every request with the signed-in user's id (or `anon`) so the HTTP
/// cache keys entries per user ([CacheConfig.keyBuilder]) — one account's
/// cached responses are never served to another on the same device. (Sign
/// out and an ended session also wipe the cache; this is the second line.)
///
/// Must run before the cache interceptor (which runs before auth, so it
/// can't see the Authorization header itself).
class CacheScopeInterceptor extends Interceptor {
  CacheScopeInterceptor(this._tokenStorage, this._scope);

  /// `RequestOptions.extra` key holding the scope.
  static const extraKey = 'mu_cache_scope';

  final TokenStorage _tokenStorage;
  final CacheScope _scope;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.readAccessToken();
    final scope = (token == null ? null : jwtClaim(token, 'id')) ?? 'anon';
    options.extra[extraKey] = scope;
    _scope.current = scope;
    handler.next(options);
  }
}
