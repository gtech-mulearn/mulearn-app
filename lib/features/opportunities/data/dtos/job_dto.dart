import 'package:mulearn_app/features/opportunities/domain/entities/job.dart';

/// Maps `JobListSerializer` / `UserAppliedJobsSerializer` rows to domain
/// entities. Hand-written: several fields arrive loosely typed (a decimal
/// `hourly_rate` as a string, `certificate_provided` as "Yes"/"No",
/// `deliverables` as free JSON).
abstract final class JobDto {
  const JobDto._();

  static String? _str(Object? v) {
    if (v == null) return null;
    final s = '$v'.trim();
    return s.isEmpty ? null : s;
  }

  static DateTime? _date(Object? v) => v is String ? DateTime.tryParse(v) : null;

  static List<String> _deliverables(Object? v) => switch (v) {
    final List<dynamic> list => [
      for (final item in list)
        if (_str(item is Map ? (item['title'] ?? item['name'] ?? item['description']) : item) case final s?) s,
    ],
    final String s when s.trim().isNotEmpty => [s.trim()],
    _ => const [],
  };

  static Job job(Map<String, dynamic> json) {
    final eligibility = json['eligibility'];
    final checks = eligibility is Map<String, dynamic>
        ? [
            for (final r in (eligibility['rules'] as List<dynamic>? ?? const []).whereType<Map<String, dynamic>>())
              JobRuleCheck(
                ruleType: '${r['rule_type'] ?? ''}',
                ruleValue: '${r['rule_value'] ?? ''}',
                met: r['met'] == true,
                message: _str(r['message']),
              ),
          ]
        : const <JobRuleCheck>[];
    return Job(
      id: '${json['id']}',
      title: _str(json['title']) ?? 'Untitled role',
      companyName: _str(json['company_name']),
      companyLogo: _str(json['company_logo']),
      jobType: _str(json['job_type']),
      location: _str(json['location']),
      salaryRange: _str(json['salary_range']),
      stipend: _str(json['stipend']),
      experience: _str(json['experience']),
      description: _str(json['job_description']),
      durationValue: json['duration_value'] is num ? (json['duration_value'] as num).toInt() : null,
      durationUnit: _str(json['duration_unit']),
      hourlyRate: _str(json['hourly_rate']),
      deliverables: _deliverables(json['deliverables']),
      certificateProvided: '${json['certificate_provided'] ?? ''}'.toLowerCase() == 'yes',
      createdAt: _date(json['created_at']),
      expiresAt: _date(json['expires_at']),
      eligible: eligibility is Map<String, dynamic> ? eligibility['eligible'] == true : null,
      checks: checks,
    );
  }

  static JobApplication application(Map<String, dynamic> json) => JobApplication(
    id: '${json['id']}',
    job: job(json['job'] as Map<String, dynamic>),
    status: ApplicationStatus.parse(json['status'] as String?),
    rawStatus: _str(json['status']) ?? 'Pending',
    resumeLink: _str(json['resume_link']),
    coverLetter: _str(json['cover_letter']),
    rejectionReason: _str(json['rejection_reason']),
    appliedAt: _date(json['applied_at']),
  );
}
