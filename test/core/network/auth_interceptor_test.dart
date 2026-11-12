import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/network/auth_interceptor.dart';
import 'package:mulearn_app/core/network/session_event_bus.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

/// dev.mulearn.org answers an expired/invalid access token with 403, and
/// POST /api/v1/auth/get-access-token/ with a revoked refresh token with
/// 400 {hasError: true, "Token has been invalidated. Please log in again."}
/// (verified live 2026-11-12).
const _refresh = 'POST /api/v1/auth/get-access-token/';

Map<String, dynamic> envelope(Object? response, {int status = 200, List<String> general = const []}) => {
      'hasError': status >= 400,
      'statusCode': status,
      'message': {'general': general},
      'response': response,
    };

final _forbidden = envelope({}, status: 403, general: ['Invalid token']);

class MockCacheStore extends Mock implements CacheStore {}

class Harness {
  Harness({required Map<String, FakeResponse Function(RequestOptions)> api, required this.refreshRoutes}) {
    apiAdapter = FakeHttpAdapter(api);
    refreshAdapter = FakeHttpAdapter(refreshRoutes);
    tokens = TokenStorage(storage);
    when(cache.clean).thenAnswer((_) async {});
    bus.events.listen(events.add);
    dio = fakeDio(apiAdapter)
      ..interceptors.add(AuthInterceptor(
        refreshDio: fakeDio(refreshAdapter),
        tokenStorage: tokens,
        sessionEventBus: bus,
        cacheStore: cache,
      ));
  }

  final Map<String, FakeResponse Function(RequestOptions)> refreshRoutes;
  final storage = FakeSecureStorage();
  final bus = SessionEventBus();
  final cache = MockCacheStore();
  final events = <SessionEvent>[];
  late final FakeHttpAdapter apiAdapter;
  late final FakeHttpAdapter refreshAdapter;
  late final TokenStorage tokens;
  late final Dio dio;

  Future<void> signIn() => tokens.saveTokens(accessToken: 'old-access', refreshToken: 'refresh-1');

  int get refreshCalls =>
      refreshAdapter.requests.where((r) => r.path.endsWith('/get-access-token/')).length;
}

void main() {
  test('403 → refresh → retry succeeds and stores the new access token', () async {
    final h = Harness(
      api: {'GET /api/v1/x/': (_) => FakeResponse(403, _forbidden)},
      refreshRoutes: {
        _refresh: (_) => FakeResponse(200, envelope({'accessToken': 'new-access', 'expiry': 'x'})),
        'GET /api/v1/x/': (_) => FakeResponse(200, envelope({'ok': true})),
      },
    );
    await h.signIn();

    final res = await h.dio.get<dynamic>('/api/v1/x/');

    expect((res.data as Map)['response'], {'ok': true});
    expect(await h.tokens.readAccessToken(), 'new-access');
    expect(h.refreshAdapter.requests.last.headers['Authorization'], 'Bearer new-access');
  });

  test('a rejected refresh (400 hasError) clears the session and signals expiry once', () async {
    final h = Harness(
      api: {'GET /api/v1/x/': (_) => FakeResponse(403, _forbidden)},
      refreshRoutes: {
        _refresh: (_) => FakeResponse(
              400,
              envelope({}, status: 400, general: ['Token has been invalidated. Please log in again.']),
            ),
      },
    );
    await h.signIn();

    await expectLater(h.dio.get<dynamic>('/api/v1/x/'), throwsA(isA<DioException>()));
    await Future<void>.delayed(Duration.zero);

    expect(await h.tokens.readAccessToken(), isNull);
    expect(await h.tokens.readRefreshToken(), isNull);
    expect(h.events, [SessionEvent.expired]);
    verify(h.cache.clean).called(1);
  });

  test('a refresh that never reaches the server keeps the session', () async {
    final h = Harness(
      api: {'GET /api/v1/x/': (_) => FakeResponse(403, _forbidden)},
      refreshRoutes: {_refresh: (_) => const FakeResponse(-1, null)},
    );
    await h.signIn();

    final error = await h.dio.get<dynamic>('/api/v1/x/').then<DioException?>((_) => null,
        onError: (Object e) => e as DioException);
    await Future<void>.delayed(Duration.zero);

    expect(error?.response?.statusCode, 403, reason: 'the caller sees the original 403');
    expect(await h.tokens.readAccessToken(), 'old-access');
    expect(await h.tokens.readRefreshToken(), 'refresh-1');
    expect(h.events, isEmpty);
    verifyNever(h.cache.clean);
  });

  test('a 5xx from the refresh endpoint keeps the session', () async {
    final h = Harness(
      api: {'GET /api/v1/x/': (_) => FakeResponse(403, _forbidden)},
      refreshRoutes: {_refresh: (_) => const FakeResponse(502, {'detail': 'Bad gateway'})},
    );
    await h.signIn();

    await expectLater(h.dio.get<dynamic>('/api/v1/x/'), throwsA(isA<DioException>()));
    await Future<void>.delayed(Duration.zero);

    expect(await h.tokens.readRefreshToken(), 'refresh-1');
    expect(h.events, isEmpty);
  });

  test('concurrent 403s share one refresh', () async {
    final h = Harness(
      api: {
        'GET /api/v1/a/': (_) => FakeResponse(403, _forbidden),
        'GET /api/v1/b/': (_) => FakeResponse(403, _forbidden),
      },
      refreshRoutes: {
        _refresh: (_) => FakeResponse(200, envelope({'accessToken': 'new-access'})),
        'GET /api/v1/a/': (_) => FakeResponse(200, envelope({'a': 1})),
        'GET /api/v1/b/': (_) => FakeResponse(200, envelope({'b': 1})),
      },
    );
    await h.signIn();

    await Future.wait([h.dio.get<dynamic>('/api/v1/a/'), h.dio.get<dynamic>('/api/v1/b/')]);

    expect(h.refreshCalls, 1);
  });

  test('a multipart request is retried with a fresh FormData', () async {
    final h = Harness(
      api: {'POST /api/v1/upload/': (_) => FakeResponse(403, _forbidden)},
      refreshRoutes: {
        _refresh: (_) => FakeResponse(200, envelope({'accessToken': 'new-access'})),
        'POST /api/v1/upload/': (_) => FakeResponse(200, envelope({'ok': true})),
      },
    );
    await h.signIn();
    final original = FormData.fromMap({'caption': 'cover'});

    await h.dio.post<dynamic>('/api/v1/upload/', data: original);

    final retried = h.refreshAdapter.requests.last;
    expect(retried.data, isA<FormData>());
    expect(identical(retried.data, original), isFalse);
    expect(
      retried.headers[Headers.contentTypeHeader] ?? retried.contentType,
      contains((retried.data as FormData).boundary),
    );
  });
}
