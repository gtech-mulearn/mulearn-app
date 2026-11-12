import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_http_adapter.dart';

void main() {
  test('routes by method and path and records the request', () async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/ping/': (_) => const FakeResponse(200, {'ok': true}),
    });
    final dio = fakeDio(adapter);

    final res = await dio.get<dynamic>('/api/v1/ping/', queryParameters: {'pageIndex': 2});

    expect(res.data, {'ok': true});
    expect(adapter.requests.single.queryParameters, {'pageIndex': 2});
  });

  test('non-2xx status surfaces as a badResponse DioException', () async {
    final dio = fakeDio(FakeHttpAdapter({
      'POST /api/v1/x/': (_) => const FakeResponse(400, {'hasError': true}),
    }));

    await expectLater(
      dio.post<dynamic>('/api/v1/x/'),
      throwsA(isA<DioException>()
          .having((e) => e.type, 'type', DioExceptionType.badResponse)
          .having((e) => e.response?.statusCode, 'status', 400)),
    );
  });

  test('statusCode -1 simulates a connection error', () async {
    final dio = fakeDio(FakeHttpAdapter({
      'GET /api/v1/x/': (_) => const FakeResponse(-1, null),
    }));

    await expectLater(
      dio.get<dynamic>('/api/v1/x/'),
      throwsA(isA<DioException>()
          .having((e) => e.type, 'type', DioExceptionType.connectionError)),
    );
  });

  test('an unmatched request fails loudly', () async {
    final dio = fakeDio(FakeHttpAdapter({}));

    await expectLater(dio.get<dynamic>('/api/v1/nope/'), throwsA(isA<DioException>()));
  });
}
