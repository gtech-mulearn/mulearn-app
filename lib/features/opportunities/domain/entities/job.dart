import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';

/// One eligibility rule on a job and whether the viewer meets it
/// (`check_job_eligibility`, company/job_serializers.py:135).
@freezed
abstract class JobRuleCheck with _$JobRuleCheck {
  const factory JobRuleCheck({
    /// `min_karma`, `max_karma`, `min_level`, `max_level`, `skill`.
    required String ruleType,
    required String ruleValue,
    required bool met,

    /// Why it isn't met ("Insufficient Karma. Minimum 500 required.").
    String? message,
  }) = _JobRuleCheck;
}

/// A job, internship or gig a verified company posted (`JobListSerializer`).
@freezed
abstract class Job with _$Job {
  const factory Job({
    required String id,
    required String title,
    String? companyName,
    String? companyLogo,

    /// Hybrid, Full-Time, Remote, Part-Time, Internship, Gig.
    String? jobType,
    String? location,
    String? salaryRange,
    String? stipend,
    String? experience,
    String? description,
    int? durationValue,

    /// days, weeks, months.
    String? durationUnit,
    String? hourlyRate,
    @Default(<String>[]) List<String> deliverables,
    @Default(false) bool certificateProvided,
    DateTime? createdAt,
    DateTime? expiresAt,

    /// Null when the backend didn't check (signed out); otherwise whether
    /// every rule in [checks] is met.
    bool? eligible,
    @Default(<JobRuleCheck>[]) List<JobRuleCheck> checks,
  }) = _Job;
}

/// Where an application stands (`UserJobApplication.status`).
enum ApplicationStatus {
  pending,
  inReview,
  shortlisted,
  interview,
  selected,
  rejected,
  withdrawn,
  unknown;

  static ApplicationStatus parse(String? raw) => switch (raw?.trim().toLowerCase()) {
    'pending' => pending,
    'in-review' || 'in review' || 'in_review' => inReview,
    'shortlisted' => shortlisted,
    'interview' => interview,
    'selected' => selected,
    'rejected' => rejected,
    'withdrawn' => withdrawn,
    _ => unknown,
  };

  /// Resubmit is allowed only from these (UserApplicationResubmitAPI).
  bool get canResubmit => this == rejected || this == withdrawn;

  /// A selected application can't be withdrawn (UserApplicationWithdrawAPI).
  bool get canWithdraw => this != selected && this != withdrawn && this != rejected;
}

/// The signed-in learner's application to a [job].
@freezed
abstract class JobApplication with _$JobApplication {
  const factory JobApplication({
    required String id,
    required Job job,
    required ApplicationStatus status,

    /// The backend's own word, for anything [status] doesn't name.
    required String rawStatus,
    String? resumeLink,
    String? coverLetter,
    String? rejectionReason,
    DateTime? appliedAt,
  }) = _JobApplication;
}

/// A page of [items] and whether another follows.
@freezed
abstract class OpportunityPage<T> with _$OpportunityPage<T> {
  const factory OpportunityPage({required List<T> items, required bool hasNext, required int count}) =
      _OpportunityPage<T>;
}
