import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/auth_token_parser.dart';
import 'package:mulearn_app/core/network/session_event_bus.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';

/// How a silent token refresh ended.
enum RefreshOutcome {
  /// A new access token is stored; the original request is retried.
  refreshed,

  /// The server answered and refused (any 4xx, or `hasError`), e.g. the
  /// refresh token was revoked by a logout. The session is over.
  rejected,

  /// The server could not be reached or failed (timeout, no connection,
  /// 5xx). The session is kept; the caller gets the original error.
  unavailable,
}

/// Attaches `Authorization: Bearer <token>` and transparently refreshes it
/// (rules.md §3, architecture §6b).
///
/// On a 401/403 it attempts one silent refresh via
/// `/api/v1/auth/get-access-token/` and retries the original request once.
/// Only a [RefreshOutcome.rejected] refresh clears storage and emits
/// [SessionEvent.expired] — never navigates directly; a refresh that couldn't
/// reach the server keeps the user signed in. Concurrent 401/403s share a
/// single in-flight refresh (single-flight) to avoid a refresh storm.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio refreshDio,
    required TokenStorage tokenStorage,
    required SessionEventBus sessionEventBus,
    required CacheStore cacheStore,
  })  : _refreshDio = refreshDio,
        _tokenStorage = tokenStorage,
        _sessionEventBus = sessionEventBus,
        _cacheStore = cacheStore;

  /// A bare Dio (base options + envelope only, NO auth interceptor) used solely
  /// for the refresh call, so refreshing can't recurse into this interceptor.
  final Dio _refreshDio;
  final TokenStorage _tokenStorage;
  final SessionEventBus _sessionEventBus;

  /// Response cache; wiped when the server ends the session, so the next
  /// account on the device never sees this one's cached data.
  final CacheStore _cacheStore;

  /// Shared in-flight refresh so simultaneous 401/403s trigger one refresh.
  Future<RefreshOutcome>? _refreshing;

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

    // Confirmed live against dev.mulearn.org: this backend returns 403, not
    // 401, for an expired/invalid access token — refreshing only on 401
    // silently never triggers, leaving every authenticated screen stuck on
    // "Something went wrong"/403 until the user manually signs in again. A
    // genuine (non-auth) 403 still surfaces correctly: the retried request
    // fails again post-refresh and that second failure is what reaches the
    // caller.
    final isAuthError =
        response?.statusCode == 401 || response?.statusCode == 403;
    if (!isAuthError || isRefreshCall || alreadyRetried) {
      return handler.next(err);
    }

    final outcome = await (_refreshing ??=
        _performRefresh().whenComplete(() => _refreshing = null));

    switch (outcome) {
      case RefreshOutcome.rejected:
        await _tokenStorage.clear();
        await _cacheStore.clean();
        _sessionEventBus.emit(SessionEvent.expired);
        return handler.next(err);
      case RefreshOutcome.unavailable:
        return handler.next(err);
      case RefreshOutcome.refreshed:
        break;
    }

    try {
      final retryResponse = await _retry(err.requestOptions);
      return handler.resolve(retryResponse);
    } on DioException catch (retryErr) {
      return handler.next(retryErr);
    }
  }

  Future<RefreshOutcome> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) return RefreshOutcome.rejected;
    try {
      final response = await _refreshDio.post<dynamic>(
        ApiPaths.refreshToken,
        data: {'refreshToken': refreshToken},
        options: Options(headers: {RequestFlags.skipAuth: true}),
      );

      final payload = ApiEnvelope.unwrapObject(response);
      final accessToken = AuthTokenParser.tryParseRefreshed(payload);
      if (accessToken == null) {
        appLogger.w('Refresh succeeded but no access token found in payload.');
        return RefreshOutcome.unavailable;
      }

      // get-access-token/ only rotates the access token; the refresh token
      // itself is not reissued.
      await _tokenStorage.saveAccessToken(accessToken);
      return RefreshOutcome.refreshed;
    } on ApiException catch (e) {
      // A 2xx envelope with hasError: the server answered and refused.
      appLogger.w('Token refresh refused', error: e);
      return RefreshOutcome.rejected;
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final refused = status != null && status >= 400 && status < 500;
      appLogger.w(refused ? 'Token refresh refused' : 'Token refresh unavailable', error: e);
      return refused ? RefreshOutcome.rejected : RefreshOutcome.unavailable;
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
    // A FormData is finalized once sent; resend a copy (Dio sets the new
    // boundary on the Content-Type header).
    final data = requestOptions.data;
    return _refreshDio.request<dynamic>(
      requestOptions.path,
      data: data is FormData ? data.clone() : data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
