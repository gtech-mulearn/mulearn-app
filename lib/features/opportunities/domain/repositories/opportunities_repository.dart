import 'package:mulearn_app/features/opportunities/domain/entities/job.dart';

/// Jobs from verified companies and the learner's applications to them
/// (api/dashboard/company/job_views.py). Throws [ApiException] on failure.
abstract interface class OpportunitiesRepository {
  /// `GET company/jobs/all/`: active jobs, with eligibility for the viewer.
  Future<OpportunityPage<Job>> jobs({required int pageIndex, String search = ''});

  /// `GET company/applications/me/`.
  Future<OpportunityPage<JobApplication>> myApplications({required int pageIndex});

  /// `POST company/jobs/{id}/apply/` with a resume link (required) and an
  /// optional cover letter.
  Future<void> apply(String jobId, {required String resumeLink, String? coverLetter});

  /// `PATCH company/applications/{id}/resubmit/` (rejected or withdrawn only).
  Future<void> resubmit(String applicationId, {required String resumeLink, String? coverLetter});

  /// `DELETE company/applications/{id}/withdraw/` (soft: status Withdrawn).
  Future<void> withdraw(String applicationId);
}
