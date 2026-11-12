import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:path_provider/path_provider.dart';

/// Opens the persistent (Hive) HTTP cache in the app's cache directory, so
/// cached responses survive a restart (PERF-04). If the directory can't be
/// opened the app still starts, with an in-memory cache.
Future<CacheStore> openCacheStore({
  Future<Directory> Function() directory = getApplicationCacheDirectory,
}) async {
  try {
    final dir = await directory();
    return buildHiveCacheStore(dir.path);
  } on Object catch (e, st) {
    appLogger.w('Persistent HTTP cache unavailable; using memory', error: e, stackTrace: st);
    return MemCacheStore();
  }
}
