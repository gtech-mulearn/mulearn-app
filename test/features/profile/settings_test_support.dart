import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/external_links.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const profilePath = '/api/v1/dashboard/profile/user-profile/';
const userInfoPath = '/api/v1/dashboard/user/info/';
const sharePath = '/api/v1/dashboard/profile/share-user-profile/';
const changePasswordPath = '/api/v1/dashboard/profile/change-password/';

const okEnvelope = FakeResponse(200, {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>['ok']},
  'response': <String, dynamic>{},
});

FakeHttpAdapter settingsAdapter([Map<String, FakeResponse Function(RequestOptions)> extra = const {}]) => FakeHttpAdapter({
      'GET $profilePath': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
      'GET $userInfoPath': (_) => FakeResponse(200, loadFixture('dev/user_info')),
      ...extra,
    });

/// Pumps [screen] at '/settings…' inside a router that also has a Profile
/// and a sign-in page, signed in, with external links recorded in [opened].
Future<ProviderContainer> pumpSettingsApp(
  WidgetTester tester,
  FakeHttpAdapter adapter, {
  required String location,
  required Map<String, Widget Function()> routes,
  List<Uri>? opened,
}) async {
  final tokens = TokenStorage(FakeSecureStorage());
  await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
  final container = ProviderContainer(
    retry: (_, __) => null,
    overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      openExternalProvider.overrideWithValue((uri) async {
        opened?.add(uri);
        return true;
      }),
    ],
  );
  addTearDown(container.dispose);
  final router = GoRouter(
    initialLocation: '/start',
    routes: [
      GoRoute(
        path: '/start',
        builder: (context, __) => Scaffold(
          body: TextButton(onPressed: () => context.push(location), child: const Text('open')),
        ),
      ),
      for (final r in routes.entries) GoRoute(path: r.key, builder: (_, __) => r.value()),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(UncontrolledProviderScope(
    container: container,
    child: MaterialApp.router(routerConfig: router),
  ));
  await tester.tap(find.text('open'));
  await settle(tester);
  return container;
}

/// Lets fake HTTP replies and animations finish.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pumpAndSettle();
}
