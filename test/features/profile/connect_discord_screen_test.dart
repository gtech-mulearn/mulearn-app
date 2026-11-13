import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/external_links.dart';
import 'package:mulearn_app/features/profile/presentation/screens/connect_discord_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';
import 'settings_test_support.dart';

void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/user/info/': (_) => FakeResponse(200, loadFixture('dev/user_info')),
      'GET /api/v1/register/connect-discord/': (_) => FakeResponse(400, loadFixture('dev/connect_discord_bad_code')),
    });
  });

  Future<void> pumpAt(WidgetTester tester, String location) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      openExternalProvider.overrideWithValue((_) async => true),
      discordAuthUriProvider.overrideWithValue(Uri.parse('https://discord.com/oauth2/authorize?client_id=1')),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: location, routes: [
      GoRoute(
        path: '/dashboard/connect-discord',
        builder: (_, state) => ConnectDiscordScreen(code: state.uri.queryParameters['code']),
      ),
      GoRoute(path: '/home', builder: (_, __) => const Text('home')),
    ]);
    addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    await settle(tester);
  }

  int connectCalls() =>
      adapter.requests.where((RequestOptions r) => r.uri.path == '/api/v1/register/connect-discord/').length;

  testWidgets('a link without a code makes no request', (tester) async {
    await pumpAt(tester, '/dashboard/connect-discord');

    expect(connectCalls(), 0);
    expect(find.text('Connect Discord'), findsOneWidget);
  });

  testWidgets("a refused code shows the backend's message and a retry", (tester) async {
    await pumpAt(tester, '/dashboard/connect-discord?code=bad');

    expect(connectCalls(), 1);
    expect(find.text("Couldn't connect Discord"), findsOneWidget);
    expect(find.text('Failed to get access token'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('the trailing-slash link Discord may send opens the same screen', (tester) async {
    await pumpAt(tester, '/dashboard/connect-discord/?code=bad');

    expect(find.byType(ConnectDiscordScreen), findsOneWidget);
    expect(connectCalls(), 1);
  });

  testWidgets('a screen opened from the link has a way home', (tester) async {
    await pumpAt(tester, '/dashboard/connect-discord?code=bad');

    await tester.tap(find.text('Not now'));
    await settle(tester);

    expect(find.text('home'), findsOneWidget);
  });
}
