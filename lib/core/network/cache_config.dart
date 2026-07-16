import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

/// HTTP-response cache policy (architecture §12).
///
/// The interceptor built from these options is placed *before* the auth
/// interceptor in the Dio chain, so a cache hit skips token attach/refresh
/// entirely. TTL is per-endpoint, not global — honor server `Cache-Control` by
/// default and override [CacheOptions] per-request where a resource needs a
/// tighter/looser policy. This build only needs the base policy in place; the
/// leaderboard/profile-specific tuning comes with those features.
abstract final class CacheConfig {
  const CacheConfig._();

  static CacheOptions base(CacheStore store) => CacheOptions(
        store: store,
        // Honor server Cache-Control headers by default (CachePolicy.request).
        // Serve stale cache on network failure, but never for auth errors.
        hitCacheOnErrorExcept: const [401, 403],
        maxStale: const Duration(days: 3),
      );
}
