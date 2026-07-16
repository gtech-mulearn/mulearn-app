// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secure_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Secure key/value store — tokens only (rules.md §1). Never put tokens in
/// SharedPreferences.
///
/// `useDataProtectionKeyChain: false` on macOS: the default (`true`) uses the
/// newer per-app "Data Protection Keychain", which requires a
/// `keychain-access-groups` entitlement tied to a real Apple Developer Team
/// signing identity — regardless of App Sandbox state. This project has no
/// real Team configured for local "Sign to Run Locally" builds, so writes
/// failed with `PlatformException(..., -34018 errSecMissingEntitlement, ...)`
/// even after disabling the sandbox (confirmed by reproducing the exact
/// failure live). Falling back to the legacy keychain avoids that entitlement
/// requirement entirely.

@ProviderFor(secureStorage)
const secureStorageProvider = SecureStorageProvider._();

/// Secure key/value store — tokens only (rules.md §1). Never put tokens in
/// SharedPreferences.
///
/// `useDataProtectionKeyChain: false` on macOS: the default (`true`) uses the
/// newer per-app "Data Protection Keychain", which requires a
/// `keychain-access-groups` entitlement tied to a real Apple Developer Team
/// signing identity — regardless of App Sandbox state. This project has no
/// real Team configured for local "Sign to Run Locally" builds, so writes
/// failed with `PlatformException(..., -34018 errSecMissingEntitlement, ...)`
/// even after disabling the sandbox (confirmed by reproducing the exact
/// failure live). Falling back to the legacy keychain avoids that entitlement
/// requirement entirely.

final class SecureStorageProvider
    extends
        $FunctionalProvider<
          FlutterSecureStorage,
          FlutterSecureStorage,
          FlutterSecureStorage
        >
    with $Provider<FlutterSecureStorage> {
  /// Secure key/value store — tokens only (rules.md §1). Never put tokens in
  /// SharedPreferences.
  ///
  /// `useDataProtectionKeyChain: false` on macOS: the default (`true`) uses the
  /// newer per-app "Data Protection Keychain", which requires a
  /// `keychain-access-groups` entitlement tied to a real Apple Developer Team
  /// signing identity — regardless of App Sandbox state. This project has no
  /// real Team configured for local "Sign to Run Locally" builds, so writes
  /// failed with `PlatformException(..., -34018 errSecMissingEntitlement, ...)`
  /// even after disabling the sandbox (confirmed by reproducing the exact
  /// failure live). Falling back to the legacy keychain avoids that entitlement
  /// requirement entirely.
  const SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $ProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FlutterSecureStorage create(Ref ref) {
    return secureStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FlutterSecureStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FlutterSecureStorage>(value),
    );
  }
}

String _$secureStorageHash() => r'20eb86340d1b0eaa5dcac993880ebe79a7179c7e';

@ProviderFor(tokenStorage)
const tokenStorageProvider = TokenStorageProvider._();

final class TokenStorageProvider
    extends $FunctionalProvider<TokenStorage, TokenStorage, TokenStorage>
    with $Provider<TokenStorage> {
  const TokenStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tokenStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tokenStorageHash();

  @$internal
  @override
  $ProviderElement<TokenStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TokenStorage create(Ref ref) {
    return tokenStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TokenStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TokenStorage>(value),
    );
  }
}

String _$tokenStorageHash() => r'343a4777583de23577989070e81a30ae661cd151';
