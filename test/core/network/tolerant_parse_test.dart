import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/core/telemetry/crash_reporter.dart';

import '../../support/recording_crash_reporter.dart';

void main() {
  late RecordingCrashReporter reporter;

  setUp(() {
    reporter = RecordingCrashReporter();
    final previous = crashReporter;
    crashReporter = reporter;
    addTearDown(() => crashReporter = previous);
  });

  test('a malformed item is skipped and reported, the rest kept', () {
    final ids = parseEachOrReport<int>(
      [
        {'id': 1},
        {'bad': true},
        {'id': 3},
      ],
      (json) => json['id'] as int,
      what: 'Thing',
    );

    expect(ids, [1, 3]);
    expect(reporter.calls, hasLength(1));
    expect(reporter.calls.single.fatal, isFalse);
    expect(reporter.calls.single.reason, 'parse Thing');
  });

  test('a non-object item is skipped and reported too', () {
    final ids = parseEachOrReport<int>(['nope', {'id': 2}], (json) => json['id'] as int, what: 'Thing');

    expect(ids, [2]);
    expect(reporter.calls, hasLength(1));
  });
}
