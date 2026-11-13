import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';
import 'package:mulearn_app/features/mentor/domain/entities/student_request.dart';

part 'student_request_dto.freezed.dart';
part 'student_request_dto.g.dart';

/// One row of `GET session/student-requests/`.
@freezed
abstract class StudentRequestDto with _$StudentRequestDto {
  const factory StudentRequestDto({
    required String id,
    required String startsAt,
    required String endsAt,
    @Default('') String title,
    String? description,
    String? mode,
    @Default('') String entityName,
    String? meetingLink,
    String? venue,
    @Default('') String requestedByName,
    @Default('') String requestedByMuid,
  }) = _StudentRequestDto;

  const StudentRequestDto._();

  factory StudentRequestDto.fromJson(Map<String, dynamic> json) => _$StudentRequestDtoFromJson(json);

  StudentSessionRequest toDomain() => StudentSessionRequest(
        id: id,
        title: title,
        description: description ?? '',
        mode: SessionMode.fromWire(mode),
        startsAt: DateTime.parse(startsAt).toUtc(),
        endsAt: DateTime.parse(endsAt).toUtc(),
        scopeName: entityName,
        requesterName: requestedByName,
        requesterMuid: requestedByMuid,
        meetingLink: (meetingLink ?? '').trim().isEmpty ? null : meetingLink!.trim(),
        venue: (venue ?? '').trim().isEmpty ? null : venue!.trim(),
      );
}
