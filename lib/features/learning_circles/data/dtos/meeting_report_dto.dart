import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/data/dtos/meeting_report_attendee_dto.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report.dart';

part 'meeting_report_dto.freezed.dart';
part 'meeting_report_dto.g.dart';

@freezed
abstract class MeetingReportDto with _$MeetingReportDto {
  const factory MeetingReportDto({
    @Default(false) bool isReportSubmitted,
    @Default([]) List<MeetingReportAttendeeDto> attendees,
    String? report,
  }) = _MeetingReportDto;

  const MeetingReportDto._();

  factory MeetingReportDto.fromJson(Map<String, dynamic> json) =>
      _$MeetingReportDtoFromJson(json);

  MeetingReport toDomain() => MeetingReport(
        isReportSubmitted: isReportSubmitted,
        attendees: attendees.map((a) => a.toDomain()).toList(),
        report: report,
      );
}
