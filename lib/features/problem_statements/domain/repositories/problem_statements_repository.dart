import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';

/// Problem statements for learners (`api/dashboard/problem_statement/`
/// learner views). Throws `ApiException` on failure.
abstract interface class ProblemStatementsRepository {
  /// A page of the published feed, newest first.
  Future<PsPage> feed({String search, bool openOnly, int pageIndex, int perPage});

  /// Every statement the caller is trying or has submitted to. The backend
  /// has no filter for this, so it reads the whole feed (as the dashboard's
  /// Participating tab does).
  Future<List<ProblemStatement>> participating();

  /// One statement.
  Future<ProblemStatement> detail(String id);

  /// The caller's own interaction.
  Future<MyPsParticipation> myParticipation(String id);

  /// "I'm trying it".
  Future<void> startTrying(String id);

  /// Stop participating (not allowed for a submission after the deadline).
  Future<void> leave(String id);

  /// Submit or replace the solution link (https).
  Future<void> submit(String id, String url);

  /// Take the submission back (back to trying), before the deadline.
  Future<void> withdraw(String id);
}
