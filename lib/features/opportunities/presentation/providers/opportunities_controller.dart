import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/opportunities/data/datasources/opportunities_remote_datasource.dart';
import 'package:mulearn_app/features/opportunities/data/repositories/opportunities_repository_impl.dart';
import 'package:mulearn_app/features/opportunities/domain/entities/job.dart';
import 'package:mulearn_app/features/opportunities/domain/repositories/opportunities_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'opportunities_controller.g.dart';

@riverpod
OpportunitiesRemoteDataSource opportunitiesRemoteDataSource(Ref ref) =>
    OpportunitiesRemoteDataSource(ref.watch(dioProvider));

/// Presentation depends on the [OpportunitiesRepository] contract.
@riverpod
OpportunitiesRepository opportunitiesRepository(Ref ref) =>
    OpportunitiesRepositoryImpl(ref.watch(opportunitiesRemoteDataSourceProvider));

/// Jobs matching [search], page by page. A failed page keeps the jobs
/// already shown and records the error for an inline retry.
@riverpod
class JobsController extends _$JobsController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<Job>> build(String search) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(opportunitiesRepositoryProvider).jobs(pageIndex: 1, search: search);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  /// Loads the next page (or retries it); concurrent calls share one request.
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref.read(opportunitiesRepositoryProvider).jobs(pageIndex: next, search: search);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(
        PagedState(items: mergeUniqueBy(current.items, page.items, (j) => j.id), hasMore: page.hasNext),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more jobs failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// The learner's applications, newest first (the first page; learners
/// rarely have more than a handful).
@riverpod
Future<List<JobApplication>> myJobApplications(Ref ref) async =>
    (await ref.watch(opportunitiesRepositoryProvider).myApplications(pageIndex: 1)).items;

/// Apply, resubmit and withdraw: one notifier so screens show one busy /
/// error state. Each success refreshes the jobs and applications.
@riverpod
class ApplicationActionsController extends _$ApplicationActionsController {
  @override
  Future<void> build() async {}

  Future<bool> _run(Future<void> Function(OpportunitiesRepository repo) action) async {
    final repo = ref.read(opportunitiesRepositoryProvider);
    final link = ref.keepAlive(); // finish the refresh even if the sheet closes
    state = const AsyncLoading();
    try {
      final result = await AsyncValue.guard(() => action(repo));
      if (!result.hasError) {
        ref
          ..invalidate(myJobApplicationsProvider)
          ..invalidate(jobsControllerProvider);
      }
      if (ref.mounted) state = result;
      return !result.hasError;
    } finally {
      link.close();
    }
  }

  /// Applies, or resubmits the existing application when [applicationId] is
  /// set (a rejected or withdrawn one).
  Future<bool> apply(String jobId, {required String resumeLink, String? coverLetter, String? applicationId}) => _run(
    (repo) => applicationId != null
        ? repo.resubmit(applicationId, resumeLink: resumeLink, coverLetter: coverLetter)
        : repo.apply(jobId, resumeLink: resumeLink, coverLetter: coverLetter),
  );

  Future<bool> withdraw(String applicationId) => _run((repo) => repo.withdraw(applicationId));
}
