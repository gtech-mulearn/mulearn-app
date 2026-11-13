import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/profile/presentation/screens/journey_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

void main() {
  Future<void> pumpJourney(WidgetTester tester) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/profile/get-user-levels/': (_) => FakeResponse(200, loadFixture('dev/get_user_levels')),
      'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
    });
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(container.dispose);
    tester.view.physicalSize = const Size(1080, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: const MaterialApp(home: JourneyScreen())));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('the recorded lvl1 learner is at Level 1 and has cleared nothing', (tester) async {
    await pumpJourney(tester); // dev/user_profile: level lvl1

    expect(find.text('YOU ARE HERE'), findsOneWidget);
    expect(find.text('CLEARED'), findsNothing);
    // The pill sits in the same row as the level's name.
    final current = find.ancestor(of: find.text('YOU ARE HERE'), matching: find.byType(Row));
    expect(find.descendant(of: current.first, matching: find.text('Level 1')), findsOneWidget);
  });

  testWidgets('no raw level names and no full ring for an empty level', (tester) async {
    await pumpJourney(tester);

    expect(find.textContaining('lvl'), findsNothing);
    expect(find.text('No tasks in this level yet'), findsWidgets);
  });
}
