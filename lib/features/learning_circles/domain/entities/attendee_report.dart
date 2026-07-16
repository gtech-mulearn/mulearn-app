import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendee_report.freezed.dart';

/// The current user's own attendee report for a meeting
/// (`learningcircle/meeting/attendee-report/{id}/`).
@freezed
abstract class AttendeeReport with _$AttendeeReport {
  const factory AttendeeReport({
    String? report,
    String? reportLink,
  }) = _AttendeeReport;
}
