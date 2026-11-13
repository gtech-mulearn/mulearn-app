import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';

part 'mentor_application_dto.freezed.dart';
part 'mentor_application_dto.g.dart';

/// One item of `GET /api/v1/dashboard/mentor/status/` (`MentorStatusAPI`):
/// `{id, status, mentor_tier, organization, verified_by, verified_at,
/// created_at}` — confirmed live on dev 2026-11-12.
@freezed
abstract class MentorApplicationDto with _$MentorApplicationDto {
  const factory MentorApplicationDto({
    required String id,
    required String status,
    required String mentorTier,
  }) = _MentorApplicationDto;

  const MentorApplicationDto._();

  factory MentorApplicationDto.fromJson(Map<String, dynamic> json) =>
      _$MentorApplicationDtoFromJson(json);

  MentorApplication toDomain() =>
      MentorApplication(id: id, status: status, mentorTier: mentorTier);
}
