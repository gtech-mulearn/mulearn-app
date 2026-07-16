import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting.dart';

part 'meeting_dto.freezed.dart';
part 'meeting_dto.g.dart';

@freezed
abstract class MeetingDto with _$MeetingDto {
  const factory MeetingDto({
    required String id,
    required String title,
    required String description,
    required String mode,
    required String meetPlace,
    required String meetTime,
    required String circleId,
    required String igName,
    required String createdBy,
    @Default(false) bool isStarted,
    @Default(false) bool isEnded,
    @Default(0) int attendeesCount,
    String? org,
    String? meetLink,
    @Default(false) bool isRecurring,
    @Default(false) bool isJoined,
    @Default(false) bool isRsvp,
  }) = _MeetingDto;

  const MeetingDto._();

  factory MeetingDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingDtoFromJson(json);

  Meeting toDomain() => Meeting(
        id: id,
        title: title,
        description: description,
        mode: mode,
        meetPlace: meetPlace,
        meetTime: meetTime,
        circleId: circleId,
        igName: igName,
        isStarted: isStarted,
        isEnded: isEnded,
        attendeesCount: attendeesCount,
        createdBy: createdBy,
        org: org,
        meetLink: meetLink,
        isRecurring: isRecurring,
        isJoined: isJoined,
        isRsvp: isRsvp,
      );
}
