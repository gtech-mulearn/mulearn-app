import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/config/feature_flags.dart';
import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:mulearn_app/features/profile/data/dtos/achievement_progress_dto.dart';
import 'package:mulearn_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:mulearn_app/features/profile/domain/achievement_sections.dart';
import 'package:mulearn_app/features/profile/presentation/widgets/achievements_tab.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _muid = 'qastudentone@mulearn';
const _earned = '/api/v1/dashboard/achievement/list/user/$_muid/';
const _eligible = '/api/v1/dashboard/achievement/eligible/';
const _progress = '/api/v1/dashboard/achievement/progress/';
const _catalog = '/api/v1/dashboard/achievement/list/';

/// FEAT-06: `eligible/`, `progress/`, `claim/<id>/` (achievement_views.py:442-554;
/// claim_achievement in mu_celery/achievement_tasks.py). Recorded on dev with
/// two QA-only badges (milestone total_karma ≥ 0 and ≥ 500), then removed.
void main() {
  List<Map<String, dynamic>> listOf(String fixture) =>
      (loadFixtureResponse(fixture)! as List<dynamic>).cast<Map<String, dynamic>>();

  group('progress items', () {
    test('eligible and progress replies parse', () {
      final eligible = listOf('dev/achievement_eligible').map((j) => AchievementProgressDto.fromJson(j).toDomain()).toList();
      final progress = listOf('dev/achievement_progress').map((j) => AchievementProgressDto.fromJson(j).toDomain()).toList();

      expect(eligible.single.name, 'QA Starter Badge');
      expect(eligible.single.eligible, isTrue);
      final rising = progress.firstWhere((p) => p.name == 'QA Rising Badge');
      expect(rising.eligible, isFalse);
      expect(rising.current, 0);
      expect(rising.required, 500);
      expect(rising.percentage, 0);
    });

    test('a progress dict without percentage derives it', () {
      final p = AchievementProgressDto.fromJson({
        'achievement_id': 'a',
        'achievement_name': 'n',
        'eligible': false,
        'reason': 'Streak: 3/10 days',
        'progress': {'current': 3, 'required': 10},
      }).toDomain();

      expect(p.percentage, 30);
    });
  });

  test("In Progress is what's neither earned nor ready to claim (the dashboard's filter)", () {
    final progress = listOf('dev/achievement_progress').map((j) => AchievementProgressDto.fromJson(j).toDomain()).toList();
    final eligible = listOf('dev/achievement_eligible').map((j) => AchievementProgressDto.fromJson(j).toDomain()).toList();

    final inProgress = inProgressAchievements(progress, earnedIds: const {}, eligibleIds: {for (final e in eligible) e.achievementId});

    expect(inProgress.map((p) => p.name), ['QA Rising Badge']);
  });

  group('claim', () {
    ProfileRepositoryImpl repo(FakeHttpAdapter adapter) => ProfileRepositoryImpl(
          remote: ProfileRemoteDataSource(fakeDio(adapter)),
          locationRemote: LocationRemoteDataSource(fakeDio(adapter)),
        );

    test('a claim posts to claim/<id>/ and returns the backend message', () async {
      final adapter = FakeHttpAdapter({
        'POST /api/v1/dashboard/achievement/claim/a1/': (_) => FakeResponse(200, loadFixture('dev/achievement_claim_ok')),
      });

      final result = await repo(adapter).claimAchievement('a1');

      expect(result.achievementName, 'QA Starter Badge');
      expect(result.message, 'Achievement claimed successfully!');
      expect(result.vcPending, isFalse);
    });

    test("a refused claim surfaces the backend's reason", () async {
      final adapter = FakeHttpAdapter({
        'POST /api/v1/dashboard/achievement/claim/a1/': (_) => FakeResponse(400, loadFixture('dev/achievement_claim_repeat')),
      });

      await expectLater(
        repo(adapter).claimAchievement('a1'),
        throwsA(isA<ApiException>().having((e) => e.message, 'message', 'Achievement already claimed')),
      );
    });
  });

  group('tab', () {
    late FakeHttpAdapter adapter;
    var claimed = false;

    setUp(() {
      claimed = false;
      adapter = FakeHttpAdapter({
        'GET $_earned': (_) => claimed
            ? FakeResponse(200, loadFixture('dev/achievement_user_earned'))
            : const FakeResponse(200, {
                'hasError': false,
                'statusCode': 200,
                'message': {'general': <String>[]},
                'response': <Object>[],
              }),
        'GET $_eligible': (_) => claimed
            ? const FakeResponse(200, {
                'hasError': false,
                'statusCode': 200,
                'message': {'general': <String>[]},
                'response': <Object>[],
              })
            : FakeResponse(200, loadFixture('dev/achievement_eligible')),
        'GET $_progress': (_) => FakeResponse(200, loadFixture('dev/achievement_progress')),
        'GET $_catalog': (_) => FakeResponse(200, loadFixture('dev/achievement_catalog')),
        'POST /api/v1/dashboard/achievement/claim/f98238dc-b660-4dcf-aa63-e765fadeb4a3/': (_) {
          claimed = true;
          return FakeResponse(200, loadFixture('dev/achievement_claim_ok'));
        },
      });
    });

    Future<void> pumpTab(WidgetTester tester, {bool own = true}) async {
      final tokens = TokenStorage(FakeSecureStorage());
      await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
      final container = ProviderContainer(retry: (_, __) => null, overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
      ]);
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(home: Scaffold(body: AchievementsTab(muid: _muid, userName: 'QA', isOwnProfile: own))),
      ));
      await settle(tester);
    }

    testWidgets('your own profile: Earned, Eligible and In Progress', (tester) async {
      await pumpTab(tester);

      expect(find.text('Earned'), findsOneWidget);
      expect(find.text('Eligible'), findsOneWidget);
      expect(find.text('In Progress'), findsOneWidget);

      await tester.tap(find.text('In Progress'));
      await settle(tester);
      expect(find.text('QA Rising Badge'), findsOneWidget);
      expect(find.text('0 / 500'), findsOneWidget);
    });

    testWidgets('claiming moves a badge from Eligible to Earned', (tester) async {
      await pumpTab(tester);
      await tester.tap(find.text('Eligible'));
      await settle(tester);

      await tester.tap(find.widgetWithText(TextButton, 'Claim'));
      await settle(tester);

      expect(adapter.requests.where((RequestOptions r) => r.method == 'POST'), hasLength(1));
      expect(find.text('Achievement claimed successfully!'), findsOneWidget);
      await tester.tap(find.text('Earned'));
      await settle(tester);
      expect(find.text('QA Starter Badge'), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    testWidgets("someone else's profile shows only what they earned", (tester) async {
      claimed = true;
      await pumpTab(tester, own: false);

      expect(find.text('Eligible'), findsNothing);
      expect(find.text('QA Starter Badge'), findsOneWidget);
      expect(adapter.requests.where((RequestOptions r) => r.uri.path == _eligible), isEmpty);
    });

    testWidgets('credential issuing stays hidden (SEC-04)', (tester) async {
      claimed = true;
      await pumpTab(tester);

      expect(FeatureFlags.vcIssuance, isFalse);
      expect(find.text('Issue'), findsNothing);
    });
  });
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 6; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
  await tester.pumpAndSettle();
}
