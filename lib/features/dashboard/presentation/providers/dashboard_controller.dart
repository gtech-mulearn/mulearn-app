import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mulearn_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/learner_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/my_progress_summary.dart';
import 'package:mulearn_app/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dashboard_controller.g.dart';

@riverpod
DashboardRemoteDataSource dashboardRemoteDataSource(Ref ref) =>
    DashboardRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [DashboardRepository] contract (rules.md
/// §2/§5).
@riverpod
DashboardRepository dashboardRepository(Ref ref) =>
    DashboardRepositoryImpl(ref.watch(dashboardRemoteDataSourceProvider));


/// The learner's week for Home (weekly karma, streak, next meetup). Fetched
/// when Home is shown and on pull-to-refresh; a failure shows its own retry.
@Riverpod(retry: noRetry)
Future<LearnerSummary> learnerSummary(Ref ref) =>
    ref.watch(dashboardRepositoryProvider).getLearnerSummary();

@riverpod
class FeaturedEventsController extends _$FeaturedEventsController {
  @override
  Future<List<FeaturedEvent>> build() =>
      ref.watch(dashboardRepositoryProvider).getFeaturedEvents();

  /// Refetches; on failure the events already shown stay and the error is
  /// rethrown for the pull-to-refresh toast.
  Future<void> refresh() async {
    final repository = ref.read(dashboardRepositoryProvider);
    final events = await repository.getFeaturedEvents();
    if (ref.mounted) state = AsyncData(events);
  }
}

@Riverpod(retry: noRetry)
class MyProgressSummaryController extends _$MyProgressSummaryController {
  @override
  Future<MyProgressSummary> build() async {
    final repository = ref.watch(dashboardRepositoryProvider);
    return repository.summaryFromPayload(await ref.watch(myProfilePayloadProvider.future));
  }

  /// Refetches the shared profile and waits for it; every reader refreshes.
  Future<void> refresh() async => ref.refresh(myProfilePayloadProvider.future);
}
