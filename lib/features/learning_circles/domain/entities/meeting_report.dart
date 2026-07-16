import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_report_attendee.dart';

part 'meeting_report.freezed.dart';

/// The organizer's consolidated report for a meeting
/// (`learningcircle/meeting/report/{id}/`).
@freezed
abstract class MeetingReport with _$MeetingReport {
  const factory MeetingReport({
    required bool isReportSubmitted,
    required List<MeetingReportAttendee> attendees,
    String? report,
  }) = _MeetingReport;
}
