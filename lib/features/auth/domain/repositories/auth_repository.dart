import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';

/// Auth repository contract (rules.md §2/§5). Presentation depends on this
/// abstraction, never the concrete [AuthRepositoryImpl].
abstract interface class AuthRepository {
  /// Sign in with a password, persist the token pair, and return the session.
  ///
  /// [emailOrMuid] accepts either an email address or a μLearn ID (MUID).
  /// Throws [ApiException] on failure.
  Future<AuthSession> signInWithPassword({
    required String emailOrMuid,
    required String password,
  });

  /// Sign in with an OTP previously sent via [requestOtp], persist the token
  /// pair, and return the session.
  ///
  /// Throws [ApiException] on failure.
  Future<AuthSession> signInWithOtp({
    required String emailOrMuid,
    required String otp,
  });

  /// Request an OTP be sent to the account's email, for use with
  /// [signInWithOtp].
  ///
  /// Throws [ApiException] on failure.
  Future<void> requestOtp({required String emailOrMuid});

  /// Request a password-reset email for the given account.
  ///
  /// Throws [ApiException] on failure.
  Future<void> requestPasswordReset({required String emailOrMuid});

  /// Verify a password-reset token (from the emailed link/code) is valid,
  /// before showing the new-password form.
  ///
  /// Throws [ApiException] on failure (including an invalid/expired token).
  Future<void> verifyResetToken(String token);

  /// Reset the password using a token already confirmed via
  /// [verifyResetToken].
  ///
  /// Throws [ApiException] on failure.
  Future<void> resetPassword({required String token, required String password});

  /// Exchange a native Google Sign-In ID token for an app session, persist
  /// the token pair, and return the session.
  ///
  /// Throws [ApiException] on failure.
  Future<AuthSession> signInWithGoogle({required String idToken});

  /// Exchange a native Sign in with Apple identity token for an app session,
  /// persist the token pair, and return the session.
  ///
  /// Throws [ApiException] on failure.
  Future<AuthSession> signInWithApple({
    required String identityToken,
    String? email,
  });

  /// Force a token refresh using the stored refresh token. Returns the new
  /// session, or null if there is no usable refresh token.
  Future<AuthSession?> refreshToken();

  /// Clear stored tokens.
  Future<void> signOut();

  /// The current session reconstructed from secure storage, or null if signed
  /// out. Does not hit the network.
  Future<AuthSession?> currentSession();
}
