import 'package:mulearn_app/core/utils/app_logger.dart';

/// Where unexpected errors go — a facade so a crash-reporting service
/// (Sentry, Crashlytics) can be plugged in later without touching callers.
/// Until an account exists the app uses [LoggingCrashReporter] (spec §10).
abstract interface class CrashReporter {
  /// Records [error]. [fatal] marks errors that escaped every handler;
  /// [reason] says where it came from (e.g. `parse EventDto`).
  void recordError(Object error, StackTrace? stackTrace, {required bool fatal, String? reason});
}

/// Writes reports to the app log: fatal ones as errors, the rest as warnings.
final class LoggingCrashReporter implements CrashReporter {
  const LoggingCrashReporter();

  @override
  void recordError(Object error, StackTrace? stackTrace, {required bool fatal, String? reason}) {
    final message = '${fatal ? 'Fatal' : 'Non-fatal'} error${reason == null ? '' : ' ($reason)'}';
    if (fatal) {
      appLogger.e(message, error: error, stackTrace: stackTrace);
    } else {
      appLogger.w(message, error: error, stackTrace: stackTrace);
    }
  }
}

/// The app-wide reporter. Replaced once at startup when a crash-reporting
/// service is configured; tests swap it for a recorder.
CrashReporter crashReporter = const LoggingCrashReporter();
