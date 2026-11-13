import 'package:mulearn_app/core/utils/no_retry.dart';
import 'package:mulearn_app/features/mentor/data/mentor_repository_provider.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_hub_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_sessions_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_detail_providers.g.dart';

/// A session's participants (first 50; sessions are small). Attendance
/// changes show at once and roll back if the backend refuses them.
@Riverpod(retry: noRetry)
class SessionParticipantsController extends _$SessionParticipantsController {
  @override
  Future<({List<SessionParticipant> items, int count})> build(String sessionId) async {
    final page = await ref.watch(mentorRepositoryProvider).getParticipants(sessionId, pageIndex: 1);
    return (items: page.items, count: page.count);
  }

  /// Saves attendance for one participant; throws the backend's error after
  /// restoring the previous row.
  Future<String> setAttendance(
    String linkId, {
    required AttendanceStatus attendance,
    int? contributedMinutes,
    String? progressNote,
  }) async {
    final repository = ref.read(mentorRepositoryProvider);
    final before = state.value;
    if (before != null) {
      SessionParticipant updated(SessionParticipant p) => p.linkId != linkId
          ? p
          : p.copyWith(
              attendance: attendance,
              contributedMinutes: contributedMinutes ?? p.contributedMinutes,
              progressNote: progressNote ?? p.progressNote,
            );
      state = AsyncData((items: before.items.map(updated).toList(), count: before.count));
    }
    try {
      return await repository.updateParticipant(
        linkId,
        attendance: attendance,
        contributedMinutes: contributedMinutes,
        progressNote: progressNote,
      );
    } on Object {
      if (ref.mounted && before != null) state = AsyncData(before);
      rethrow;
    }
  }

  /// Adds a learner by muID, then reloads the list.
  Future<String> add(String muid) async {
    final repository = ref.read(mentorRepositoryProvider);
    final message = await repository.addParticipant(sessionId, muid: muid);
    if (ref.mounted) ref.invalidateSelf();
    return message;
  }
}

/// Marks a scheduled session completed. Success or failure, the session is
/// refetched so the screen shows the backend's current status.
@riverpod
class SessionCompletion extends _$SessionCompletion {
  @override
  void build() {}

  Future<String> complete(String sessionId) async {
    final link = ref.keepAlive();
    final repository = ref.read(mentorRepositoryProvider);
    try {
      final message = await repository.completeSession(sessionId);
      ref
        ..invalidate(mentorSessionsControllerProvider)
        ..invalidate(mentorNextSessionsProvider)
        ..invalidate(mentorOverviewProvider)
        ..invalidate(mentorAnalyticsProvider)
        ..invalidate(sessionParticipantsControllerProvider(sessionId));
      return message;
    } finally {
      ref.invalidate(mentorSessionProvider(sessionId));
      link.close();
    }
  }
}
