import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/meeting_attendee.dart';

part 'meeting_detail.freezed.dart';

/// Full detail for one meeting (`learningcircle/meeting/info/{id}/`) —
/// pure-Dart domain entity (rules.md §2). `meetCode` is only ever non-null
/// for the meeting's creator (confirmed live).
@freezed
abstract class MeetingDetail with _$MeetingDetail {
  const factory MeetingDetail({
    required String id,
    required String title,
    required String description,
    required String mode,
    required String meetPlace,
    required String meetTime,
    required String ig,
    required bool isStarted,
    required bool isEnded,
    required bool isMember,
    required bool isReportNeeded,
    required int duration,
    required String createdById,
    required List<MeetingAttendee> attendees,
    String? meetLink,
    String? reportDescription,
    String? meetCode,
    @Default(false) bool isRecurring,
  }) = _MeetingDetail;
}
