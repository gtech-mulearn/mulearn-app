import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/session_actions.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/auth/data/datasources/apple_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/google_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mulearn_app/features/auth/domain/entities/social_sign_in_outcome.dart';
import 'package:mulearn_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) =>
    AuthRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [AuthRepository] contract, wired to the concrete
/// impl here via DI (rules.md §2/§5) so tests can override it.
@riverpod
AuthRepository authRepository(Ref ref) => AuthRepositoryImpl(
      remote: ref.watch(authRemoteDataSourceProvider),
      tokenStorage: ref.watch(tokenStorageProvider),
    );

@Riverpod(keepAlive: true)
GoogleNativeSignInDataSource googleNativeSignInDataSource(Ref ref) =>
    GoogleNativeSignInDataSource();

@riverpod
AppleNativeSignInDataSource appleNativeSignInDataSource(Ref ref) =>
    const AppleNativeSignInDataSource();

/// Drives the sign-in / sign-out actions. Exposes `AsyncValue<void>` so
/// screens get automatic loading/error states via [AsyncValue.guard]
/// (rules.md §4). Every action also rethrows its error after recording it, so
/// callers that need a success/failure signal for control flow (e.g. the OTP
/// screen only advancing to the verify step on success) can `try`/`catch`
/// without duplicating error handling — the error is still available via
/// `ref.listen(authControllerProvider, ...)` for a shared snackbar.
///
/// The coarse routing signal lives in the core [AppAuthController].
@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<void> build() {}

  Future<void> signInWithPassword({
    required String emailOrMuid,
    required String password,
  }) =>
      _guard(() async {
        await ref.read(authRepositoryProvider).signInWithPassword(
              emailOrMuid: emailOrMuid,
              password: password,
            );
        ref.read(appAuthControllerProvider.notifier).setSignedIn();
      });

  Future<void> signInWithOtp({
    required String emailOrMuid,
    required String otp,
  }) =>
      _guard(() async {
        await ref.read(authRepositoryProvider).signInWithOtp(
              emailOrMuid: emailOrMuid,
              otp: otp,
            );
        ref.read(appAuthControllerProvider.notifier).setSignedIn();
      });

  Future<void> requestOtp({required String emailOrMuid}) => _guard(
        () => ref.read(authRepositoryProvider).requestOtp(
              emailOrMuid: emailOrMuid,
            ),
      );

  Future<void> requestPasswordReset({required String emailOrMuid}) => _guard(
        () => ref.read(authRepositoryProvider).requestPasswordReset(
              emailOrMuid: emailOrMuid,
            ),
      );

  Future<void> verifyResetToken(String token) =>
      _guard(() => ref.read(authRepositoryProvider).verifyResetToken(token));

  Future<void> resetPassword({
    required String token,
    required String password,
  }) =>
      _guard(
        () => ref.read(authRepositoryProvider).resetPassword(
              token: token,
              password: password,
            ),
      );

  /// Triggers the native Google account picker, then exchanges the resulting
  /// ID token. Signs in for a known account; for an unknown email returns
  /// [SocialNeedsRegistration] so the screen can start Google sign-up.
  Future<SocialSignInOutcome> signInWithGoogle() async {
    late SocialSignInOutcome outcome;
    await _guard(() async {
      final idToken = await ref.read(googleNativeSignInDataSourceProvider).signIn();
      outcome = await ref.read(authRepositoryProvider).signInWithGoogle(idToken: idToken);
      if (outcome is SocialSignedIn) {
        ref.read(appAuthControllerProvider.notifier).setSignedIn();
      }
    });
    return outcome;
  }

  /// Triggers the native Sign in with Apple flow, then exchanges the
  /// resulting identity token for an app session. Throws
  /// [AppleAccountNotFound] when no account uses the Apple ID's email.
  Future<void> signInWithApple() => _guard(() async {
        final credential = await ref.read(appleNativeSignInDataSourceProvider).signIn();
        try {
          await ref.read(authRepositoryProvider).signInWithApple(
                identityToken: credential.identityToken,
              );
        } on ApiException catch (e) {
          if (e.message == _appleNoAccountMessage) throw const AppleAccountNotFound();
          rethrow;
        }
        ref.read(appAuthControllerProvider.notifier).setSignedIn();
      });

  /// The authserver's exact reply when no account uses the Apple email.
  static const _appleNoAccountMessage = 'No account found with this email';

  /// Signs out through the core session (router state first, then the
  /// server-side revoke, tokens and cache).
  Future<void> signOut() => ref.read(sessionActionsProvider.notifier).signOut();

  Future<void> _guard(Future<void> Function() action) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(action);
    if (ref.mounted) state = result;
    final error = result.error;
    if (error != null) {
      // Logged regardless of type so a non-ApiException (parsing bug,
      // platform-channel failure, etc.) is never silently reduced to the
      // screen's generic "Something went wrong." with no trace of why.
      appLogger.e('Auth action failed', error: error, stackTrace: result.stackTrace);
      Error.throwWithStackTrace(error, result.stackTrace ?? StackTrace.current);
    }
  }
}
