import 'package:logger/logger.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';

/// Shared logger — use this instead of `print()` (rules.md §7).
///
/// Verbose in dev, warnings-and-above in prod.
final AppLogger appLogger = AppLogger._();

class AppLogger {
  AppLogger._()
      : _logger = Logger(
          filter: _MulearnLogFilter(),
          printer: PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 6,
            lineLength: 100,
          ),
        );

  final Logger _logger;

  void d(Object? message) => _logger.d(message);
  void i(Object? message) => _logger.i(message);
  void w(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(message, error: error, stackTrace: stackTrace);
  void e(Object? message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

class _MulearnLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    final isDev =
        !FlavorConfig.isInitialized || FlavorConfig.instance.isDev;
    return isDev || event.level.index >= Level.warning.index;
  }
}
