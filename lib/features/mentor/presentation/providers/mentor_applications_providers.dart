import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/core/utils/recent_results.dart';
import 'package:mulearn_app/features/mentor/data/mentor_applications_data.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_application_form.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/mentor_applications_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentor_applications_providers.g.dart';

@riverpod
MentorApplicationsRepository mentorApplicationsRepository(Ref ref) =>
    MentorApplicationsRepositoryImpl(
      MentorApplicationsRemoteDataSource(ref.watch(dioProvider)),
    );

/// The answers to fill the form with (null before the first application).
@Riverpod(retry: noRetry)
Future<MentorProfileSnapshot?> mentorProfileSnapshot(Ref ref) =>
    ref.watch(mentorApplicationsRepositoryProvider).snapshot();

/// Every Interest Group, for "which will you mentor?".
@Riverpod(retry: noRetry)
Future<List<MentorChoice>> mentorIgChoices(Ref ref) =>
    ref.watch(mentorApplicationsRepositoryProvider).interestGroups();

/// Companies a Company Mentor can apply from.
@Riverpod(retry: noRetry)
Future<List<MentorChoice>> mentorCompanyChoices(Ref ref) =>
    ref.watch(mentorApplicationsRepositoryProvider).companies();

/// Colleges matching [query] (2+ characters), kept briefly so going back
/// over a search doesn't ask again.
@Riverpod(retry: noRetry)
Future<List<MentorChoice>> mentorCollegeSearch(Ref ref, String query) async {
  if (query.trim().length < 2) return const [];
  ref.keepRecent();
  return ref
      .watch(mentorApplicationsRepositoryProvider)
      .searchColleges(query.trim());
}

/// Sends or edits an application, then refreshes the session's list (which
/// drives the home tile and the applications screen).
@riverpod
class MentorApplicationSender extends _$MentorApplicationSender {
  @override
  FutureOr<void> build() {}

  /// Returns the backend's message; throws `ApiException` on failure.
  Future<String> send(MentorApplicationDraft draft, {String? editingId}) async {
    final link = ref.keepAlive();
    state = const AsyncLoading();
    try {
      final repo = ref.read(mentorApplicationsRepositoryProvider);
      final message = editingId == null
          ? await repo.submit(draft)
          : await repo.update(editingId, draft);
      ref
        ..invalidate(mentorApplicationsProvider)
        ..invalidate(mentorProfileSnapshotProvider);
      if (ref.mounted) state = const AsyncData(null);
      return message;
    } catch (e, st) {
      if (ref.mounted) state = AsyncError(e, st);
      rethrow;
    } finally {
      link.close();
    }
  }
}
