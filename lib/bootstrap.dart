import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/app/app.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';

/// Shared entrypoint used by every flavor's `main_*.dart` (architecture §2).
///
/// Initializes the flavor config, wires up shared services, and runs the app
/// inside a [ProviderScope].
Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = FlavorConfig.initialize(flavor);
  appLogger.i('Booting μLearn (${config.flavor.name}) → ${config.apiBaseUrl}');

  FlutterError.onError = (details) {
    appLogger.e(
      'FlutterError',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  // HTTP response cache store.
  //
  // TODO(cache): swap to the persistent Hive store (buildHiveCacheStore) once
  // caching is wired in depth — that needs a writable directory via
  // `path_provider`, which isn't a dependency yet (build prompt §5 defers deep
  // caching; scope discipline / rules.md §9 defers adding the package). An
  // in-memory store is enough to "get the dependency in place" for this build.
  final CacheStore cacheStore = MemCacheStore();

  runApp(
    ProviderScope(
      overrides: [
        cacheStoreProvider.overrideWithValue(cacheStore),
      ],
      child: const MulearnApp(),
    ),
  );
}
