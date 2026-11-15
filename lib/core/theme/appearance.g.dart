// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// System, Light or Dark (artifact Screen patterns → Settings →
/// Appearance). Follows the phone until the person picks otherwise; the
/// choice is remembered on this device.

@ProviderFor(Appearance)
final appearanceProvider = AppearanceProvider._();

/// System, Light or Dark (artifact Screen patterns → Settings →
/// Appearance). Follows the phone until the person picks otherwise; the
/// choice is remembered on this device.
final class AppearanceProvider
    extends $NotifierProvider<Appearance, ThemeMode> {
  /// System, Light or Dark (artifact Screen patterns → Settings →
  /// Appearance). Follows the phone until the person picks otherwise; the
  /// choice is remembered on this device.
  AppearanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appearanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appearanceHash();

  @$internal
  @override
  Appearance create() => Appearance();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appearanceHash() => r'dc879c5ef2e4c07a09c6a91d4be65bcea244a2f0';

/// System, Light or Dark (artifact Screen patterns → Settings →
/// Appearance). Follows the phone until the person picks otherwise; the
/// choice is remembered on this device.

abstract class _$Appearance extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
