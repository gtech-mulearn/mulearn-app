import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage_provider.g.dart';

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
@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      mOptions: MacOsOptions(useDataProtectionKeyChain: false),
    );

/// Well-known secure-storage keys. Centralized so a rename touches one place.
abstract final class TokenKeys {
  const TokenKeys._();

  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
}

/// Thin wrapper over [FlutterSecureStorage] for the JWT access/refresh pair.
///
/// This is the ONE place tokens are read/written. The auth interceptor and
/// repository talk to this rather than [FlutterSecureStorage] directly.
class TokenStorage {
  const TokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  Future<String?> readAccessToken() => _storage.read(key: TokenKeys.accessToken);

  Future<String?> readRefreshToken() => _storage.read(key: TokenKeys.refreshToken);

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: TokenKeys.accessToken, value: accessToken);
    await _storage.write(key: TokenKeys.refreshToken, value: refreshToken);
  }

  /// Persist only a rotated access token (refresh token unchanged).
  Future<void> saveAccessToken(String accessToken) =>
      _storage.write(key: TokenKeys.accessToken, value: accessToken);

  Future<bool> hasSession() async =>
      (await readAccessToken())?.isNotEmpty ?? false;

  Future<void> clear() async {
    await _storage.delete(key: TokenKeys.accessToken);
    await _storage.delete(key: TokenKeys.refreshToken);
  }
}

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) =>
    TokenStorage(ref.watch(secureStorageProvider));
