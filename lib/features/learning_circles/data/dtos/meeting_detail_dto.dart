import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/meeting_attendee_dto.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_detail.dart';

part 'meeting_detail_dto.freezed.dart';
part 'meeting_detail_dto.g.dart';

@freezed
abstract class MeetingDetailDto with _$MeetingDetailDto {
  const factory MeetingDetailDto({
    required String id,
    required String title,
    required String description,
    required String mode,
    required String meetPlace,
    required String meetTime,
    required String ig,
    required String createdById,
    @Default(false) bool isStarted,
    @Default(false) bool isEnded,
    @Default(false) bool isMember,
    @Default(false) bool isReportNeeded,
    @Default(0) int duration,
    @Default([]) List<MeetingAttendeeDto> attendees,
    String? meetLink,
    String? reportDescription,
    String? meetCode,
    @Default(false) bool isRecurring,
  }) = _MeetingDetailDto;

  const MeetingDetailDto._();

  factory MeetingDetailDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingDetailDtoFromJson(json);

  MeetingDetail toDomain() => MeetingDetail(
        id: id,
        title: title,
        description: description,
        mode: mode,
        meetPlace: meetPlace,
        meetTime: meetTime,
        ig: ig,
        isStarted: isStarted,
        isEnded: isEnded,
        isMember: isMember,
        isReportNeeded: isReportNeeded,
        duration: duration,
        createdById: createdById,
        attendees: attendees.map((a) => a.toDomain()).toList(),
        meetLink: meetLink,
        reportDescription: reportDescription,
        meetCode: meetCode,
        isRecurring: isRecurring,
      );
}
