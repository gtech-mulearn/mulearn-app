import 'package:mulearn_app/features/mentor/domain/entities/mentor_application_form.dart';

/// Applying to mentor (`api/dashboard/mentor/urls.py` §14). The list of the
/// user's applications is the session's (`mentorApplicationsProvider`).
/// Throws `ApiException` on failure, carrying the backend's message (e.g.
/// "You already have an active or pending IG mentor application.").
abstract interface class MentorApplicationsRepository {
  /// Sends a new application (also how a rejected one is applied for
  /// again). Returns the backend's message.
  Future<String> submit(MentorApplicationDraft draft);

  /// Edits a pending application: everything but its tier and organisation.
  Future<String> update(String applicationId, MentorApplicationDraft draft);

  /// The answers to fill the form with; null when there's no mentor profile
  /// yet (first application).
  Future<MentorProfileSnapshot?> snapshot();

  /// Every Interest Group, to pick the ones to mentor.
  Future<List<MentorChoice>> interestGroups();

  /// Companies a Company Mentor can apply from.
  Future<List<MentorChoice>> companies();

  /// Colleges matching [query], for a Campus Mentor.
  Future<List<MentorChoice>> searchColleges(String query);
}
