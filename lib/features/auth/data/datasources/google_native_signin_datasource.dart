import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mulearn_app/core/network/api_exception.dart';

/// Wraps the native Google Sign-In SDK to obtain an ID token for exchange
/// with `POST /api/v1/auth/google-mobile/`.
///
/// iOS: the client ID below is from the real iOS OAuth client (GCP project
/// `muapp-481514`), confirmed to match this app's bundle ID
/// (`org.mulearn.muapp`) before wiring in — its `REVERSED_CLIENT_ID` is also
/// registered as a URL scheme in `ios/Runner/Info.plist` (required for the
/// sign-in redirect). Passed explicitly here rather than via a
/// `GoogleService-Info.plist`, since this app doesn't use Firebase.
///
/// ⚠️ Android: no Android-type OAuth client has been provided yet (only an
/// iOS client and an unrelated "installed"/desktop-type client, which isn't
/// valid for a mobile app's native sign-in) — Android needs its own client
/// keyed to the package name + release/debug SHA-1 fingerprints. Until that
/// exists, [clientId] is left unset on Android (an iOS client ID would not
/// work there), so tapping "Continue with Google" on Android will fail.
class GoogleNativeSignInDataSource {
  GoogleNativeSignInDataSource();

  static const _iosClientId =
      '966772588752-tr5qq5cs4d6kfqsv6tivk3v58n26tnes.apps.googleusercontent.com';

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize(
      clientId: defaultTargetPlatform == TargetPlatform.iOS ? _iosClientId : null,
    );
    _initialized = true;
  }

  /// Triggers the native account picker and returns the ID token.
  ///
  /// Throws [ApiException] if the user cancels or no ID token is returned.
  Future<String> signIn() async {
    await _ensureInitialized();
    try {
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw const ApiException(
          message: 'Google sign-in did not return an ID token.',
        );
      }
      return idToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw const ApiException(message: 'Sign-in cancelled.');
      }
      throw ApiException(message: 'Google sign-in failed: ${e.description}');
    }
  }
}
