import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_report_attendee.freezed.dart';

@freezed
abstract class MeetingReportAttendee with _$MeetingReportAttendee {
  const factory MeetingReportAttendee({
    required String userId,
    required String fullName,
    required String muid,
    required bool isLcApproved,
    String? report,
    String? reportLink,
  }) = _MeetingReportAttendee;
}
