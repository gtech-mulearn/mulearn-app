import 'package:mulearn_app/core/telemetry/crash_reporter.dart';

/// Parses each item of a list response on its own: a malformed item is
/// skipped and reported (`reason: 'parse <what>'`) instead of failing the
/// whole list, and never dropped without a trace (spec §6, REL-03).
List<T> parseEachOrReport<T>(
  Iterable<dynamic> items,
  T Function(Map<String, dynamic> json) parse, {
  required String what,
}) {
  final parsed = <T>[];
  for (final item in items) {
    try {
      parsed.add(parse(item as Map<String, dynamic>));
    } on Object catch (e, st) {
      crashReporter.recordError(e, st, fatal: false, reason: 'parse $what');
    }
  }
  return parsed;
}
