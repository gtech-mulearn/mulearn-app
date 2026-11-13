import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_profile_completion.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_scope.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

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
}
