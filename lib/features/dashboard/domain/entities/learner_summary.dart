import 'package:freezed_annotation/freezed_annotation.dart';

part 'learner_summary.freezed.dart';

/// The learner's week at a glance (`/dashboard/home/learner/summary/`).
@freezed
abstract class LearnerSummary with _$LearnerSummary {
  const factory LearnerSummary({
    required int weeklyKarma,
    required int totalKarma,
    required int activeCircles,
    required int streakDays,
    NextMeeting? nextMeeting,
  }) = _LearnerSummary;
}

/// The soonest upcoming meeting in one of the user's circles.
@freezed
abstract class NextMeeting with _$NextMeeting {
  const factory NextMeeting({
    required String id,
    required String circleId,
    required String circleName,
    required String title,
    required DateTime startsAt,
    int? durationMinutes,
    String? rsvpStatus,
  }) = _NextMeeting;
}
