import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/core/utils/recent_results.dart';
import 'package:mulearn_app/features/campus/data/campus_chapters_data.dart';
import 'package:mulearn_app/features/campus/domain/entities/campus_chapter.dart';
import 'package:mulearn_app/features/campus/domain/repositories/campus_chapters_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'campus_chapters_providers.g.dart';

@riverpod
CampusChaptersRepository campusChaptersRepository(Ref ref) =>
    CampusChaptersRepositoryImpl(
      CampusChaptersRemoteDataSource(ref.watch(dioProvider)),
    );

/// The campus's IG chapters, active first, most members first.
@Riverpod(retry: noRetry)
Future<List<CampusChapter>> campusChapters(Ref ref) =>
    ref.watch(campusChaptersRepositoryProvider).chapters();

/// Campus members matching [query] (two letters or more), to pick a lead.
/// Each query is kept a while, so retyping costs no request.
@Riverpod(retry: noRetry)
Future<List<CampusMember>> campusMemberSearch(Ref ref, String query) async {
  if (query.trim().length < 2) return const [];
  ref.keepRecent();
  return ref
      .watch(campusChaptersRepositoryProvider)
      .searchMembers(query.trim());
}

/// μLearn's interest groups, to start a chapter for.
@Riverpod(retry: noRetry)
Future<List<ChapterIgOption>> chapterIgOptions(Ref ref) =>
    ref.watch(campusChaptersRepositoryProvider).interestGroups();

/// Create, edit and remove: one notifier for one busy / error state. Each
/// success refreshes the chapters. Returns the backend's message, or null on
/// failure (the error is in [state]).
@riverpod
class CampusChapterActions extends _$CampusChapterActions {
  @override
  Future<void> build() async {}

  Future<String?> _run(
    Future<String> Function(CampusChaptersRepository repo) action,
  ) async {
    final repo = ref.read(campusChaptersRepositoryProvider);
    final link = ref.keepAlive(); // finish the refresh even if the sheet closes
    state = const AsyncLoading();
    try {
      String? message;
      final result = await AsyncValue.guard(
        () async => message = await action(repo),
      );
      if (!result.hasError) ref.invalidate(campusChaptersProvider);
      if (ref.mounted) state = result;
      return result.hasError ? null : message;
    } finally {
      link.close();
    }
  }

  Future<String?> create({
    required String igId,
    String? description,
    String? leadMuid,
  }) => _run(
    (repo) =>
        repo.create(igId: igId, description: description, leadMuid: leadMuid),
  );

  Future<String?> edit(
    String id, {
    required String description,
    required bool isActive,
    String? leadMuid,
  }) => _run(
    (repo) => repo.update(
      id,
      description: description,
      isActive: isActive,
      leadMuid: leadMuid,
    ),
  );

  Future<String?> remove(String id) => _run((repo) => repo.remove(id));
}
