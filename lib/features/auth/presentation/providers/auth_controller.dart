import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/auth/data/datasources/apple_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/google_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/repositories/auth_repository_impl.dart';
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
  /// ID token for an app session.
  Future<void> signInWithGoogle() => _guard(() async {
        final idToken = await ref.read(googleNativeSignInDataSourceProvider).signIn();
        await ref.read(authRepositoryProvider).signInWithGoogle(idToken: idToken);
        ref.read(appAuthControllerProvider.notifier).setSignedIn();
      });

  /// Triggers the native Sign in with Apple flow, then exchanges the
  /// resulting identity token for an app session.
  Future<void> signInWithApple() => _guard(() async {
        final credential = await ref.read(appleNativeSignInDataSourceProvider).signIn();
        await ref.read(authRepositoryProvider).signInWithApple(
              identityToken: credential.identityToken,
              email: credential.email,
            );
        ref.read(appAuthControllerProvider.notifier).setSignedIn();
      });

  Future<void> signOut() async {
    // Flip the app to signed-out FIRST, synchronously — the router redirect
    // must fire immediately. Clearing local storage happens after: even if
    // that Keychain/storage call hangs or throws, it must never trap the
    // user on the screen they just tried to leave (an `await` before this
    // line would do exactly that on a stuck platform call, since neither a
    // `catch` nor a `finally` runs until the `await` itself resolves).
    ref.read(appAuthControllerProvider.notifier).setSignedOut();
    try {
      await ref.read(authRepositoryProvider).signOut();
    } on Object catch (e, st) {
      appLogger.e('Failed to clear local session on sign-out', error: e, stackTrace: st);
    }
  }

  Future<void> _guard(Future<void> Function() action) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(action);
    final error = state.error;
    if (error != null) {
      // Logged regardless of type so a non-ApiException (parsing bug,
      // platform-channel failure, etc.) is never silently reduced to the
      // screen's generic "Something went wrong." with no trace of why.
      appLogger.e('Auth action failed', error: error, stackTrace: state.stackTrace);
      Error.throwWithStackTrace(error, state.stackTrace ?? StackTrace.current);
    }
  }
}
