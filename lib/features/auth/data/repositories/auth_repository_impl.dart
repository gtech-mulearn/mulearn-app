import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/auth_token_parser.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/entities/social_sign_in_outcome.dart';
import 'package:mulearn_app/features/auth/domain/repositories/auth_repository.dart';

/// [AuthRepository] implementation.
///
/// Token extraction is delegated to [AuthTokenParser], which now uses the
/// confirmed `accessToken`/`refreshToken` field names (rules.md §3/§9).
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required TokenStorage tokenStorage,
    required CacheStore cacheStore,
  })  : _remote = remote,
        _tokenStorage = tokenStorage,
        _cacheStore = cacheStore;

  final AuthRemoteDataSource _remote;
  final TokenStorage _tokenStorage;

  /// The HTTP response cache — wiped on sign-out so the next account on the
  /// device never sees the previous one's cached data.
  final CacheStore _cacheStore;

  @override
  Future<AuthSession> signInWithPassword({
    required String emailOrMuid,
    required String password,
  }) async {
    try {
      final payload = await _remote.authenticateWithPassword(
        emailOrMuid: emailOrMuid,
        password: password,
      );
      return await _completeSignIn(payload);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<AuthSession> signInWithOtp({
    required String emailOrMuid,
    required String otp,
  }) async {
    try {
      final payload = await _remote.authenticateWithOtp(
        emailOrMuid: emailOrMuid,
        otp: otp,
      );
      return await _completeSignIn(payload);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> requestOtp({required String emailOrMuid}) async {
    try {
      await _remote.requestOtp(emailOrMuid: emailOrMuid);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> requestPasswordReset({required String emailOrMuid}) async {
    try {
      await _remote.requestPasswordReset(emailOrMuid: emailOrMuid);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> verifyResetToken(String token) async {
    try {
      await _remote.verifyResetToken(token);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    try {
      await _remote.resetPassword(token: token, password: password);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<SocialSignInOutcome> signInWithGoogle({required String idToken}) async {
    try {
      final payload = await _remote.authenticateWithGoogle(idToken: idToken);
      final tempToken = payload['tempToken'];
      if (payload['isNewUser'] == true && tempToken is String && tempToken.isNotEmpty) {
        return SocialNeedsRegistration(
          tempToken: tempToken,
          email: payload['email'] as String? ?? '',
          fullName: payload['fullName'] as String? ?? '',
        );
      }
      await _completeSignIn(payload);
      return const SocialSignedIn();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<AuthSession> signInWithApple({required String identityToken}) async {
    try {
      final payload = await _remote.authenticateWithApple(identityToken: identityToken);
      return await _completeSignIn(payload);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<AuthSession> _completeSignIn(Map<String, dynamic> payload) async {
    final tokens = AuthTokenParser.tryParse(payload);
    if (tokens == null) {
      throw const ApiException(
        message: 'Signed in, but could not read the auth tokens from the '
            'response.',
      );
    }

    await _tokenStorage.saveTokens(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    return AuthSession(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
  }

  @override
  Future<AuthSession?> refreshToken() async {
    // The auth interceptor performs the transparent refresh-on-401 flow. This
    // explicit method is part of the contract for callers that want to force a
    // refresh; reflects stored state since no caller currently needs to force
    // one outside of a 401.
    return currentSession();
  }

  /// Revokes the refresh token on the server (best effort — a failure is
  /// logged, never blocks), then clears the stored tokens and the response
  /// cache. The access token stays valid server-side until it expires
  /// (15 min), which is why the local copy is always removed.
  @override
  Future<void> signOut() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await _remote.logout(refreshToken);
      } on Object catch (e) {
        appLogger.w('Server logout failed; clearing the session locally', error: e);
      }
    }
    await _tokenStorage.clear();
    await _cacheStore.clean();
  }

  @override
  Future<AuthSession?> currentSession() async {
    final access = await _tokenStorage.readAccessToken();
    final refresh = await _tokenStorage.readRefreshToken();
    if (access == null || access.isEmpty) return null;
    return AuthSession(
      accessToken: access,
      refreshToken: refresh ?? '',
    );
  }
}
