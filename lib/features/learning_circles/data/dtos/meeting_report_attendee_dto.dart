import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report_attendee.dart';

part 'meeting_report_attendee_dto.freezed.dart';
part 'meeting_report_attendee_dto.g.dart';

@freezed
abstract class MeetingReportAttendeeDto with _$MeetingReportAttendeeDto {
  const factory MeetingReportAttendeeDto({
    required String userId,
    required String fullName,
    required String muid,
    @Default(false) bool isLcApproved,
    String? report,
    String? reportLink,
  }) = _MeetingReportAttendeeDto;

  const MeetingReportAttendeeDto._();

  factory MeetingReportAttendeeDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingReportAttendeeDtoFromJson(json);

  MeetingReportAttendee toDomain() => MeetingReportAttendee(
        userId: userId,
        fullName: fullName,
        muid: muid,
        isLcApproved: isLcApproved,
        report: report,
        reportLink: reportLink,
      );
}
