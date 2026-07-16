import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/auth_token_parser.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/repositories/auth_repository.dart';

/// [AuthRepository] implementation.
///
/// Token extraction is delegated to [AuthTokenParser], which now uses the
/// confirmed `accessToken`/`refreshToken` field names (rules.md §3/§9).
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required TokenStorage tokenStorage,
  })  : _remote = remote,
        _tokenStorage = tokenStorage;

  final AuthRemoteDataSource _remote;
  final TokenStorage _tokenStorage;

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
      return _completeSignIn(payload);
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
      return _completeSignIn(payload);
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
  Future<AuthSession> signInWithGoogle({required String idToken}) async {
    try {
      final payload = await _remote.authenticateWithGoogle(idToken: idToken);
      return _completeSignIn(payload);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<AuthSession> signInWithApple({
    required String identityToken,
    String? email,
  }) async {
    try {
      final payload = await _remote.authenticateWithApple(
        identityToken: identityToken,
        email: email,
      );
      return _completeSignIn(payload);
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

  @override
  Future<void> signOut() => _tokenStorage.clear();

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
