import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/network/cache_scope_interceptor.dart';

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

  /// Cache key = the request's user scope ([CacheScopeInterceptor]) + the
  /// library's default key (method + URL + query), so entries are per user.
  static String keyBuilder(RequestOptions request) =>
      '${request.extra[CacheScopeInterceptor.extraKey] ?? 'anon'}|${CacheOptions.defaultCacheKeyBuilder(request)}';

  static CacheOptions base(CacheStore store) => CacheOptions(
        store: store,
        keyBuilder: keyBuilder,
        // Honor server Cache-Control headers by default (CachePolicy.request).
        // Serve stale cache on network failure, but never for auth errors.
        hitCacheOnErrorExcept: const [401, 403],
        maxStale: const Duration(days: 3),
      );

  /// Client-side cache for the leaderboard endpoints — confirmed live
  /// (rules.md §3) that `/leaderboard/students/` and `/leaderboard/college/`
  /// send no `Cache-Control` header at all (unlike e.g. the interest-groups
  /// catalog, which sends `max-age=600`), so [base]'s server-driven
  /// `CachePolicy.request` never caches these: every visit re-runs the
  /// backend's multi-query aggregation (~100ms+, 4 SQL queries per the
  /// `Server-Timing` header), including on the Students/Colleges and
  /// This-month/All-time toggles on `LeaderboardScreen`, each of which
  /// disposes and recreates the relevant `autoDispose` provider. `forceCache`
  /// ignores the missing header and caches anyway for [maxStale]; a genuine
  /// error (not just a stale cache entry) still falls through to the network
  /// as usual.
  static CacheOptions leaderboard(CacheStore store) => CacheOptions(
        store: store,
        keyBuilder: keyBuilder,
        policy: CachePolicy.forceCache,
        hitCacheOnErrorExcept: const [401, 403],
        maxStale: const Duration(minutes: 3),
      );
}
