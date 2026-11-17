import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

const teamBase = '/api/v1';

/// 2026-11-18 09:00 UTC.
final teamTestNow = DateTime.utc(2026, 11, 18, 9);

Map<String, dynamic> okEnvelope(Object? response, {String? message}) => {
  'hasError': false,
  'statusCode': 200,
  'message': {
    'general': message == null ? <String>[] : [message],
  },
  'response': response ?? <String, dynamic>{},
};

/// A backend failure body (`hasError: true`) carrying [msg].
Map<String, dynamic> failure(String msg) => {
  'hasError': true,
  'statusCode': 400,
  'message': {
    'general': [msg],
  },
  'response': <String, dynamic>{},
};

/// A fake adapter with [routes] keyed `'<METHOD> <path>'`.
FakeHttpAdapter teamAdapter([
  Map<String, FakeResponse Function(RequestOptions)> routes = const {},
]) => FakeHttpAdapter(Map.of(routes));

/// The requests [adapter] received for [method] [path].
List<RequestOptions> callsTo(
  FakeHttpAdapter adapter,
  String method,
  String path,
) => [
  for (final r in adapter.requests)
    if (r.method.toUpperCase() == method.toUpperCase() && r.uri.path == path) r,
];

/// Pumps an empty router at [location] over the team providers and returns
/// it. The team screens (Tasks 16-19) register their routes here.
Future<GoRouter> pumpTeam(
  WidgetTester tester,
  FakeHttpAdapter adapter,
  String location, {
  DateTime? now,
}) async {
  FlavorConfig.initialize(Flavor.dev);
  final tokens = TokenStorage(FakeSecureStorage());
  await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
  final container = ProviderContainer(
    retry: (_, __) => null,
    overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      clockProvider.overrideWithValue(() => now ?? teamTestNow),
    ],
  );
  addTearDown(container.dispose);
  final router = GoRouter(
    initialLocation: location,
    routes: [GoRoute(path: '/team', builder: (_, __) => const SizedBox())],
  );
  addTearDown(router.dispose);
  tester.view.physicalSize = const Size(1080, 4200);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
  return router;
}
