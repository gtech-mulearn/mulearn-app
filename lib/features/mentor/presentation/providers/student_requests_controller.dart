import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/mentor/data/mentor_repository_provider.dart';
import 'package:mulearn_app/features/mentor/domain/entities/student_request.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_hub_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'student_requests_controller.g.dart';

/// Learners' requests waiting for the mentor, soonest first.
@Riverpod(retry: noRetry)
class StudentRequestsController extends _$StudentRequestsController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<StudentSessionRequest>> build() async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref.watch(mentorRepositoryProvider).getStudentRequests(pageIndex: 1);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref.read(mentorRepositoryProvider).getStudentRequests(pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(PagedState(items: mergeUniqueBy(current.items, page.items, (r) => r.id), hasMore: page.hasNext));
    } on Object catch (e, st) {
      appLogger.w('Loading more requests failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }

  /// Sends the decision. On success the row goes and the hub and session
  /// lists refresh; if someone already handled it (404) the list reloads.
  /// Errors are rethrown for the screen to show.
  Future<String> answer(StudentSessionRequest request, Map<String, Object?> body) async {
    final link = ref.keepAlive();
    final repository = ref.read(mentorRepositoryProvider);
    try {
      final message = await repository.answerRequest(request.id, body);
      final current = state.value;
      if (ref.mounted && current != null) {
        state = AsyncData(current.copyWith(items: [
          for (final r in current.items)
            if (r.id != request.id) r,
        ]));
      }
      ref
        ..invalidate(mentorRequestCountProvider)
        ..invalidate(mentorSessionsControllerProvider)
        ..invalidate(mentorNextSessionsProvider)
        ..invalidate(mentorOverviewProvider);
      return message;
    } on ApiException catch (e) {
      if (e.statusCode == 404 && ref.mounted) ref.invalidateSelf();
      rethrow;
    } finally {
      link.close();
    }
  }
}
