import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/telemetry/crash_reporter.dart';
import 'package:mulearn_app/core/telemetry/error_hooks.dart';

import '../../support/recording_crash_reporter.dart';

void main() {
  late RecordingCrashReporter reporter;

  setUp(() {
    reporter = RecordingCrashReporter();
    final flutterHandler = FlutterError.onError;
    final presenter = FlutterError.presentError;
    final platformHandler = PlatformDispatcher.instance.onError;
    // Keep test output quiet; the hook still calls presentError.
    FlutterError.presentError = (_) {};
    addTearDown(() {
      FlutterError.onError = flutterHandler;
      FlutterError.presentError = presenter;
      PlatformDispatcher.instance.onError = platformHandler;
    });
  });

  test('PlatformDispatcher errors are recorded as fatal and handled', () {
    installErrorHooks(reporter);

    final handled = PlatformDispatcher.instance.onError!(StateError('x'), StackTrace.current);

    expect(handled, isTrue);
    expect(reporter.calls.single.fatal, isTrue);
    expect(reporter.calls.single.reason, 'PlatformDispatcher');
  });

  test('Flutter framework errors are recorded as fatal', () {
    installErrorHooks(reporter);

    FlutterError.onError!(FlutterErrorDetails(exception: StateError('y')));

    expect(reporter.calls.single.fatal, isTrue);
    expect(reporter.calls.single.reason, 'FlutterError');
  });

  test('a failing provider is recorded as non-fatal', () async {
    final failing = FutureProvider<int>((ref) async => throw StateError('boom'));
    final container = ProviderContainer(observers: [TelemetryProviderObserver(reporter)]);
    addTearDown(container.dispose);

    await expectLater(container.read(failing.future), throwsStateError);

    expect(reporter.calls, hasLength(1));
    expect(reporter.calls.single.fatal, isFalse);
    expect(reporter.calls.single.reason, startsWith('provider'));
  });

  test('the default reporter is the logging one until a provider is wired', () {
    expect(crashReporter, isA<LoggingCrashReporter>());
  });
}
