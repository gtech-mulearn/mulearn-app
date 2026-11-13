import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

const payload = <String, dynamic>{'id': 'user-1'};

void main() {
  late MockDashboardRepository repository;

  setUp(() => repository = MockDashboardRepository());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        dashboardRepositoryProvider.overrideWithValue(repository),
        myProfilePayloadProvider.overrideWith((ref) async => payload),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

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

  test('MyProgressSummaryController maps the shared user-profile payload', () async {
    const summary = MyProgressSummary(
      fullName: 'Ada Lovelace',
      muid: 'ada@mulearn',
      karma: 4200,
      level: 'Level 5',
    );
    when(() => repository.summaryFromPayload(payload)).thenReturn(summary);

    final container = makeContainer();
    final result =
        await container.read(myProgressSummaryControllerProvider.future);

    expect(result.karma, 4200);
    verify(() => repository.summaryFromPayload(payload)).called(1);
  });
}
