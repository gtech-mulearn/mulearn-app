import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// The identity token (+ optional email, only returned on first sign-in) from
/// a native Sign in with Apple flow.
typedef AppleSignInResult = ({String identityToken, String? email});

/// Wraps the native Sign in with Apple SDK to obtain an identity token for
/// exchange with `POST /api/v1/auth/apple-mobile/`.
///
/// ⚠️ Needs the "Sign in with Apple" capability (`com.apple.developer.applesignin`
/// entitlement) enabled on the app's Xcode target before this can work on
/// iOS/macOS. **Empirically confirmed** that adding this entitlement without a
/// real Apple Developer Team/signing capability association breaks the app at
/// launch (`Error waiting for a debug connection` — the sandboxed process
/// fails to start) — so it's deliberately NOT added to
/// `macos/Runner/*.entitlements` yet. Add it once this project has real Apple
/// Developer Program signing configured (needed for release builds anyway).
/// Android/other platforms additionally need `webAuthenticationOptions` (a
/// Services ID + redirect URI), not wired here since this app's other
/// platforms aren't in scope yet.
class AppleNativeSignInDataSource {
  const AppleNativeSignInDataSource();

  /// Triggers the native Apple sign-in flow and returns the identity token.
  ///
  /// Throws [ApiException] if the user cancels or no identity token is
  /// returned.
  Future<AppleSignInResult> signIn() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final token = credential.identityToken;
      if (token == null || token.isEmpty) {
        throw const ApiException(
          message: 'Apple sign-in did not return an identity token.',
        );
      }
      return (identityToken: token, email: credential.email);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        throw const ApiException(message: 'Sign-in cancelled.');
      }
      throw ApiException(message: 'Apple sign-in failed: ${e.message}');
    }
  }
}
