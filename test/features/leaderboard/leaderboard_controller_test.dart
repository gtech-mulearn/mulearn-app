import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/college_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/entities/student_leaderboard_entry.dart';
import 'package:mulearn_app/features/leaderboard/domain/repositories/leaderboard_repository.dart';
import 'package:mulearn_app/features/leaderboard/presentation/providers/leaderboard_controller.dart';

class MockLeaderboardRepository extends Mock implements LeaderboardRepository {}

void main() {
  late MockLeaderboardRepository repository;

  setUp(() => repository = MockLeaderboardRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [leaderboardRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('studentLeaderboard passes the monthly flag through and returns entries',
      () async {
    const entries = [
      StudentLeaderboardEntry(
        fullName: 'Ada Lovelace',
        totalKarma: 4200,
        institution: 'Analytical Engine U',
      ),
    ];
    when(() => repository.getStudentLeaderboard(monthly: true))
        .thenAnswer((_) async => entries);

    final container = makeContainer();
    final result = await container
        .read(studentLeaderboardProvider(monthly: true).future);

    expect(result, entries);
    verify(() => repository.getStudentLeaderboard(monthly: true)).called(1);
    verifyNever(() => repository.getStudentLeaderboard(monthly: false));
  });

  test('collegeLeaderboard passes the monthly flag through and returns entries',
      () async {
    const entries = [
      CollegeLeaderboardEntry(
        code: 'AEU',
        title: 'Analytical Engine U',
        totalStudents: 12,
        totalKarma: 9000,
      ),
    ];
    when(() => repository.getCollegeLeaderboard(monthly: false))
        .thenAnswer((_) async => entries);

    final container = makeContainer();
    final result = await container
        .read(collegeLeaderboardProvider(monthly: false).future);

    expect(result, entries);
    verify(() => repository.getCollegeLeaderboard(monthly: false)).called(1);
  });

  test('surfaces repository errors as AsyncError', () async {
    when(() => repository.getStudentLeaderboard(monthly: false))
        .thenAnswer((_) async => throw Exception('boom'));

    final container = makeContainer();
    final sub = container.listen(
      studentLeaderboardProvider(monthly: false),
      (_, __) {},
    );
    addTearDown(sub.close);

    await Future<void>.delayed(const Duration(milliseconds: 50));

    final state = container.read(studentLeaderboardProvider(monthly: false));
    expect(state.hasError, isTrue);
  });
}
