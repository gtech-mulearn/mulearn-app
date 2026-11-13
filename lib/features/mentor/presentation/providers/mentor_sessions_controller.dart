import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/mentor/data/mentor_repository_provider.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_draft.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/mentor_repository.dart';
import 'package:mulearn_app/features/mentor/domain/session_filter.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_hub_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentor_sessions_controller.g.dart';

/// The mentor's sessions for one [SessionFilter], page by page. A failed
/// "load more" keeps the rows and records the error for an inline retry.
@Riverpod(retry: noRetry)
class MentorSessionsController extends _$MentorSessionsController {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<MentorSession>> build(SessionFilter filter) async {
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref
        .watch(mentorRepositoryProvider)
        .getSessions(status: filter.status, ascending: filter.ascending, pageIndex: 1);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  /// Loads the next page; calls while one is in flight share it.
  Future<void> loadMore() => _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(current.copyWith(isLoadingMore: true, loadMoreError: null));
    final next = _pageIndex + 1;
    try {
      final page = await ref
          .read(mentorRepositoryProvider)
          .getSessions(status: filter.status, ascending: filter.ascending, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(PagedState(items: mergeUniqueBy(current.items, page.items, (s) => s.id), hasMore: page.hasNext));
    } on Object catch (e, st) {
      appLogger.w('Loading more sessions failed', error: e, stackTrace: st);
      if (!ref.mounted) return;
      state = AsyncData(current.copyWith(isLoadingMore: false, loadMoreError: e));
    }
  }
}

/// One of the mentor's sessions (`session/list/<id>/`).
@Riverpod(retry: noRetry)
Future<MentorSession> mentorSession(Ref ref, String id) => ref.watch(mentorRepositoryProvider).getSession(id);

/// The interest groups the mentor can use.
@Riverpod(retry: noRetry)
Future<List<IgOption>> mentorIgs(Ref ref) => ref.watch(mentorRepositoryProvider).getMentorIgs();

/// Where the mentor can create sessions. The interest-group list is fetched
/// only for a global mentor.
@Riverpod(retry: noRetry)
Future<List<SessionTarget>> sessionTargets(Ref ref) async {
  final scopes = await ref.watch(mentorOverviewProvider.future);
  final needsIgs = scopes.any((s) => s.type == MentorScopeType.global);
  final igs = needsIgs ? await ref.watch(mentorIgsProvider.future) : const <IgOption>[];
  return buildSessionTargets(scopes, igs);
}

/// Create, edit and delete. Each refreshes the lists and the hub after it
/// succeeds, even if the screen closed meanwhile (keep-alive). Errors are
/// thrown to the caller, which shows them.
@riverpod
class SessionActions extends _$SessionActions {
  @override
  void build() {}

  /// Returns the new session's id and the backend's message.
  Future<({String id, String message})> create(SessionDraft draft) async {
    var created = (id: '', message: '');
    await _run((r) async {
      created = await r.createSession(draft);
      return created.message;
    });
    return created;
  }

  Future<String> update(String id, SessionDraft draft) => _run((r) => r.updateSession(id, draft), sessionId: id);

  Future<String> delete(String id) => _run((r) => r.deleteSession(id), sessionId: id);

  Future<String> _run(Future<String> Function(MentorRepository repository) action, {String? sessionId}) async {
    final link = ref.keepAlive();
    final repository = ref.read(mentorRepositoryProvider);
    try {
      final message = await action(repository);
      ref
        ..invalidate(mentorSessionsControllerProvider)
        ..invalidate(mentorNextSessionsProvider)
        ..invalidate(mentorOverviewProvider)
        ..invalidate(mentorAnalyticsProvider);
      if (sessionId != null) ref.invalidate(mentorSessionProvider(sessionId));
      return message;
    } finally {
      link.close();
    }
  }
}
