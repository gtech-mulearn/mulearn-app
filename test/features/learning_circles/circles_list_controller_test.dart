import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/learning_circle_page.dart';
import 'package:mulearn_app/features/learning_circles/domain/repositories/learning_circles_repository.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

class MockLearningCirclesRepository extends Mock implements LearningCirclesRepository {}

LearningCirclePage page(List<String> ids, {required bool hasNext}) => LearningCirclePage(
      circles: [
        for (final id in ids) LearningCircle(id: id, ig: 'Web', title: 'Circle $id', totalMembers: 1),
      ],
      hasNext: hasNext,
    );

void main() {
  late MockLearningCirclesRepository repo;

  setUp(() => repo = MockLearningCirclesRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [learningCirclesRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    container.listen(circlesListControllerProvider, (_, __) {});
    return container;
  }

  List<String> ids(ProviderContainer c) =>
      c.read(circlesListControllerProvider).requireValue.items.map((e) => e.id).toList();

  test('build loads page 1', () async {
    when(() => repo.getCircles(pageIndex: 1))
        .thenAnswer((_) async => page(['a', 'b'], hasNext: true));
    final c = makeContainer();

    final state = await c.read(circlesListControllerProvider.future);

    expect(state.items.map((e) => e.id), ['a', 'b']);
    expect(state.hasMore, isTrue);
  });

  test('loadMore appends page 2 without duplicates', () async {
    when(() => repo.getCircles(pageIndex: 1))
        .thenAnswer((_) async => page(['a', 'b'], hasNext: true));
    when(() => repo.getCircles(pageIndex: 2))
        .thenAnswer((_) async => page(['b', 'c'], hasNext: false));
    final c = makeContainer();
    await c.read(circlesListControllerProvider.future);

    await c.read(circlesListControllerProvider.notifier).loadMore();

    expect(ids(c), ['a', 'b', 'c']);
  });

  test('loadMore error keeps items', () async {
    when(() => repo.getCircles(pageIndex: 1))
        .thenAnswer((_) async => page(['a'], hasNext: true));
    when(() => repo.getCircles(pageIndex: 2)).thenThrow(Exception('offline'));
    final c = makeContainer();
    await c.read(circlesListControllerProvider.future);

    await c.read(circlesListControllerProvider.notifier).loadMore();

    final state = c.read(circlesListControllerProvider).requireValue;
    expect(ids(c), ['a']);
    expect(state.loadMoreError, isNotNull);
  });

  test('concurrent loadMore issues one request', () async {
    final pending = Completer<LearningCirclePage>();
    when(() => repo.getCircles(pageIndex: 1))
        .thenAnswer((_) async => page(['a'], hasNext: true));
    when(() => repo.getCircles(pageIndex: 2)).thenAnswer((_) => pending.future);
    final c = makeContainer();
    await c.read(circlesListControllerProvider.future);

    final notifier = c.read(circlesListControllerProvider.notifier);
    final first = notifier.loadMore();
    final second = notifier.loadMore();
    pending.complete(page(['b'], hasNext: false));
    await Future.wait([first, second]);

    verify(() => repo.getCircles(pageIndex: 2)).called(1);
  });

  test('empty first page requests nothing more', () async {
    when(() => repo.getCircles(pageIndex: 1))
        .thenAnswer((_) async => const LearningCirclePage(circles: [], hasNext: false));
    final c = makeContainer();
    await c.read(circlesListControllerProvider.future);

    await c.read(circlesListControllerProvider.notifier).loadMore();

    expect(ids(c), isEmpty);
    verifyNever(() => repo.getCircles(pageIndex: 2));
  });
}
