import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the auth endpoints. Returns the already-unwrapped
/// `response` payload; token-field extraction and mapping happen in the
/// repository.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  /// `POST /api/v1/auth/user-authentication/` with `emailOrMuid` + `password`.
  Future<Map<String, dynamic>> authenticateWithPassword({
    required String emailOrMuid,
    required String password,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.userAuthentication,
      data: {'emailOrMuid': emailOrMuid, 'password': password},
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    return ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/auth/user-authentication/` with `emailOrMuid` + `otp`.
  Future<Map<String, dynamic>> authenticateWithOtp({
    required String emailOrMuid,
    required String otp,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.userAuthentication,
      data: {'emailOrMuid': emailOrMuid, 'otp': otp},
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    return ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/auth/request-otp/` — sends an OTP to the account's email.
  Future<void> requestOtp({required String emailOrMuid}) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.requestOtp,
      data: {'emailOrMuid': emailOrMuid},
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/dashboard/user/forgot-password/` — sends a password-reset
  /// email.
  Future<void> requestPasswordReset({required String emailOrMuid}) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.forgotPassword,
      data: {'emailOrMuid': emailOrMuid},
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/dashboard/user/reset-password/verify-token/{token}/`.
  Future<void> verifyResetToken(String token) async {
    final response = await _dio.post<dynamic>(
      '${ApiPaths.verifyResetToken}$token/',
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/dashboard/user/reset-password/{token}/` with `password`.
  Future<void> resetPassword({
    required String token,
    required String password,
  }) async {
    final response = await _dio.post<dynamic>(
      '${ApiPaths.resetPassword}$token/',
      data: {'password': password},
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/auth/google-mobile/` — exchanges a native Google ID token
  /// for an app session.
  Future<Map<String, dynamic>> authenticateWithGoogle({
    required String idToken,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.googleMobileLogin,
      data: {'id_token': idToken, 'idToken': idToken},
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    return ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/auth/apple-mobile/` — exchanges a native Sign in with
  /// Apple identity token for an app session.
  Future<Map<String, dynamic>> authenticateWithApple({
    required String identityToken,
    String? email,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.appleMobileLogin,
      data: {
        'identity_token': identityToken,
        'identityToken': identityToken,
        if (email != null) 'email': email,
      },
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    return ApiEnvelope.unwrapObject(response);
  }
}
