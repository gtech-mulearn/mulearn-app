import 'package:google_sign_in/google_sign_in.dart';
import 'package:mulearn_app/core/network/api_exception.dart';

/// Wraps the native Google Sign-In SDK to obtain an ID token for exchange
/// with `POST /api/v1/auth/google-mobile/`.
///
/// ⚠️ Needs a real Google OAuth client ID configured before this can work.
/// [GoogleSignIn.initialize] is called with no `clientId` here, which relies
/// on platform-level config files (`google-services.json` on Android,
/// `GoogleService-Info.plist`/`Info.plist` `CLIENT_ID` key on iOS/macOS) that
/// this project does not yet have — see the platform TODOs in
/// `ios/Runner/Info.plist` / `macos/Runner/Info.plist`. Without those, the
/// native picker itself will fail to launch; this is a credentials gap, not
/// a code gap.
class GoogleNativeSignInDataSource {
  GoogleNativeSignInDataSource();

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize();
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
