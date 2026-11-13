import 'package:dio/dio.dart';

/// What went wrong, independent of the message — lets screens pick an
/// offline/forbidden/validation state without parsing text (spec §8.1).
enum ApiErrorKind {
  /// The server was never reached (no connection, DNS, TLS…).
  network,

  /// The request or response took too long.
  timeout,

  /// 401 — the session is missing or no longer valid.
  unauthorized,

  /// 403 — signed in but not allowed (also an expired token on this backend).
  forbidden,

  /// 400/422 or field errors — the input was rejected.
  validation,

  /// 404.
  notFound,

  /// 5xx.
  server,

  /// Nothing in the error identifies it.
  unknown,
}

/// Normalized error surfaced to the domain/presentation layers.
///
/// Handles the error shapes the μLearn backend produces (rules.md §3),
/// confirmed directly against `https://dev.mulearn.org`:
///  1. The envelope `{ hasError, statusCode, message, response }` where
///     `message` carries a `general` list of human-readable strings.
///  2. Field-keyed validation errors inside `message`, which nest to match
///     the request body's own shape — e.g. `POST /api/v1/register/` sends a
///     nested `user` object, so its errors come back as
///     `message.user.full_name` / `message.user.email`, not flat. Flattened
///     to the leaf field name (`errorFor('full_name')`) regardless of
///     nesting depth, since that's what a form field needs to key off of.
///  3. Raw top-level field-keyed errors (`{"email": ["..."]}`, no `message`
///     wrapper) — kept as a fallback; not observed on this backend but cheap
///     to keep covering in case a future endpoint uses it.
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.fieldErrors = const {},
    this.isNetworkError = false,
    ApiErrorKind? kind,
  }) : _kind = kind;

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiException(
          message: 'The connection timed out. Please try again.',
          isNetworkError: true,
          kind: ApiErrorKind.timeout,
        );
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return ApiException(
          message: 'Could not reach the server. Check your connection.',
          isNetworkError: true,
          statusCode: e.response?.statusCode,
          kind: ApiErrorKind.network,
        );
      case DioExceptionType.cancel:
        return const ApiException(message: 'Request cancelled.');
      case DioExceptionType.badCertificate:
        return const ApiException(message: 'Bad server certificate.');
      case DioExceptionType.badResponse:
        final data = e.response?.data;
        if (data is Map<String, dynamic>) {
          return ApiException.fromEnvelopeBody(data, statusCode: e.response?.statusCode);
        }
        return ApiException(
          message: 'Request failed'
              '${e.response?.statusCode != null ? ' (${e.response?.statusCode})' : ''}.',
          statusCode: e.response?.statusCode,
        );
    }
  }

  /// Parses an envelope-shaped response body into an [ApiException] —
  /// shared by the Dio-exception path above (non-2xx) and
  /// `ApiEnvelope`'s soft-error path (200 with `hasError: true`).
  factory ApiException.fromEnvelopeBody(
    Map<String, dynamic> data, {
    int? statusCode,
  }) {
    final status = (data['statusCode'] as int?) ?? statusCode;
    final message = data['message'];

    if (message is Map<String, dynamic>) {
      final general = message['general'];
      final fieldErrors = _flattenFieldErrors(message);
      if (general is List && general.isNotEmpty) {
        return ApiException(
          message: general.map((e) => e.toString()).join('\n'),
          statusCode: status,
          fieldErrors: fieldErrors,
        );
      }
      if (fieldErrors.isNotEmpty) {
        return ApiException(
          message: fieldErrors.values.first.firstOrNull ?? 'Validation failed.',
          statusCode: status,
          fieldErrors: fieldErrors,
        );
      }
    }
    if (message is String && message.isNotEmpty) {
      return ApiException(message: message, statusCode: status);
    }

    // Serializer errors returned under `response` instead of `message`
    // (`CustomResponse(response=serializer.errors)` — profile PATCH, ig-edit,
    // user/organization, qseverse). Only list leaves count: a failure
    // envelope's `response` can also carry plain data strings.
    final response = data['response'];
    if (response is Map<String, dynamic>) {
      final responseErrors = _flattenFieldErrors(response, acceptStrings: false);
      if (responseErrors.isNotEmpty) {
        return ApiException(
          message: responseErrors.values.first.firstOrNull ?? 'Validation failed.',
          statusCode: status,
          fieldErrors: responseErrors,
        );
      }
    }

    // Raw top-level field-keyed errors (no `message` wrapper).
    final fieldErrors = _parseFieldErrors(data);
    if (fieldErrors.isNotEmpty) {
      return ApiException(
        message: fieldErrors.values.first.firstOrNull ?? 'Validation failed.',
        statusCode: status,
        fieldErrors: fieldErrors,
      );
    }

    final detail = data['detail'];
    if (detail is String && detail.isNotEmpty) {
      return ApiException(message: detail, statusCode: status);
    }

    return ApiException(
      message: 'Request failed${status != null ? ' ($status)' : ''}.',
      statusCode: status,
    );
  }

  final String message;
  final int? statusCode;

  /// Field-keyed validation errors, e.g. `{'email': ['This field is required.']}`.
  final Map<String, List<String>> fieldErrors;

  /// True when the request never reached the server (timeout, no connection).
  final bool isNetworkError;

  final ApiErrorKind? _kind;

  /// The error's category: set explicitly for timeouts/connection failures,
  /// otherwise derived from the status code and field errors.
  ApiErrorKind get kind {
    if (_kind case final kind?) return kind;
    final status = statusCode;
    if (status == 401) return ApiErrorKind.unauthorized;
    if (status == 403) return ApiErrorKind.forbidden;
    if (status == 404) return ApiErrorKind.notFound;
    if (status == 400 || status == 422 || fieldErrors.isNotEmpty) {
      return ApiErrorKind.validation;
    }
    if (status != null && status >= 500) return ApiErrorKind.server;
    if (isNetworkError) return ApiErrorKind.network;
    return ApiErrorKind.unknown;
  }

  bool get isUnauthorized => statusCode == 401;

  /// First error message for [field], if any — convenient for form fields.
  String? errorFor(String field) => fieldErrors[field]?.firstOrNull;

  /// The user-facing message for any caught error — [message] if it's an
  /// [ApiException], otherwise a generic fallback. Centralizes the
  /// `error is ApiException ? error.message : 'Something went wrong.'` check
  /// duplicated across error views and screens.
  static String messageFor(Object error) =>
      error is ApiException ? error.message : 'Something went wrong.';

  /// Recursively flattens field errors to leaf field names, skipping
  /// `general` (handled separately) at every nesting level. E.g.
  /// `{"general": [], "user": {"email": ["..."]}}` → `{"email": ["..."]}`.
  /// [acceptStrings] keeps bare string leaves as errors; pass `false` for
  /// `response` bodies, where only DRF's list-of-messages leaves are errors.
  static Map<String, List<String>> _flattenFieldErrors(
    Map<String, dynamic> node, {
    bool acceptStrings = true,
  }) {
    final result = <String, List<String>>{};
    for (final entry in node.entries) {
      if (entry.key == 'general') continue;
      final value = entry.value;
      if (value is List) {
        result[entry.key] = value.map((e) => e.toString()).toList();
      } else if (value is Map<String, dynamic>) {
        result.addAll(_flattenFieldErrors(value, acceptStrings: acceptStrings));
      } else if (acceptStrings && value is String) {
        result[entry.key] = [value];
      }
    }
    return result;
  }

  static Map<String, List<String>> _parseFieldErrors(
    Map<String, dynamic> data,
  ) {
    final result = <String, List<String>>{};
    for (final entry in data.entries) {
      if (const {'hasError', 'statusCode', 'message', 'response'}
          .contains(entry.key)) {
        continue;
      }
      final value = entry.value;
      if (value is List) {
        result[entry.key] = value.map((e) => e.toString()).toList();
      } else if (value is String) {
        result[entry.key] = [value];
      }
    }
    return result;
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}
