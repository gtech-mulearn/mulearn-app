import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/features/mentor/data/learner_sessions_data.dart';
import 'package:mulearn_app/features/mentor/domain/entities/learner_sessions.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/learner_sessions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'learner_sessions_providers.g.dart';

@riverpod
LearnerSessionsRepository learnerSessionsRepository(Ref ref) =>
    LearnerSessionsRepositoryImpl(LearnerSessionsRemoteDataSource(ref.watch(dioProvider)));

/// Sessions open to join, soonest first.
@Riverpod(retry: noRetry)
Future<List<AvailableSession>> availableSessions(Ref ref) => ref.watch(learnerSessionsRepositoryProvider).available();

/// What the learner joined or asked for, newest first.
@Riverpod(retry: noRetry)
Future<List<SessionRecord>> mySessionHistory(Ref ref) => ref.watch(learnerSessionsRepositoryProvider).history();

/// The learner's requests to mentors.
@Riverpod(retry: noRetry)
Future<List<MySessionRequest>> mySessionRequests(Ref ref) => ref.watch(learnerSessionsRepositoryProvider).myRequests();

/// The ids of sessions the learner already joined (from their history).
@Riverpod(retry: noRetry)
Future<Set<String>> joinedSessionIds(Ref ref) async => {
  for (final r in await ref.watch(mySessionHistoryProvider.future)) r.session.id,
};

/// The learner's Interest Groups: where they can ask for a session.
@Riverpod(retry: noRetry)
Future<List<IgChoice>> myIgChoices(Ref ref) async {
  final groups = (await ref.watch(myProfilePayloadProvider.future))['interest_groups'];
  return [
    if (groups is List)
      for (final g in groups.whereType<Map<String, dynamic>>())
        if (g['id'] is String && g['name'] is String) (id: g['id'] as String, name: g['name'] as String),
  ];
}

/// Join, request and feedback: one notifier for one busy / error state.
/// Each success refreshes the lists it changes. Returns the backend's
/// message on success, null on failure (the error is in [state]).
@riverpod
class LearnerSessionActions extends _$LearnerSessionActions {
  @override
  Future<void> build() async {}

  Future<String?> _run(Future<String> Function(LearnerSessionsRepository repo) action) async {
    final repo = ref.read(learnerSessionsRepositoryProvider);
    final link = ref.keepAlive(); // finish the refresh even if the sheet closes
    state = const AsyncLoading();
    try {
      String? message;
      final result = await AsyncValue.guard(() async => message = await action(repo));
      ref
        ..invalidate(availableSessionsProvider)
        ..invalidate(mySessionHistoryProvider)
        ..invalidate(mySessionRequestsProvider);
      if (ref.mounted) state = result;
      return result.hasError ? null : message;
    } finally {
      link.close();
    }
  }

  Future<String?> join(String sessionId) => _run((repo) => repo.join(sessionId));
  Future<String?> request(SessionRequestDraft draft) => _run((repo) => repo.request(draft));
  Future<String?> feedback(String sessionId, {int? rating, String? text}) =>
      _run((repo) => repo.feedback(sessionId, rating: rating, text: text));
}
