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
  }) = _MentorApplication;
}
