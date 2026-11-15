import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cache_store_provider.g.dart';

/// Persistent HTTP-response cache store (Hive-backed) for
/// `dio_cache_interceptor` — rules.md §1, architecture §12.
///
/// The path is resolved once during bootstrap and passed in via an override,
/// so this provider itself stays free of `path_provider`/`WidgetsBinding`
/// plumbing and is trivial to override in tests with a [MemCacheStore].
@Riverpod(keepAlive: true)
CacheStore cacheStore(Ref ref) => throw UnimplementedError(
  'cacheStoreProvider must be overridden in bootstrap() with a concrete '
  'HiveCacheStore (or a MemCacheStore in tests).',
);

/// The Hive box that holds cached HTTP responses. `_v2` since the move to
/// http_cache_hive_store (hive_ce): the old box's records were written by
/// the previous store's adapters, so it's left behind, unread, in the OS
/// cache directory rather than decoded by the new one.
const String httpCacheBoxName = 'mulearn_http_cache_v2';

/// Builds the Hive-backed store for a resolved on-disk [directoryPath].
CacheStore buildHiveCacheStore(String directoryPath) =>
    HiveCacheStore(directoryPath, hiveBoxName: httpCacheBoxName);
