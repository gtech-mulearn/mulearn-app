/// What a native Google sign-in led to (authserver `GoogleMobileAuthAPIView`).
sealed class SocialSignInOutcome {
  const SocialSignInOutcome();
}

/// An existing account: the token pair is stored and the user is signed in.
final class SocialSignedIn extends SocialSignInOutcome {
  const SocialSignedIn();
}

/// No account uses this Google email yet. The authserver returned a
/// short-lived [tempToken] instead of tokens; registration sends it to
/// `POST /api/v1/register/`, which takes the email from it (the client can't
/// choose it) and creates the account without a password.
final class SocialNeedsRegistration extends SocialSignInOutcome {
  const SocialNeedsRegistration({
    required this.tempToken,
    required this.email,
    required this.fullName,
  });

  final String tempToken;

  /// Shown read-only during sign-up; the backend uses the token's email.
  final String email;

  /// Pre-fills the sign-up form; the user may edit it.
  final String fullName;
}

/// Sign in with Apple found no μLearn account for the Apple ID's verified
/// email (authserver: "No account found with this email"). Apple sign-in
/// only signs existing accounts in.
final class AppleAccountNotFound implements Exception {
  const AppleAccountNotFound();

  @override
  String toString() => 'AppleAccountNotFound';
}
