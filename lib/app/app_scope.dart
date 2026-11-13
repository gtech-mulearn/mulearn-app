import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:mulearn_app/core/telemetry/crash_reporter.dart';
import 'package:mulearn_app/core/telemetry/error_hooks.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';

/// The app's root [ProviderScope], used by `bootstrap`.
///
/// No provider is retried automatically ([noRetry]). Riverpod 3's default
/// retries a failure 10 times over about 38 s, keeping pull-to-refresh
/// spinning and sending the extra requests to a backend that is already
/// failing; about 70k members share it. A failure shows its error and Retry
/// at once instead (Plan 3 final review, Important 3).
ProviderScope appProviderScope({required Widget child, List<Override> overrides = const []}) => ProviderScope(
      retry: noRetry,
      observers: [TelemetryProviderObserver(crashReporter)],
      overrides: overrides,
      child: child,
    );
