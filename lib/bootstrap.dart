import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/app/app.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/storage/cache_store_factory.dart';
import 'package:mulearn_app/core/storage/cache_store_provider.dart';
import 'package:mulearn_app/core/telemetry/crash_reporter.dart';
import 'package:mulearn_app/core/telemetry/error_hooks.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';

/// Shared entrypoint used by every flavor's `main_*.dart` (architecture §2).
///
/// Initializes the flavor config, wires up shared services, and runs the app
/// inside a [ProviderScope].
Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  final config = FlavorConfig.initialize(flavor);
  appLogger.i('Booting μLearn (${config.flavor.name}) → ${config.apiBaseUrl}');

  installErrorHooks(crashReporter);

  // Persistent, user-scoped HTTP response cache (memory if the cache
  // directory can't be opened).
  final cacheStore = await openCacheStore();

  runApp(
    ProviderScope(
      observers: [TelemetryProviderObserver(crashReporter)],
      overrides: [
        cacheStoreProvider.overrideWithValue(cacheStore),
      ],
      child: const MulearnApp(),
    ),
  );
}
