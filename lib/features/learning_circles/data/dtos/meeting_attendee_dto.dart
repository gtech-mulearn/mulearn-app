import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_attendee.dart';

part 'meeting_attendee_dto.freezed.dart';
part 'meeting_attendee_dto.g.dart';

@freezed
abstract class MeetingAttendeeDto with _$MeetingAttendeeDto {
  const factory MeetingAttendeeDto({
    required String userId,
    required String fullName,
    @Default(false) bool isJoined,
    @Default(false) bool isReportSubmitted,
    String? profilePic,
    bool? isSameOrg,
  }) = _MeetingAttendeeDto;

  const MeetingAttendeeDto._();

  factory MeetingAttendeeDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingAttendeeDtoFromJson(json);

  MeetingAttendee toDomain() => MeetingAttendee(
        userId: userId,
        fullName: fullName,
        isJoined: isJoined,
        isReportSubmitted: isReportSubmitted,
        profilePicUrl: profilePic,
        isSameOrg: isSameOrg,
      );
}
