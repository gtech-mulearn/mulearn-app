import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/core/widgets/role_pending_banner.dart';
import 'package:mulearn_app/core/widgets/workspace_gate.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

/// Plan 4, Task 1 (Review Focus 1): a workspace route opened by someone whose
/// role isn't verified shows the pending banner and never builds — so never
/// fetches — the workspace.
void main() {
  Map<String, dynamic> enablerProfile({required bool verified}) {
    final body = loadFixture('dev/user_profile_enabler');
    final response = Map<String, dynamic>.of(body['response'] as Map<String, dynamic>);
    response['role_verification'] = [
      {'role': 'Student', 'is_verified': true},
      {'role': 'Enabler', 'is_verified': verified},
    ];
    return {...body, 'response': response};
  }

  Future<FakeHttpAdapter> pumpGate(
    WidgetTester tester, {
    required String userInfo,
    required WidgetBuilder builder,
    Map<String, dynamic>? profile,
    WorkspaceState Function(WorkspaceAccess a)? select,
  }) async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/user/info/': (_) => FakeResponse(200, loadFixture(userInfo)),
      'GET /api/v1/dashboard/mentor/status/': (_) => FakeResponse(200, loadFixture('dev/mentor_status')),
      if (profile != null) 'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, profile),
    });
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(container.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(
      container: container,
      child: MaterialApp(
        home: WorkspaceGate(select: select ?? (a) => a.campus, role: 'Enabler', builder: builder),
      ),
    ));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    return adapter;
  }

  testWidgets('a pending role shows the banner and never builds the workspace', (tester) async {
    final adapter = await pumpGate(
      tester,
      userInfo: 'dev/user_info_enabler',
      profile: enablerProfile(verified: false),
      builder: (_) => throw StateError('the workspace must not be built'),
    );

    expect(find.byType(RolePendingBanner), findsOneWidget);
    expect(find.text('Enabler account pending verification'), findsOneWidget);
    expect(
      find.text('Your enabler profile is awaiting admin approval. You will be notified once your account is verified.'),
      findsOneWidget,
    );
    expect(adapter.requests.where((r) => r.path.startsWith('/api/v1/dashboard/campus/')), isEmpty);
    expect(tester.takeException(), isNull);
  });

  // Final review, Important 4: the session providers are kept alive and never
  // auto-retried, so Retry has to fetch them again, not re-read the failure.
  testWidgets('Retry recovers when user info failed once', (tester) async {
    var calls = 0;
    final adapter = await pumpGate(
      tester,
      userInfo: 'dev/user_info_enabler',
      profile: enablerProfile(verified: true),
      builder: (_) => const Text('workspace'),
    );
    adapter.routes['GET /api/v1/dashboard/user/info/'] =
        (_) => ++calls == 1 ? const FakeResponse(-1, null) : FakeResponse(200, loadFixture('dev/user_info_enabler'));
    // The first load in pumpGate succeeded; fail it as if at launch.
    ProviderScope.containerOf(tester.element(find.byType(WorkspaceGate))).invalidate(currentUserProvider);
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('workspace'), findsNothing);

    await tester.tap(find.text('Retry'));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
    expect(find.text('workspace'), findsOneWidget);
    expect(calls, 2);
  });

  testWidgets('a verified role builds the workspace', (tester) async {
    await pumpGate(
      tester,
      userInfo: 'dev/user_info_enabler',
      profile: enablerProfile(verified: true),
      builder: (_) => const Text('campus workspace'),
    );

    expect(find.text('campus workspace'), findsOneWidget);
    expect(find.byType(RolePendingBanner), findsNothing);
  });

  testWidgets('someone without the role sees that the workspace is not theirs', (tester) async {
    await pumpGate(
      tester,
      userInfo: 'dev/user_info',
      profile: loadFixture('dev/user_profile'),
      select: (a) => a.mentor,
      builder: (_) => throw StateError('the workspace must not be built'),
    );

    expect(find.text("This workspace isn't available for your account."), findsOneWidget);
    expect(tester.widget<MuStateDisplay>(find.byType(MuStateDisplay)).variant, MuStateVariant.notFound);
    expect(tester.takeException(), isNull);
  });

  testWidgets('the mentor banner uses the dashboard copy', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: RolePendingBanner(role: 'Mentor'))));

    expect(find.text('Mentor account pending verification'), findsOneWidget);
    expect(
      find.text('Your mentor profile is awaiting admin approval. You will be notified once your account is verified.'),
      findsOneWidget,
    );
  });
}
