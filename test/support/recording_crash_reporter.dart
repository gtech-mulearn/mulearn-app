import 'package:mulearn_app/core/telemetry/crash_reporter.dart';

/// One [CrashReporter.recordError] call, as recorded by [RecordingCrashReporter].
typedef RecordedError = ({Object error, StackTrace? stackTrace, bool fatal, String? reason});

/// A [CrashReporter] test double that keeps every report.
class RecordingCrashReporter implements CrashReporter {
  final List<RecordedError> calls = [];

  @override
  void recordError(Object error, StackTrace? stackTrace, {required bool fatal, String? reason}) =>
      calls.add((error: error, stackTrace: stackTrace, fatal: fatal, reason: reason));
}
