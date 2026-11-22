import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/large_list_interceptor.dart';

import '../../support/fake_http_adapter.dart';

/// A response carrying a long list is flagged in dev, so the next unbounded
/// endpoint shows up in testing, not in production.
void main() {
  Future<List<String>> hit(Object body) async {
    final warnings = <String>[];
    final dio = fakeDio(
      FakeHttpAdapter({'GET /x/': (_) => FakeResponse(200, body)}),
    )..interceptors.add(LargeListInterceptor(warn: warnings.add));
    await dio.get<dynamic>('/x/');
    return warnings;
  }

  Map<String, Object> envelope(Object response) => {
    'hasError': false,
    'statusCode': 200,
    'message': <String, Object>{},
    'response': response,
  };

  test('a long list under response.colleges is flagged', () async {
    final warnings = await hit(
      envelope({
        'colleges': List.filled(2000, {'id': 'x'}),
      }),
    );
    expect(warnings.single, contains('2000 rows'));
    expect(warnings.single, contains('/x/'));
  });

  test('a page of 20 passes quietly', () async {
    expect(
      await hit(
        envelope({
          'data': List.filled(20, 1),
          'pagination': <String, Object>{},
        }),
      ),
      isEmpty,
    );
  });

  test('a bare array response is measured too', () async {
    expect(await hit(envelope(List.filled(500, 1))), hasLength(1));
  });

  test('the response itself is untouched', () async {
    final dio = fakeDio(
      FakeHttpAdapter({
        'GET /x/': (_) => FakeResponse(200, envelope(List.filled(500, 1))),
      }),
    )..interceptors.add(LargeListInterceptor(warn: (_) {}));
    final r = await dio.get<dynamic>('/x/');
    expect(((r.data as Map)['response'] as List).length, 500);
  });
}
