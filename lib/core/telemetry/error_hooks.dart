import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mulearn_app/core/telemetry/crash_reporter.dart';

/// Routes every uncaught error to [reporter]: framework errors
/// ([FlutterError.onError], still shown via [FlutterError.presentError]) and
/// errors outside the framework ([PlatformDispatcher.onError], e.g. an
/// unawaited future). Called once from `bootstrap()`.
void installErrorHooks(CrashReporter reporter) {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    reporter.recordError(details.exception, details.stack, fatal: true, reason: 'FlutterError');
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    reporter.recordError(error, stackTrace, fatal: true, reason: 'PlatformDispatcher');
    return true;
  };
}

/// Reports every provider that fails (a thrown build, a failed future) as a
/// non-fatal error, so a failure a screen shows as an error state is still
/// visible in telemetry.
final class TelemetryProviderObserver extends ProviderObserver {
  TelemetryProviderObserver(this._reporter);

  final CrashReporter _reporter;

  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    final provider = context.provider;
    _reporter.recordError(
      error,
      stackTrace,
      fatal: false,
      reason: 'provider ${provider.name ?? provider.runtimeType}',
    );
  }
}
