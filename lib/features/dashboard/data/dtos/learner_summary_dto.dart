import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/dashboard/domain/entities/learner_summary.dart';

part 'learner_summary_dto.freezed.dart';
part 'learner_summary_dto.g.dart';

/// `GET /api/v1/dashboard/home/learner/summary/`'s `response`
/// (LearnerDashboardSummaryAPIView, `api/dashboard/home/views.py`).
/// `stats.rank` is not used: it counts wallets with more karma, a different
/// rank from the profile's (Plan 3 Task 5 ruling).
@freezed
abstract class LearnerSummaryDto with _$LearnerSummaryDto {
  const factory LearnerSummaryDto({
    required LearnerStatsDto stats,
    NextMeetingDto? nextMeeting,
  }) = _LearnerSummaryDto;

  const LearnerSummaryDto._();

  factory LearnerSummaryDto.fromJson(Map<String, dynamic> json) => _$LearnerSummaryDtoFromJson(json);

  LearnerSummary toDomain() => LearnerSummary(
        weeklyKarma: stats.weeklyKarma.toInt(),
        totalKarma: stats.totalKarma.toInt(),
        activeCircles: stats.activeCircles.toInt(),
        streakDays: stats.streakDays.toInt(),
        nextMeeting: nextMeeting?.toDomain(),
      );
}

@freezed
abstract class LearnerStatsDto with _$LearnerStatsDto {
  const factory LearnerStatsDto({
    @Default(0) num weeklyKarma,
    @Default(0) num totalKarma,
    @Default(0) num activeCircles,
    @Default(0) num streakDays,
  }) = _LearnerStatsDto;

  factory LearnerStatsDto.fromJson(Map<String, dynamic> json) => _$LearnerStatsDtoFromJson(json);
}

@freezed
abstract class NextMeetingDto with _$NextMeetingDto {
  const factory NextMeetingDto({
    required String id,
    required String circleId,
    required String startsAt,
    @Default('') String circleName,
    @Default('') String title,
    num? durationMinutes,
    String? rsvpStatus,
  }) = _NextMeetingDto;

  const NextMeetingDto._();

  factory NextMeetingDto.fromJson(Map<String, dynamic> json) => _$NextMeetingDtoFromJson(json);

  NextMeeting toDomain() => NextMeeting(
        id: id,
        circleId: circleId,
        circleName: circleName,
        title: title,
        startsAt: DateTime.parse(startsAt).toUtc(),
        durationMinutes: durationMinutes?.toInt(),
        rsvpStatus: rsvpStatus,
      );
}
