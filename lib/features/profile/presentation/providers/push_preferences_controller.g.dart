// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_preferences_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's push settings (Settings → Notifications).

@ProviderFor(PushPreferencesController)
final pushPreferencesControllerProvider = PushPreferencesControllerProvider._();

/// The user's push settings (Settings → Notifications).
final class PushPreferencesControllerProvider
    extends $AsyncNotifierProvider<PushPreferencesController, PushPreferences> {
  /// The user's push settings (Settings → Notifications).
  PushPreferencesControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'pushPreferencesControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushPreferencesControllerHash();

  @$internal
  @override
  PushPreferencesController create() => PushPreferencesController();
}

String _$pushPreferencesControllerHash() =>
    r'ad72d1bdf7886fc4d31ce16cf00994155ddbc116';

/// The user's push settings (Settings → Notifications).

abstract class _$PushPreferencesController
    extends $AsyncNotifier<PushPreferences> {
  FutureOr<PushPreferences> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PushPreferences>, PushPreferences>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PushPreferences>, PushPreferences>,
              AsyncValue<PushPreferences>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
