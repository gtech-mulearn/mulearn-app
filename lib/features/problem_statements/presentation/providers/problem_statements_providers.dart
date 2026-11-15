import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/core/utils/recent_results.dart';
import 'package:mulearn_app/features/problem_statements/data/problem_statements_data.dart';
import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';
import 'package:mulearn_app/features/problem_statements/domain/repositories/problem_statements_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'problem_statements_providers.g.dart';

@riverpod
ProblemStatementsRepository problemStatementsRepository(Ref ref) =>
    ProblemStatementsRepositoryImpl(ProblemStatementsRemoteDataSource(ref.watch(dioProvider)));

/// The published feed for a search (all when empty), optionally only those
/// still open, page by page. Each search is kept for a while once seen.
@Riverpod(retry: noRetry)
class PsFeed extends _$PsFeed {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<ProblemStatement>> build(String search, bool openOnly) async {
    ref.keepRecent();
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(problemStatementsRepositoryProvider).feed(search: search, openOnly: openOnly);
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
      final page = await ref
          .read(problemStatementsRepositoryProvider)
          .feed(search: search, openOnly: openOnly, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(
        PagedState(items: mergeUniqueBy(current.items, page.items, (s) => s.id), hasMore: page.hasNext),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more problem statements failed', error: e, stackTrace: st);
      if (ref.mounted) state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// What the learner is trying or has submitted to, newest first.
@Riverpod(retry: noRetry)
Future<List<ProblemStatement>> psParticipating(Ref ref) =>
    ref.watch(problemStatementsRepositoryProvider).participating();

/// One statement.
@Riverpod(retry: noRetry)
Future<ProblemStatement> problemStatement(Ref ref, String id) =>
    ref.watch(problemStatementsRepositoryProvider).detail(id);

/// The learner's own interaction with it (status and solution link).
@Riverpod(retry: noRetry)
Future<MyPsParticipation> myPsParticipation(Ref ref, String id) =>
    ref.watch(problemStatementsRepositoryProvider).myParticipation(id);

/// Try, leave, submit and withdraw: one notifier so the screen shows one
/// busy / error state. Each success refreshes the statement, the learner's
/// interaction, the participating list and the feeds (their counts).
@riverpod
class PsActions extends _$PsActions {
  @override
  Future<void> build() async {}

  Future<bool> _run(String id, Future<void> Function(ProblemStatementsRepository repo) action) async {
    final repo = ref.read(problemStatementsRepositoryProvider);
    final link = ref.keepAlive(); // finish the refresh even if the sheet closes
    state = const AsyncLoading();
    try {
      final result = await AsyncValue.guard(() => action(repo));
      // A failure can mean the deadline passed meanwhile: refresh either way.
      ref
        ..invalidate(problemStatementProvider(id))
        ..invalidate(myPsParticipationProvider(id))
        ..invalidate(psParticipatingProvider)
        ..invalidate(psFeedProvider);
      if (ref.mounted) state = result;
      return !result.hasError;
    } finally {
      link.close();
    }
  }

  Future<bool> startTrying(String id) => _run(id, (repo) => repo.startTrying(id));
  Future<bool> leave(String id) => _run(id, (repo) => repo.leave(id));
  Future<bool> submit(String id, String url) => _run(id, (repo) => repo.submit(id, url));
  Future<bool> withdraw(String id) => _run(id, (repo) => repo.withdraw(id));
}
