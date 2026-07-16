import 'package:freezed_annotation/freezed_annotation.dart';

part 'meeting_attendee.freezed.dart';

@freezed
abstract class MeetingAttendee with _$MeetingAttendee {
  const factory MeetingAttendee({
    required String userId,
    required String fullName,
    required bool isJoined,
    required bool isReportSubmitted,
    String? profilePicUrl,
    bool? isSameOrg,
  }) = _MeetingAttendee;
}
