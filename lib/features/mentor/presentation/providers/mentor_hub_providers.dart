import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/mentor/data/mentor_repository_provider.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentor_hub_providers.g.dart';

/// The mentor's scopes with their numbers (`overview/`).
@Riverpod(retry: noRetry)
Future<List<MentorScope>> mentorOverview(Ref ref) => ref.watch(mentorRepositoryProvider).getOverview();

@Riverpod(retry: noRetry)
Future<MentorAnalytics> mentorAnalytics(Ref ref) => ref.watch(mentorRepositoryProvider).getAnalytics();

@Riverpod(retry: noRetry)
Future<MentorProfileCompletion> mentorProfileCompletion(Ref ref) =>
    ref.watch(mentorRepositoryProvider).getProfileCompletion();

/// The next scheduled sessions, soonest first (5 at most), without any that
/// already ended.
@Riverpod(retry: noRetry)
Future<List<MentorSession>> mentorNextSessions(Ref ref) async {
  final now = ref.read(clockProvider)();
  final page = await ref
      .watch(mentorRepositoryProvider)
      .getSessions(status: SessionStatus.scheduled, ascending: true, pageIndex: 1, perPage: 5);
  return page.items.where((s) => s.endsAt.isAfter(now)).toList();
}

/// How many student session requests wait for the mentor.
@Riverpod(retry: noRetry)
Future<int> mentorRequestCount(Ref ref) => ref.watch(mentorRepositoryProvider).getStudentRequestCount();
