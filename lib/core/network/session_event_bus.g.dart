// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_event_bus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sessionEventBus)
const sessionEventBusProvider = SessionEventBusProvider._();

final class SessionEventBusProvider
    extends
        $FunctionalProvider<SessionEventBus, SessionEventBus, SessionEventBus>
    with $Provider<SessionEventBus> {
  const SessionEventBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionEventBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionEventBusHash();

  @$internal
  @override
  $ProviderElement<SessionEventBus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SessionEventBus create(Ref ref) {
    return sessionEventBus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SessionEventBus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SessionEventBus>(value),
    );
  }
}

String _$sessionEventBusHash() => r'7b5fb1c4b622a6b03bc70d1b7dcade73c4b40c4c';
