import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';

/// Central handling of the μLearn response envelope
/// `{ hasError, statusCode, message, response }` (rules.md §3).
///
/// Every DRF endpoint wraps its payload under `response`; DTOs model the
/// *contents* of `response`, not the envelope. Unwrapping lives here, once,
/// rather than in every DTO — the single shared parsing helper the rules permit
/// as an alternative to a response interceptor.
abstract final class ApiEnvelope {
  const ApiEnvelope._();

  /// Returns the `response` payload as a `Map`, throwing [ApiException] when the
  /// envelope reports an error.
  static Map<String, dynamic> unwrapObject(Response<dynamic> response) {
    final payload = _unwrap(response);
    if (payload is Map<String, dynamic>) return payload;
    throw ApiException(
      message: 'Unexpected response shape (expected an object).',
      statusCode: response.statusCode,
    );
  }

  /// Returns the `response` payload as a `List`.
  static List<dynamic> unwrapList(Response<dynamic> response) {
    final payload = _unwrap(response);
    if (payload is List) return payload;
    throw ApiException(
      message: 'Unexpected response shape (expected a list).',
      statusCode: response.statusCode,
    );
  }

  static dynamic _unwrap(Response<dynamic> response) {
    final data = response.data;
    if (data is! Map<String, dynamic>) {
      throw ApiException(
        message: 'Malformed response (not a JSON object).',
        statusCode: response.statusCode,
      );
    }

    final hasError = data['hasError'];
    if (hasError == true) {
      throw ApiException.fromEnvelopeBody(data, statusCode: response.statusCode);
    }

    // Some endpoints may omit the envelope; tolerate a bare body.
    if (!data.containsKey('response')) return data;
    return data['response'];
  }
}
