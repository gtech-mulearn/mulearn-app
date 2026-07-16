import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/auth_token_parser.dart';
import 'package:mulearn_app/core/network/session_event_bus.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';

/// Attaches `Authorization: Bearer <token>` and transparently refreshes it
/// (rules.md §3, architecture §6b).
///
/// On a 401 it attempts exactly one silent refresh via
/// `/api/v1/auth/get-access-token/`, retries the original request once, and on
/// unrecoverable failure clears storage and emits [SessionEvent.expired] on the
/// [SessionEventBus] — never navigates directly. Concurrent 401s share a single
/// in-flight refresh (single-flight) to avoid a refresh storm.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio refreshDio,
    required TokenStorage tokenStorage,
    required SessionEventBus sessionEventBus,
  })  : _refreshDio = refreshDio,
        _tokenStorage = tokenStorage,
        _sessionEventBus = sessionEventBus;

  /// A bare Dio (base options + envelope only, NO auth interceptor) used solely
  /// for the refresh call, so refreshing can't recurse into this interceptor.
  final Dio _refreshDio;
  final TokenStorage _tokenStorage;
  final SessionEventBus _sessionEventBus;

  /// Shared in-flight refresh so simultaneous 401s trigger one refresh.
  Future<bool>? _refreshing;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.remove(RequestFlags.skipAuth) == true) {
      return handler.next(options);
    }
    final token = await _tokenStorage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final response = err.response;
    final isRefreshCall =
        err.requestOptions.path.contains(ApiPaths.refreshToken);
    final alreadyRetried =
        err.requestOptions.extra[RequestFlags.retried] == true;

    if (response?.statusCode != 401 || isRefreshCall || alreadyRetried) {
      return handler.next(err);
    }

    final refreshed = await (_refreshing ??= _performRefresh());
    _refreshing = null;

    if (!refreshed) {
      await _tokenStorage.clear();
      _sessionEventBus.emit(SessionEvent.expired);
      return handler.next(err);
    }

    try {
      final retryResponse = await _retry(err.requestOptions);
      return handler.resolve(retryResponse);
    } on DioException catch (retryErr) {
      return handler.next(retryErr);
    }
  }

  Future<bool> _performRefresh() async {
    try {
      final refreshToken = await _tokenStorage.readRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) return false;

      final response = await _refreshDio.post<dynamic>(
        ApiPaths.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {RequestFlags.skipAuth: true}),
      );

      final payload = ApiEnvelope.unwrapObject(response);
      final accessToken = AuthTokenParser.tryParseRefreshed(payload);
      if (accessToken == null) {
        appLogger.w('Refresh succeeded but no access token found in payload.');
        return false;
      }

      // get-access-token/ only rotates the access token; the refresh token
      // itself is not reissued.
      await _tokenStorage.saveAccessToken(accessToken);
      return true;
    } on DioException catch (e) {
      appLogger.w('Token refresh failed', error: e);
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final token = await _tokenStorage.readAccessToken();
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        if (token != null) 'Authorization': 'Bearer $token',
      },
      extra: {...requestOptions.extra, RequestFlags.retried: true},
    );
    return _refreshDio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
