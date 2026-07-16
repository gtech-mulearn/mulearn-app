import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed_top_user.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late MockDashboardRepository repository;

  setUp(() => repository = MockDashboardRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [dashboardRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('KarmaFeedController loads the karma feed on build', () async {
    const feed = KarmaFeed(
      topUser: KarmaFeedTopUser(fullName: 'Ada', muid: 'ada@mulearn', karma: 100),
    );
    when(() => repository.getKarmaFeed()).thenAnswer((_) async => feed);

    final container = makeContainer();
    final result = await container.read(karmaFeedControllerProvider.future);

    expect(result.topUser?.fullName, 'Ada');
    verify(() => repository.getKarmaFeed()).called(1);
  });

  test('KarmaFeedController.refresh() re-fetches', () async {
    const feed = KarmaFeed();
    when(() => repository.getKarmaFeed()).thenAnswer((_) async => feed);

    final container = makeContainer();
    await container.read(karmaFeedControllerProvider.future);
    await container.read(karmaFeedControllerProvider.notifier).refresh();

    verify(() => repository.getKarmaFeed()).called(2);
  });

  test('FeaturedEventsController surfaces repository errors as AsyncError',
      () async {
    when(() => repository.getFeaturedEvents())
        .thenAnswer((_) async => throw Exception('boom'));

    final container = makeContainer();
    final sub = container.listen(featuredEventsControllerProvider, (_, __) {});
    addTearDown(sub.close);

    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(featuredEventsControllerProvider);
    expect(state.hasError, isTrue);
  });

  test('MyProgressSummaryController loads the summary on build', () async {
    const summary = MyProgressSummary(
      fullName: 'Ada Lovelace',
      muid: 'ada@mulearn',
      karma: 4200,
      level: 'Level 5',
    );
    when(() => repository.getMyProgressSummary())
        .thenAnswer((_) async => summary);

    final container = makeContainer();
    final result =
        await container.read(myProgressSummaryControllerProvider.future);

    expect(result.karma, 4200);
    verify(() => repository.getMyProgressSummary()).called(1);
  });
}
