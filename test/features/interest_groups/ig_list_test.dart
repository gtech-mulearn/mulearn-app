import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/interest_groups/data/dtos/interest_group_summary_dto.dart';
import 'package:mulearn_app/features/interest_groups/domain/entities/interest_group_summary.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/interest_groups/presentation/screens/interest_groups_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

/// The IG sticker wall: dev/ig_list (23 groups with categories) and
/// dev/user_profile (the student is in Ui Ux, Web Development and AI).
List<InterestGroupSummary> _catalog() => [
  for (final row
      in (loadFixtureResponse('dev/ig_list')!
              as Map<String, dynamic>)['interestGroup']
          as List<dynamic>)
    InterestGroupSummaryDto.fromJson(row as Map<String, dynamic>).toDomain(),
];

void main() {
  late FakeHttpAdapter adapter;

  Future<void> pump(WidgetTester tester) async {
    adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/profile/user-profile/': (_) =>
          FakeResponse(200, loadFixture('dev/user_profile')),
    });
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        // The recorded catalog (~100KB) would be decoded by Dio on a
        // background isolate, which never runs under the test clock; the
        // datasource has its own tests, so feed the parsed rows directly.
        interestGroupsCatalogProvider.overrideWith((_) async => _catalog()),
      ],
    );
    addTearDown(container.dispose);
    tester.view.physicalSize = const Size(1080, 12000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: MuThemeData.light(),
          home: const InterestGroupsScreen(),
        ),
      ),
    );
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets('your groups come first, then the rest', (tester) async {
    await pump(tester);

    expect(find.text('YOURS · 3 OF 3'), findsOneWidget);
    expect(find.text('MORE TO EXPLORE'), findsOneWidget);
    final yoursTop = tester.getTopLeft(find.text('Web Development')).dy;
    expect(
      yoursTop,
      lessThan(tester.getTopLeft(find.text('MORE TO EXPLORE')).dy),
    );
    expect(find.byType(MuIgSticker), findsNWidgets(23));
  });

  testWidgets('search and category chips narrow the wall', (tester) async {
    await pump(tester);

    await tester.enterText(find.byType(TextField), 'blend');
    await tester.pump();
    expect(find.byType(MuIgSticker), findsOneWidget);
    expect(find.text('Blender'), findsOneWidget);

    await tester.enterText(find.byType(TextField), '');
    await tester.tap(find.widgetWithText(MuFilterChip, 'Maker'));
    await tester.pump();
    expect(
      find.byType(MuIgSticker),
      findsNWidgets(2),
    ); // IoT and Robotics, Space
    expect(find.text('Space'), findsOneWidget);
    expect(find.text('Civil'), findsNothing);
  });

  testWidgets('at three groups, Join says why instead of calling the backend', (
    tester,
  ) async {
    await pump(tester);

    await tester.tap(find.bySemanticsLabel('Join Data Science'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text("You're in 3 of 3 groups. Leave one to join another."),
      findsOneWidget,
    );
    expect(adapter.requests.where((r) => r.method == 'POST'), isEmpty);
    await tester.pump(const Duration(seconds: 5)); // let the toast leave
  });
}
