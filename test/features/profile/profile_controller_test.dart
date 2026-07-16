import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/profile/domain/entities/user_profile.dart';
import 'package:mulearn_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository repository;

  setUp(() => repository = MockProfileRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [profileRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  const profile = UserProfile(
    id: 'user-1',
    fullName: 'Ada Lovelace',
    muid: 'ada@mulearn',
    karma: 4200,
    isPublic: true,
    joined: '2020-01-01',
    level: 'Level 5',
  );

  test('loads the profile on build', () async {
    when(() => repository.getCurrentUserProfile())
        .thenAnswer((_) async => profile);

    final container = makeContainer();
    final result = await container.read(profileControllerProvider.future);

    expect(result.fullName, 'Ada Lovelace');
    expect(result.karma, 4200);
    verify(() => repository.getCurrentUserProfile()).called(1);
  });

  test('surfaces repository errors as AsyncError', () async {
    when(() => repository.getCurrentUserProfile())
        .thenAnswer((_) async => throw Exception('boom'));

    final container = makeContainer();
    // Keep the provider alive while its build future settles.
    final sub = container.listen(profileControllerProvider, (_, __) {});
    addTearDown(sub.close);

    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(profileControllerProvider);
    expect(state.hasError, isTrue);
    expect(state.error, isA<Exception>());
  });
}
