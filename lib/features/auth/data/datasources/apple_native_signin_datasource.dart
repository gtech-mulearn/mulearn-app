import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// The identity token (+ optional email, only returned on first sign-in) from
/// a native Sign in with Apple flow.
typedef AppleSignInResult = ({String identityToken, String? email});

/// Wraps the native Sign in with Apple SDK to obtain an identity token for
/// exchange with `POST /api/v1/auth/apple-mobile/`.
///
/// iOS: the `com.apple.developer.applesignin` entitlement lives in
/// `ios/Runner/Runner.entitlements`, wired via `CODE_SIGN_ENTITLEMENTS` on all
/// three Runner build configs — this needs the paid Apple Developer Program
/// (team `PX6QV826X4`), not a free Personal Team. **Empirically confirmed
/// live**: Xcode refuses to provision this capability for Personal Teams at
/// all ("Personal development teams... do not support the Sign In with
/// Apple capability"), regardless of the App ID's Developer Portal
/// configuration — so don't copy this entitlement onto a Personal-Team
/// signed target.
///
/// macOS doesn't have this entitlement yet — add it there the same way if
/// macOS ever needs this flow. Android/other platforms additionally need
/// `webAuthenticationOptions` (a Services ID + redirect URI), not wired here
/// since this app's other platforms aren't in scope yet.
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
