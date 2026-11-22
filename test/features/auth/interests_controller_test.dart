import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/features/auth/domain/repositories/register_repository.dart';
import 'package:mulearn_app/features/auth/presentation/providers/interests_controller.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  late MockRegisterRepository repository;
  late int userLoads;

  setUp(() {
    repository = MockRegisterRepository();
    userLoads = 0;
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        registerRepositoryProvider.overrideWithValue(repository),
        currentUserProvider.overrideWith((ref) async {
          userLoads++;
          return null;
        }),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test(
    'submitPathwaysOnly saves domains and nothing else (quiz mode)',
    () async {
      when(() => repository.selectDomains(any())).thenAnswer((_) async {});

      final container = makeContainer();
      await container
          .read(interestsControllerProvider.notifier)
          .submitPathwaysOnly(['coder', 'maker']);

      verify(() => repository.selectDomains(['coder', 'maker'])).called(1);
      verifyNever(() => repository.selectEndgoals(any()));
      expect(container.read(interestsControllerProvider).hasError, isFalse);
    },
  );

  test(
    'submitPathwaysAndEndgoals saves both, domains before endgoals',
    () async {
      final calls = <String>[];
      when(() => repository.selectDomains(any())).thenAnswer((_) async {
        calls.add('domains');
      });
      when(() => repository.selectEndgoals(any())).thenAnswer((_) async {
        calls.add('endgoals');
      });

      final container = makeContainer();
      await container
          .read(interestsControllerProvider.notifier)
          .submitPathwaysAndEndgoals(['coder'], ['job', 'r&d']);

      verify(() => repository.selectDomains(['coder'])).called(1);
      verify(() => repository.selectEndgoals(['job', 'r&d'])).called(1);
      expect(calls, ['domains', 'endgoals']);
    },
  );

  test('the user is reloaded after saving, so the router stops sending them '
      'back to the interests step', () async {
    when(() => repository.selectDomains(any())).thenAnswer((_) async {});

    final container = makeContainer();
    await container
        .read(interestsControllerProvider.notifier)
        .submitPathwaysOnly(['coder']);

    expect(userLoads, 1);
  });

  test('surfaces repository errors as AsyncError', () async {
    when(() => repository.selectDomains(any())).thenThrow(Exception('down'));

    final container = makeContainer();
    await expectLater(
      container.read(interestsControllerProvider.notifier).submitPathwaysOnly([
        'coder',
      ]),
      throwsException,
    );

    expect(container.read(interestsControllerProvider).hasError, isTrue);
  });
}
