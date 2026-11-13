import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_session.dart';
import 'package:mulearn_app/features/mentor/domain/entities/session_enums.dart';

part 'mentor_session_dto.freezed.dart';
part 'mentor_session_dto.g.dart';

/// One session from `GET mentor/session/list/` or `session/list/<id>/`
/// (`MentorshipSessionSerializer`).
@freezed
abstract class MentorSessionDto with _$MentorSessionDto {
  const factory MentorSessionDto({
    required String id,
    required String startsAt,
    required String endsAt,
    @Default('') String entityId,
    @Default('') String entityName,
    String? sessionType,
    @Default('') String title,
    String? description,
    String? mode,
    String? status,
    int? maxParticipants,
    String? meetingLink,
    String? venue,
    @Default(false) bool isRecurring,
  }) = _MentorSessionDto;

  const MentorSessionDto._();

  factory MentorSessionDto.fromJson(Map<String, dynamic> json) => _$MentorSessionDtoFromJson(json);

  MentorSession toDomain() => MentorSession(
        id: id,
        entityId: entityId,
        entityName: entityName,
        type: SessionType.fromWire(sessionType),
        title: title,
        description: description ?? '',
        mode: SessionMode.fromWire(mode),
        startsAt: DateTime.parse(startsAt).toUtc(),
        endsAt: DateTime.parse(endsAt).toUtc(),
        status: SessionStatus.fromWire(status),
        isRecurring: isRecurring,
        maxParticipants: maxParticipants,
        meetingLink: (meetingLink ?? '').trim().isEmpty ? null : meetingLink!.trim(),
        venue: (venue ?? '').trim().isEmpty ? null : venue!.trim(),
      );
}
