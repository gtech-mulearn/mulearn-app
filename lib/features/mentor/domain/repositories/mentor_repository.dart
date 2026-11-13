import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_draft.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_participant.dart';

/// A page of the mentor's sessions.
typedef SessionPage = ({List<MentorSession> items, bool hasNext, int count});

/// The mentor workspace (`api/dashboard/mentor/`). Throws `ApiException`.
abstract interface class MentorRepository {
  /// `overview/` → the mentor's scopes.
  Future<List<MentorScope>> getOverview();

  Future<MentorAnalytics> getAnalytics();

  Future<MentorProfileCompletion> getProfileCompletion();

  /// `session/list/?status=&sortBy=starts_at|-starts_at`: the caller's own
  /// sessions; [status] is an exact match, null lists every status.
  Future<SessionPage> getSessions({
    required bool ascending,
    required int pageIndex,
    SessionStatus? status,
    int perPage = 20,
  });

  Future<MentorSession> getSession(String id);

  /// How many student requests wait in the mentor's scopes.
  Future<int> getStudentRequestCount();

  /// `session/create/`: the new session's id (the series' first, when it
  /// repeats) and the backend's confirmation message.
  Future<({String id, String message})> createSession(SessionDraft draft);

  /// `session/update/<id>/` (PATCH).
  Future<String> updateSession(String id, SessionDraft draft);

  /// `session/update/<id>/` (DELETE, a soft delete).
  Future<String> deleteSession(String id);

  /// The interest groups the mentor can use (`tasks/ig-dropdown/`).
  Future<List<IgOption>> getMentorIgs();

  /// `session/participant/list/<id>/`, page by page.
  Future<({List<SessionParticipant> items, bool hasNext, int count})> getParticipants(
    String sessionId, {
    required int pageIndex,
  });

  /// `session/participant/update/<link_id>/`: sends only what's given.
  Future<String> updateParticipant(
    String linkId, {
    AttendanceStatus? attendance,
    String? progressNote,
    int? contributedMinutes,
  });

  /// `session/participant/add/<id>/` `{muid}` (scheduled sessions only).
  Future<String> addParticipant(String sessionId, {required String muid});

  /// `session/complete/<id>/` (scheduled sessions only).
  Future<String> completeSession(String id);
}
