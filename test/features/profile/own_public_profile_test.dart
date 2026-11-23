import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/public_profile_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

/// `GET user-profile/<muid>/` answers "Private Profile" to everyone for a
/// private profile, the owner included. Opening yourself from search, a
/// board or a circle must still show your profile (user, 2026-11-23).
void main() {
  const privateProfile = FakeResponse(400, {
    'hasError': true,
    'statusCode': 400,
    'message': {
      'general': ['Private Profile'],
    },
    'response': <String, dynamic>{},
  });

  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/user/info/': (_) =>
          FakeResponse(200, loadFixture('dev/user_info')),
      'GET /api/v1/dashboard/profile/user-profile/': (_) =>
          FakeResponse(200, loadFixture('dev/user_profile')),
      'GET /api/v1/dashboard/profile/': (_) =>
          FakeResponse(200, loadFixture('dev/editable_profile')),
      'GET /api/v1/dashboard/profile/user-profile/qastudentone@mulearn/': (_) =>
          privateProfile,
      'GET /api/v1/dashboard/profile/user-profile/someone@mulearn/': (_) =>
          privateProfile,
    });
  });

  Future<GoRouter> pump(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, __) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        discordAuthUriProvider.overrideWithValue(
          Uri.parse('https://discord.com/oauth2/authorize?client_id=1'),
        ),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (_, __) => const Text('root')),
        GoRoute(path: '/me', builder: (_, __) => const ProfileScreen()),
        GoRoute(
          path: '/u/:muid',
          builder: (_, state) =>
              PublicProfileScreen(muid: state.pathParameters['muid']!),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await settle(tester);
    return router;
  }

  testWidgets('your own private profile opens with your tools', (tester) async {
    final router = await pump(tester);
    unawaited(
      router.push('/u/${Uri.encodeComponent(' QAStudentOne@mulearn ')}'),
    );
    await settle(tester);

    expect(find.text('Profile not found'), findsNothing);
    expect(find.byTooltip('Edit profile'), findsOneWidget);
    expect(find.byTooltip('Back'), findsOneWidget);
    expect(
      adapter.requests.where(
        (r) => r.uri.path.toLowerCase().endsWith(
          '/user-profile/qastudentone@mulearn/',
        ),
      ),
      isEmpty,
    );
  });

  testWidgets("someone else's private profile still says not found", (
    tester,
  ) async {
    final router = await pump(tester);
    unawaited(router.push('/u/someone@mulearn'));
    await settle(tester);

    expect(find.text('Profile not found'), findsOneWidget);
  });

  testWidgets('the You tab has no back button', (tester) async {
    final router = await pump(tester);
    router.go('/me');
    await settle(tester);

    expect(find.byTooltip('Edit profile'), findsOneWidget);
    expect(find.byTooltip('Back'), findsNothing);
  });
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 10; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}
