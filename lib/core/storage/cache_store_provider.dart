import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
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

/// Builds the Hive-backed store for a resolved on-disk [directoryPath].
CacheStore buildHiveCacheStore(String directoryPath) =>
    HiveCacheStore(directoryPath, hiveBoxName: 'mulearn_http_cache');
