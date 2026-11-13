import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// The current time, as a provider so tests can drive it (staleness windows,
/// cut-offs) without waiting.
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
