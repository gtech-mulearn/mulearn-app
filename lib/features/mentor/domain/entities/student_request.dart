import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

part 'student_request.freezed.dart';

/// A learner's request for a session in one of the mentor's scopes
/// (`StudentSessionRequestListSerializer`), proposed time included.
@freezed
abstract class StudentSessionRequest with _$StudentSessionRequest {
  const factory StudentSessionRequest({
    required String id,
    required String title,
    required String description,
    required SessionMode mode,
    required DateTime startsAt,
    required DateTime endsAt,
    required String scopeName,
    required String requesterName,
    required String requesterMuid,
    String? meetingLink,
    String? venue,
  }) = _StudentSessionRequest;
}
