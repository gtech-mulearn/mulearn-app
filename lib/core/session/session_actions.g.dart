// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Session-wide actions any screen may trigger.

@ProviderFor(SessionActions)
final sessionActionsProvider = SessionActionsProvider._();

/// Session-wide actions any screen may trigger.
final class SessionActionsProvider
    extends $NotifierProvider<SessionActions, void> {
  /// Session-wide actions any screen may trigger.
  SessionActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionActionsHash();

  @$internal
  @override
  SessionActions create() => SessionActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$sessionActionsHash() => r'd80dd0b470dd7daa628259e49e1f8ba302c21d77';

/// Session-wide actions any screen may trigger.

abstract class _$SessionActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
