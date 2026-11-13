import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:hive/hive.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:path_provider/path_provider.dart';

/// Opens the persistent (Hive) HTTP cache in the app's cache directory, so
/// cached responses survive a restart (PERF-04). If the directory can't be
/// used the app still starts, with an in-memory cache.
///
/// `HiveCacheStore` opens its box lazily, so a directory that exists but
/// can't hold the box would only fail later, on every request. The directory
/// is therefore proven writable and the box opened here first: only a store
/// whose box opened is returned. (Writability is checked before Hive is
/// asked, because a failed `Hive.openLazyBox` also leaves an unhandled error
/// behind.)
Future<CacheStore> openCacheStore({
  Future<Directory> Function() directory = getApplicationCacheDirectory,
}) async {
  try {
    final dir = await directory();
    await _assertWritable(dir);
    Hive.init(dir.path);
    await Hive.openLazyBox<CacheResponse>(httpCacheBoxName);
    return buildHiveCacheStore(dir.path);
  } on Object catch (e, st) {
    appLogger.w('Persistent HTTP cache unavailable; using memory', error: e, stackTrace: st);
    return MemCacheStore();
  }
}

Future<void> _assertWritable(Directory dir) async {
  await dir.create(recursive: true);
  final probe = File('${dir.path}${Platform.pathSeparator}.mu_cache_probe');
  await probe.writeAsString('ok', flush: true);
  await probe.delete();
}
