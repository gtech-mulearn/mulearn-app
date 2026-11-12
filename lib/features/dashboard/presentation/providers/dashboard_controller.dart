import 'package:mulearn_app/core/events/profile_event_bus.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:mulearn_app/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/featured_event.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/karma_feed.dart';
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

@riverpod
class KarmaFeedController extends _$KarmaFeedController {
  @override
  Future<KarmaFeed> build() =>
      ref.watch(dashboardRepositoryProvider).getKarmaFeed();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(dashboardRepositoryProvider).getKarmaFeed(),
    );
  }
}

@riverpod
class FeaturedEventsController extends _$FeaturedEventsController {
  @override
  Future<List<FeaturedEvent>> build() =>
      ref.watch(dashboardRepositoryProvider).getFeaturedEvents();

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(dashboardRepositoryProvider).getFeaturedEvents(),
    );
  }
}

@riverpod
class MyProgressSummaryController extends _$MyProgressSummaryController {
  @override
  Future<MyProgressSummary> build() {
    // `features/profile` mutates the same `dashboard/profile/user-profile/`
    // endpoint this reads from but can't invalidate this provider directly
    // (rules.md §2: no direct cross-feature import) — listen for its signal
    // via the shared bus instead, mirroring AppAuthController's use of
    // SessionEventBus.
    final bus = ref.watch(profileEventBusProvider);
    final sub = bus.events.listen((event) {
      if (event == ProfileEvent.updated) refresh();
    });
    ref.onDispose(sub.cancel);

    return ref.watch(dashboardRepositoryProvider).getMyProgressSummary();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(dashboardRepositoryProvider).getMyProgressSummary(),
    );
  }
}
