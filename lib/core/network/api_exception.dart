import 'package:dio/dio.dart';

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
  });

  factory ApiException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return const ApiException(
          message: 'The connection timed out. Please try again.',
          isNetworkError: true,
        );
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return ApiException(
          message: 'Could not reach the server. Check your connection.',
          isNetworkError: true,
          statusCode: e.response?.statusCode,
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

  bool get isUnauthorized => statusCode == 401;

  /// First error message for [field], if any — convenient for form fields.
  String? errorFor(String field) => fieldErrors[field]?.firstOrNull;

  /// The user-facing message for any caught error — [message] if it's an
  /// [ApiException], otherwise a generic fallback. Centralizes the
  /// `error is ApiException ? error.message : 'Something went wrong.'` check
  /// duplicated across error views and screens.
  static String messageFor(Object error) =>
      error is ApiException ? error.message : 'Something went wrong.';

  /// Recursively flattens `message`'s field errors to leaf field names,
  /// skipping `general` (handled separately) at every nesting level. E.g.
  /// `{"general": [], "user": {"email": ["..."]}}` → `{"email": ["..."]}`.
  static Map<String, List<String>> _flattenFieldErrors(
    Map<String, dynamic> node,
  ) {
    final result = <String, List<String>>{};
    for (final entry in node.entries) {
      if (entry.key == 'general') continue;
      final value = entry.value;
      if (value is List) {
        result[entry.key] = value.map((e) => e.toString()).toList();
      } else if (value is Map<String, dynamic>) {
        result.addAll(_flattenFieldErrors(value));
      } else if (value is String) {
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
