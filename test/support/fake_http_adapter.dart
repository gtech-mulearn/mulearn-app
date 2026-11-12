import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// A canned HTTP reply for [FakeHttpAdapter]. A [statusCode] of `-1`
/// simulates a connection failure (no response at all).
class FakeResponse {
  const FakeResponse(this.statusCode, this.body);

  final int statusCode;
  final Object? body;
}

/// A Dio [HttpClientAdapter] that answers from an in-memory route table and
/// records every request, so tests can assert on the exact path, query and
/// body the app sent — without a network.
///
/// Route keys are `'<METHOD> <path>'`, with the path excluding the query
/// string (for example `'GET /api/v1/dashboard/events/'`).
class FakeHttpAdapter implements HttpClientAdapter {
  FakeHttpAdapter(this.routes);

  final Map<String, FakeResponse Function(RequestOptions options)> routes;
  final List<RequestOptions> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final key = '${options.method.toUpperCase()} ${options.uri.path}';
    final handler = routes[key];
    if (handler == null) {
      throw StateError('No fake route for $key');
    }
    final reply = handler(options);
    if (reply.statusCode == -1) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'Simulated connection failure for $key',
      );
    }
    return ResponseBody.fromString(
      jsonEncode(reply.body),
      reply.statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// A Dio wired to [adapter], with the dev base URL the app uses.
Dio fakeDio(FakeHttpAdapter adapter) =>
    Dio(BaseOptions(baseUrl: 'https://dev.mulearn.org'))..httpClientAdapter = adapter;
