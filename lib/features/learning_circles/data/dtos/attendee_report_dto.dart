import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/attendee_report.dart';

part 'attendee_report_dto.freezed.dart';
part 'attendee_report_dto.g.dart';

@freezed
abstract class AttendeeReportDto with _$AttendeeReportDto {
  const factory AttendeeReportDto({
    String? report,
    String? reportLink,
  }) = _AttendeeReportDto;

  const AttendeeReportDto._();

  factory AttendeeReportDto.fromJson(Map<String, dynamic> json) =>
      _$AttendeeReportDtoFromJson(json);

  AttendeeReport toDomain() =>
      AttendeeReport(report: report, reportLink: reportLink);
}
