import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/interest_groups/data/dtos/interest_group_summary_dto.dart';
import 'package:mulearn_app/features/interest_groups/presentation/screens/interest_group_detail_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _web = '4ff0a5e5-d1ef-44dd-ac13-9a2f9e7717e3'; // Web Development (the student is in it)

/// L11 — `public/ig/<id>/` (icon_image, cover_image, office_hours,
/// impact_projects), circles in the group (learningcircle/list/?ig=),
/// events in the group (events/?ig_id=).
void main() {
  test('the detail parses images, office hours and impact projects', () {
    Map<String, dynamic> ig(String f) =>
        (loadFixtureResponse(f)! as Map<String, dynamic>)['interestGroup'] as Map<String, dynamic>;

    final live = InterestGroupSummaryDto.fromJson(ig('dev/public_ig_detail')).toDomain();
    final withProject = InterestGroupSummaryDto.fromJson(ig('serializer/public_ig_detail_with_project')).toDomain();

    expect(live.iconImage, isNull);
    expect(live.coverImage, isNull);
    expect(live.impactProjects, isEmpty);
    expect(withProject.impactProjects.single.title, 'Accessible campus map');
    expect(withProject.impactProjects.single.links.single.url, 'https://github.com/example/campus-map');
  });

  Future<void> pumpDetail(WidgetTester tester, String id) async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/public/ig/$id/': (_) => FakeResponse(200, loadFixture('serializer/public_ig_detail_with_project')),
      'GET /api/v1/dashboard/profile/user-profile/': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
      'GET /api/v1/dashboard/learningcircle/list/': (_) => FakeResponse(200, loadFixture('dev/ig_circles')),
      'GET /api/v1/dashboard/events/': (_) => FakeResponse(200, loadFixture('dev/ig_events')),
    });
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(container.dispose);
    tester.view.physicalSize = const Size(1080, 9000);
    addTearDown(tester.view.resetPhysicalSize);
    final router = GoRouter(initialLocation: '/ig', routes: [
      GoRoute(path: '/ig', builder: (_, __) => InterestGroupDetailScreen(groupId: id)),
      GoRoute(path: '/circles/:id', builder: (_, s) => Text('circle ${s.pathParameters['id']}')),
    ]);
    addTearDown(router.dispose);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  testWidgets("the group's circles and impact projects are listed; no events, no events section", (tester) async {
    await pumpDetail(tester, _web);

    expect(find.text('CIRCLES IN THIS GROUP'), findsOneWidget);
    expect(find.text('Full-Stack Fridays'), findsOneWidget);
    expect(find.text('EVENTS IN THIS GROUP'), findsNothing);
    expect(find.text('IMPACT PROJECTS'), findsOneWidget);
    expect(find.text('Accessible campus map'), findsOneWidget);
  });

  testWidgets("a learner in three groups can't join a fourth", (tester) async {
    await pumpDetail(tester, 'not-one-of-mine'); // dev/user_profile: 3 groups

    expect(find.text("You're in 3 of 3 groups. Leave one to join another."), findsOneWidget);
    expect(find.textContaining('Join '), findsNothing);
  });

  testWidgets('a member can leave after confirming', (tester) async {
    await pumpDetail(tester, _web);

    await tester.tap(find.text('Joined · Leave'));
    await tester.pumpAndSettle();

    expect(find.text('Leave Web Development?'), findsOneWidget);
  });
}
