import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/discord_connect.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/widgets/role_pending_banner.dart';
import 'package:mulearn_app/features/dashboard/presentation/screens/home_screen.dart';
import 'package:mulearn_app/features/profile/presentation/screens/profile_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _pendingCopy = 'Mentor account pending verification';

/// Plan 4, Task 1 (ROLE-02): a pending role is announced on Home and Profile,
/// as the dashboard's VerificationStatusBanner does.
void main() {
  Map<String, dynamic> mentorStatus(String status) {
    final body = loadFixture('dev/mentor_status');
    final rows = (body['response'] as List).map((r) => {...r as Map<String, dynamic>, 'status': status}).toList();
    return {...body, 'response': rows};
  }

  FakeHttpAdapter adapterFor({required String userInfo, required String profile, String mentor = 'APPROVED'}) {
    return FakeHttpAdapter({
      'GET /api/v1/dashboard/user/info/': (_) => FakeResponse(200, loadFixture(userInfo)),
      'GET /api/v1/dashboard/mentor/status/': (_) => FakeResponse(200, mentorStatus(mentor)),
      'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture(profile)),
      'GET /api/v1/dashboard/home/learner/summary/': (_) => FakeResponse(200, loadFixture('dev/learner_summary')),
      'GET /api/v1/leaderboard/students/': (_) => FakeResponse(200, loadFixture('dev/leaderboard_students')),
      'GET /api/v1/dashboard/events/featured/': (_) => FakeResponse(200, loadFixture('dev/events_featured')),
      'GET /api/v1/dashboard/profile/': (_) => FakeResponse(200, loadFixture('dev/editable_profile')),
      'GET /api/v1/notification/unread-count/': (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': <String>[]},
            'response': {'unread_count': 0},
          }),
    });
  }

  Future<void> pump(WidgetTester tester, FakeHttpAdapter adapter, Widget screen) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      discordAuthUriProvider.overrideWithValue(Uri.parse('https://discord.com/oauth2/authorize?client_id=1')),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/s', routes: [GoRoute(path: '/s', builder: (_, __) => screen)]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('Home announces a pending mentor', (tester) async {
    await pump(
      tester,
      adapterFor(userInfo: 'dev/user_info_mentor', profile: 'dev/user_profile_mentor', mentor: 'PENDING'),
      const HomeScreen(),
    );

    expect(find.text(_pendingCopy), findsOneWidget);
  });

  testWidgets('Home shows no banner for an approved mentor', (tester) async {
    await pump(tester, adapterFor(userInfo: 'dev/user_info_mentor', profile: 'dev/user_profile_mentor'), const HomeScreen());
    expect(find.byType(RolePendingBanner), findsNothing);
  });

  testWidgets('Home shows no banner for a learner', (tester) async {
    await pump(tester, adapterFor(userInfo: 'dev/user_info', profile: 'dev/user_profile'), const HomeScreen());
    expect(find.byType(RolePendingBanner), findsNothing);
  });

  testWidgets('Profile announces a pending mentor', (tester) async {
    await pump(
      tester,
      adapterFor(userInfo: 'dev/user_info_mentor', profile: 'dev/user_profile_mentor', mentor: 'PENDING'),
      const ProfileScreen(),
    );

    expect(find.text(_pendingCopy), findsOneWidget);
  });
}
