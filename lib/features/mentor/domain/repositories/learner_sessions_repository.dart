import 'package:mulearn_app/features/mentor/domain/entities/learner_sessions.dart';

/// The learner's side of mentor sessions. Throws `ApiException` on failure.
abstract interface class LearnerSessionsRepository {
  /// Scheduled sessions the learner can join, soonest first.
  Future<List<AvailableSession>> available();

  /// Sessions they joined or asked for, with attendance and feedback.
  Future<List<SessionRecord>> history();

  /// Sessions they asked mentors for.
  Future<List<MySessionRequest>> myRequests();

  /// Joins a scheduled session; returns the backend's message.
  Future<String> join(String sessionId);

  /// Asks for a session; returns the backend's message.
  Future<String> request(SessionRequestDraft draft);

  /// Rates (1–5) and/or comments on an attended session.
  Future<String> feedback(String sessionId, {int? rating, String? text});
}
