import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/domain/repositories/team_repository.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcements_controller.g.dart';

/// The loaded announcements and the backend's total (`count`), which can be
/// more than what has loaded.
typedef AnnouncementsState = ({PagedState<Announcement> page, int total});

/// Announcements, page by page. Loads on open, on pull-to-refresh and on
/// scroll-to-end; nothing polls. Every change (send, edit, delete) is
/// followed by a refresh of the first page so the list shows the result.
@Riverpod(retry: noRetry)
class AnnouncementsController extends _$AnnouncementsController {
  int _page = 1;
  Future<void>? _inFlight;

  @override
  Future<AnnouncementsState> build() async {
    _page = 1;
    _inFlight = null;
    final page = await ref.watch(teamRepositoryProvider).announcements(1);
    return _fromPage(page);
  }

  AnnouncementsState _fromPage(AnnouncementPage page) => (
    page: PagedState(items: page.items, hasMore: page.hasNext),
    total: page.total,
  );

  /// Refetches page 1. On failure the loaded items stay and the error is
  /// rethrown (pull-to-refresh shows it as a toast).
  Future<void> refresh() async {
    final page = await ref.read(teamRepositoryProvider).announcements(1);
    if (!ref.mounted) return;
    _page = 1;
    state = AsyncData(_fromPage(page));
  }

  /// Loads the next page, or retries it after a failure. Calls made while a
  /// page is in flight share that request.
  Future<void> loadMore() =>
      _inFlight ??= _loadNextPage().whenComplete(() => _inFlight = null);

  Future<void> _loadNextPage() async {
    final current = state.value;
    if (current == null || !current.page.hasMore) return;
    state = AsyncData((
      page: current.page.copyWith(isLoadingMore: true, loadMoreError: null),
      total: current.total,
    ));
    final next = _page + 1;
    try {
      final page = await ref.read(teamRepositoryProvider).announcements(next);
      if (!ref.mounted) return;
      _page = next;
      state = AsyncData((
        page: PagedState(
          items: mergeUniqueBy(current.page.items, page.items, (a) => a.id),
          hasMore: page.hasNext,
        ),
        total: page.total,
      ));
    } on Object catch (e, st) {
      appLogger.w(
        'Loading more announcements failed',
        error: e,
        stackTrace: st,
      );
      if (!ref.mounted) return;
      state = AsyncData((
        page: current.page.copyWith(isLoadingMore: false, loadMoreError: e),
        total: current.total,
      ));
    }
  }

  /// Sends a new announcement to everyone. Rethrows the backend's error.
  Future<void> send({
    required String title,
    required String description,
    String? redirectUrl,
    int? expiresInDays,
  }) => _mutate(
    (repository) => repository.sendToEveryone(
      title: title,
      description: description,
      redirectUrl: redirectUrl,
      expiresInDays: expiresInDays,
    ),
  );

  /// Sends only the fields that are not null (the screen passes what changed).
  /// Named `edit` because a Notifier already has an `update`.
  Future<void> edit(
    String id, {
    String? title,
    String? description,
    String? url,
    DateTime? expiresAt,
  }) => _mutate(
    (repository) => repository.updateAnnouncement(
      id,
      title: title,
      description: description,
      url: url,
      expiresAt: expiresAt,
    ),
  );

  Future<void> delete(String id) =>
      _mutate((repository) => repository.deleteAnnouncement(id));

  /// Deletes every announcement, including the ones the system created.
  Future<void> deleteAll() =>
      _mutate((repository) => repository.deleteAllAnnouncements());

  /// Runs a write, then refreshes. Holds the provider open so closing the
  /// screen mid-request cannot drop the refresh. A failed refresh after a
  /// write that went through is logged, not reported as a failed write.
  Future<void> _mutate(
    Future<Object?> Function(TeamRepository repository) write,
  ) async {
    final link = ref.keepAlive();
    try {
      await write(ref.read(teamRepositoryProvider));
      try {
        await refresh();
      } on Object catch (e, st) {
        appLogger.w(
          'Refreshing announcements after a change failed',
          error: e,
          stackTrace: st,
        );
      }
    } finally {
      link.close();
    }
  }
}
