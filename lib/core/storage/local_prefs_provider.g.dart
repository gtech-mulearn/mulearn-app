// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_prefs_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Local, non-sensitive key/value store for small UI-state flags (e.g. "was
/// this popup already shown today") — kept separate from
/// `secure_storage_provider.dart`, which rules.md §1 reserves for tokens
/// only. `shared_preferences` is a new dependency added for this, flagged
/// per rules.md §9 rather than pulled in silently.
///
/// [SharedPreferencesAsync] needs no `getInstance()`/init step (unlike the
/// older `SharedPreferences` API), so this provider can stay synchronous.

@ProviderFor(localPrefs)
const localPrefsProvider = LocalPrefsProvider._();

/// Local, non-sensitive key/value store for small UI-state flags (e.g. "was
/// this popup already shown today") — kept separate from
/// `secure_storage_provider.dart`, which rules.md §1 reserves for tokens
/// only. `shared_preferences` is a new dependency added for this, flagged
/// per rules.md §9 rather than pulled in silently.
///
/// [SharedPreferencesAsync] needs no `getInstance()`/init step (unlike the
/// older `SharedPreferences` API), so this provider can stay synchronous.

final class LocalPrefsProvider
    extends
        $FunctionalProvider<
          SharedPreferencesAsync,
          SharedPreferencesAsync,
          SharedPreferencesAsync
        >
    with $Provider<SharedPreferencesAsync> {
  /// Local, non-sensitive key/value store for small UI-state flags (e.g. "was
  /// this popup already shown today") — kept separate from
  /// `secure_storage_provider.dart`, which rules.md §1 reserves for tokens
  /// only. `shared_preferences` is a new dependency added for this, flagged
  /// per rules.md §9 rather than pulled in silently.
  ///
  /// [SharedPreferencesAsync] needs no `getInstance()`/init step (unlike the
  /// older `SharedPreferences` API), so this provider can stay synchronous.
  const LocalPrefsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localPrefsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localPrefsHash();

  @$internal
  @override
  $ProviderElement<SharedPreferencesAsync> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferencesAsync create(Ref ref) {
    return localPrefs(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferencesAsync value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferencesAsync>(value),
    );
  }
}

String _$localPrefsHash() => r'f89c0d88e8974ab3121584ca7253d909bc323fc5';
