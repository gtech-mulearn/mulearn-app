import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/recent_results.dart';
import 'package:mulearn_app/features/projects/data/projects_data.dart';
import 'package:mulearn_app/features/projects/domain/entities/project.dart';
import 'package:mulearn_app/features/projects/domain/repositories/projects_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'projects_providers.g.dart';

@riverpod
ProjectsRepository projectsRepository(Ref ref) =>
    ProjectsRepositoryImpl(ProjectsRemoteDataSource(ref.watch(dioProvider)));

/// The signed-in member's id (votes and comments carry it) and muid.
@Riverpod(retry: noRetry)
Future<({String id, String muid})> projectsViewer(Ref ref) async {
  final me = await ref.watch(myProfilePayloadProvider.future);
  return (id: '${me['id'] ?? ''}', muid: '${me['muid'] ?? ''}');
}

/// Published projects for a search (all when empty), a page at a time.
/// Each search is kept for a while once seen.
@Riverpod(retry: noRetry)
class ProjectsFeed extends _$ProjectsFeed {
  int _pageIndex = 1;
  Future<void>? _inFlight;

  @override
  Future<PagedState<Project>> build(String search) async {
    ref.keepRecent();
    _pageIndex = 1;
    _inFlight = null;
    final page = await ref
        .watch(projectsRepositoryProvider)
        .feed(search: search);
    return PagedState(items: page.items, hasMore: page.hasNext);
  }

  /// Loads the next page (or retries it); concurrent calls share one request.
  Future<void> loadMore() =>
      _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.hasMore) return;
    state = AsyncData(
      current.copyWith(isLoadingMore: true, loadMoreError: null),
    );
    final next = _pageIndex + 1;
    try {
      final page = await ref
          .read(projectsRepositoryProvider)
          .feed(search: search, pageIndex: next);
      if (!ref.mounted) return;
      _pageIndex = next;
      state = AsyncData(
        PagedState(
          items: mergeUniqueBy(current.items, page.items, (p) => p.id),
          hasMore: page.hasNext,
        ),
      );
    } on Object catch (e, st) {
      appLogger.w('Loading more projects failed', error: e, stackTrace: st);
      if (ref.mounted) {
        state = AsyncData(
          current.copyWith(isLoadingMore: false, loadMoreError: e),
        );
      }
    }
  }
}

/// What the viewer made or is on, drafts included, newest first.
@Riverpod(retry: noRetry)
Future<List<Project>> myProjects(Ref ref) async {
  final me = await ref.watch(projectsViewerProvider.future);
  final items = await ref.watch(projectsRepositoryProvider).byMember(me.muid);
  return [...items]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
}

/// One project.
@Riverpod(retry: noRetry)
Future<Project> project(Ref ref, String id) =>
    ref.watch(projectsRepositoryProvider).detail(id);

/// μLearn members matching [query], for the team picker; nothing under two
/// characters. Each query is kept a while, so retyping costs no request and
/// a slower, older answer can't replace a newer one.
@Riverpod(retry: noRetry)
Future<List<ProjectMember>> projectPeopleSearch(Ref ref, String query) async {
  if (query.trim().length < 2) return const [];
  ref.keepRecent();
  return ref.watch(projectsRepositoryProvider).findPeople(query.trim());
}

/// Skills to tag a project with.
@Riverpod(retry: noRetry)
Future<List<ProjectSkill>> projectSkills(Ref ref) =>
    ref.watch(projectsRepositoryProvider).skills();

/// Every change to a project: one notifier for one busy / error state. Each
/// success refreshes the project, the viewer's list and the feed. Returns
/// true on success (the error is in [state]).
@riverpod
class ProjectActions extends _$ProjectActions {
  @override
  Future<void> build() async {}

  Future<T?> _run<T>(
    String? projectId,
    Future<T> Function(ProjectsRepository repo) action,
  ) async {
    final repo = ref.read(projectsRepositoryProvider);
    final link = ref
        .keepAlive(); // finish the refresh even if the screen closes
    state = const AsyncLoading();
    try {
      T? value;
      final result = await AsyncValue.guard(
        () async => value = await action(repo),
      );
      if (projectId != null) ref.invalidate(projectProvider(projectId));
      ref
        ..invalidate(myProjectsProvider)
        ..invalidate(projectsFeedProvider);
      if (ref.mounted) state = result;
      return result.hasError ? null : value;
    } finally {
      link.close();
    }
  }

  /// The new project, or null.
  Future<Project?> create(ProjectDraft draft) =>
      _run(null, (repo) => repo.create(draft));
  Future<Project?> edit(String id, ProjectDraft draft) =>
      _run(id, (repo) => repo.update(id, draft));

  Future<bool> delete(String id) async =>
      await _run(id, (repo) async {
        await repo.delete(id);
        return true;
      }) ??
      false;

  Future<bool> _ok(
    String id,
    Future<void> Function(ProjectsRepository repo) action,
  ) async =>
      await _run(id, (repo) async {
        await action(repo);
        return true;
      }) ??
      false;

  Future<bool> setStatus(String id, ProjectStatus status) =>
      _ok(id, (repo) => repo.setStatus(id, status));
  Future<bool> addMember(
    String id, {
    String? muid,
    String? externalName,
    String? role,
  }) => _ok(
    id,
    (repo) =>
        repo.addMember(id, muid: muid, externalName: externalName, role: role),
  );
  Future<bool> removeMember(String id, String memberId) =>
      _ok(id, (repo) => repo.removeMember(id, memberId));

  /// Upvotes, or takes the viewer's upvote back.
  Future<bool> toggleUpvote(Project project, String viewerId) {
    final mine = project.upvoteBy(viewerId);
    return _ok(
      project.id,
      (repo) =>
          mine == null ? repo.upvote(project.id) : repo.removeVote(mine.id),
    );
  }

  Future<bool> comment(String id, String text) =>
      _ok(id, (repo) => repo.comment(id, text));
  Future<bool> deleteComment(String id, String commentId) =>
      _ok(id, (repo) => repo.deleteComment(commentId));
}
