import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/learning_circles/domain/repositories/learning_circles_repository.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

class MockLearningCirclesRepository extends Mock implements LearningCirclesRepository {}

void main() {
  test("an action finishing after its screen closed doesn't throw", () async {
    final repo = MockLearningCirclesRepository();
    final reply = Completer<void>();
    when(() => repo.respondToInvite('l1', accept: true)).thenAnswer((_) => reply.future);
    final container = ProviderContainer(
      overrides: [learningCirclesRepositoryProvider.overrideWithValue(repo)],
    )..listen(circleActionsControllerProvider, (_, __) {});

    final action =
        container.read(circleActionsControllerProvider.notifier).respondToInvite('l1', accept: true);
    container.dispose(); // the screen that owned the provider is gone
    reply.complete();

    await expectLater(action, completes);
  });
}
