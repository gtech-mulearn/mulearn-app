import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_application.freezed.dart';

/// One of the user's mentor applications (`GET /dashboard/mentor/status/`).
/// [status] is the backend's upper-case value: `PENDING`, `APPROVED`,
/// `REJECTED` or `GRANT_REVOKED`.
@freezed
abstract class MentorApplication with _$MentorApplication {
  const factory MentorApplication({
    required String id,
    required String status,
    required String mentorTier,

    /// The company or college it's for (a name); null for most IG Mentor
    /// applications.
    String? organization,

    /// The reviewer's note, sent only for a rejected application.
    String? rejectionReason,
    DateTime? createdAt,
  }) = _MentorApplication;

  const MentorApplication._();

  bool get isPending => status == MentorStatus.pending;
  bool get isApproved => status == MentorStatus.approved;
  bool get isRejected => status == MentorStatus.rejected;
  bool get isRevoked => status == MentorStatus.revoked;
}

/// The backend's application statuses.
abstract final class MentorStatus {
  static const pending = 'PENDING';
  static const approved = 'APPROVED';
  static const rejected = 'REJECTED';
  static const revoked = 'GRANT_REVOKED';
}

/// The three tiers a mentor can apply for (`MentorApplication.MentorTier`),
/// with what each needs and who decides on it (`MentorVerifyAPI`).
enum MentorTier {
  ig('IG_MENTOR', 'IG Mentor', 'An IG lead or the μLearn team reviews it.'),
  campus('CAMPUS_MENTOR', 'Campus Mentor', 'The μLearn team reviews it.'),
  company(
    'COMPANY_MENTOR',
    'Company Mentor',
    'Your company reviews it, or the μLearn team if it has no admin yet.',
  );

  const MentorTier(this.value, this.label, this.reviewer);

  /// The backend value.
  final String value;
  final String label;

  /// Who approves it, said plainly.
  final String reviewer;

  /// Campus and Company mentors apply for one organisation.
  bool get needsOrganization => this != MentorTier.ig;

  static MentorTier? parse(String? value) {
    for (final t in values) {
      if (t.value == value) return t;
    }
    return null;
  }
}

/// Where a mentor stands, across all their applications: what the home
/// tile says.
enum MentorStanding {
  /// Never applied.
  none,

  /// At least one waiting for review (and none approved).
  pending,

  /// The newest was turned down and nothing is waiting.
  rejected,

  /// Access was revoked and nothing else is active.
  revoked,

  /// At least one approved.
  approved;

  static MentorStanding of(List<MentorApplication> applications) {
    if (applications.isEmpty) return none;
    if (applications.any((a) => a.isApproved)) return approved;
    if (applications.any((a) => a.isPending)) return pending;
    final newest = [...applications]
      ..sort(
        (a, b) =>
            (b.createdAt ?? DateTime(0)).compareTo(a.createdAt ?? DateTime(0)),
      );
    return newest.first.isRevoked ? revoked : rejected;
  }
}
