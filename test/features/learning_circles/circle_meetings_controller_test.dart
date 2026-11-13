import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/learning_circles/data/datasources/learning_circles_remote_datasource.dart';
import 'package:mulearn_app/features/learning_circles/data/repositories/learning_circles_repository_impl.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_page.dart';
import 'package:mulearn_app/features/learning_circles/domain/repositories/learning_circles_repository.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/meetings_controller.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';

class MockLearningCirclesRepository extends Mock implements LearningCirclesRepository {}

const _listPath = 'GET /api/v1/dashboard/learningcircle/meeting/list/c1/';

Meeting meeting(String id) => Meeting(
      id: id,
      title: 'Meeting $id',
      description: 'd',
      mode: 'online',
      meetPlace: 'Google Meet',
      meetTime: '2026-11-20T18:00:00+05:30',
      circleId: 'c1',
      igName: 'Mobile Development',
      isStarted: false,
      isEnded: false,
      attendeesCount: 0,
      createdBy: 'Fixture User',
    );

void main() {
  group('meeting list contract (paginated since backend 5dd14fa0)', () {
    test('fetchCircleMeetings pages with pageIndex/perPage', () async {
      final adapter = FakeHttpAdapter({
        _listPath: (_) => FakeResponse(200, loadFixture('serializer/meeting_list_page')),
      });

      await LearningCirclesRemoteDataSource(fakeDio(adapter))
          .fetchCircleMeetings('c1', pageIndex: 2);

      expect(adapter.requests.single.queryParameters, {'pageIndex': 2, 'perPage': 20});
    });

    test('the repository maps the paginated payload to a MeetingPage', () async {
      final repo = LearningCirclesRepositoryImpl(LearningCirclesRemoteDataSource(fakeDio(
        FakeHttpAdapter({
          _listPath: (_) => FakeResponse(200, loadFixture('serializer/meeting_list_page')),
        }),
      )));

      final page = await repo.getCircleMeetings('c1', pageIndex: 1);

      expect(page.hasNext, isTrue);
      expect(page.meetings.single.igName, 'Mobile Development');
      expect(page.meetings.single.circleId, 'c1');
      expect(page.meetings.single.attendeesCount, 3);
    });

    test('parses the meeting list recorded live on dev', () async {
      final repo = LearningCirclesRepositoryImpl(LearningCirclesRemoteDataSource(fakeDio(
        FakeHttpAdapter({
          _listPath: (_) => FakeResponse(200, loadFixture('dev/meeting_list_page1')),
        }),
      )));

      final page = await repo.getCircleMeetings('c1', pageIndex: 1);

      expect(page.meetings, hasLength(2));
      expect(page.meetings.map((m) => m.mode), containsAll(['online', 'offline']));
      expect(page.hasNext, isFalse);
    });
  });

  group('CircleMeetingsController', () {
    late MockLearningCirclesRepository repo;

    setUp(() => repo = MockLearningCirclesRepository());

    ProviderContainer makeContainer() {
      final container = ProviderContainer(
        overrides: [learningCirclesRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      container.listen(circleMeetingsControllerProvider('c1'), (_, __) {});
      return container;
    }

    test('build loads page 1', () async {
      when(() => repo.getCircleMeetings('c1', pageIndex: 1))
          .thenAnswer((_) async => MeetingPage(meetings: [meeting('m1')], hasNext: true));
      final c = makeContainer();

      final state = await c.read(circleMeetingsControllerProvider('c1').future);

      expect(state.items.map((m) => m.id), ['m1']);
      expect(state.hasMore, isTrue);
    });

    test('loadMore appends the next page', () async {
      when(() => repo.getCircleMeetings('c1', pageIndex: 1))
          .thenAnswer((_) async => MeetingPage(meetings: [meeting('m1')], hasNext: true));
      when(() => repo.getCircleMeetings('c1', pageIndex: 2))
          .thenAnswer((_) async => MeetingPage(meetings: [meeting('m2')], hasNext: false));
      final c = makeContainer();
      await c.read(circleMeetingsControllerProvider('c1').future);

      await c.read(circleMeetingsControllerProvider('c1').notifier).loadMore();

      final state = c.read(circleMeetingsControllerProvider('c1')).requireValue;
      expect(state.items.map((m) => m.id), ['m1', 'm2']);
      expect(state.hasMore, isFalse);
    });

    test('empty meeting list shows nothing and requests nothing more', () async {
      when(() => repo.getCircleMeetings('c1', pageIndex: 1))
          .thenAnswer((_) async => const MeetingPage(meetings: [], hasNext: false));
      final c = makeContainer();
      await c.read(circleMeetingsControllerProvider('c1').future);

      await c.read(circleMeetingsControllerProvider('c1').notifier).loadMore();

      expect(c.read(circleMeetingsControllerProvider('c1')).requireValue.items, isEmpty);
      verifyNever(() => repo.getCircleMeetings('c1', pageIndex: 2));
    });
  });
}
