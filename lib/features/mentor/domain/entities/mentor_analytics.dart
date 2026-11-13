import 'package:freezed_annotation/freezed_annotation.dart';

part 'mentor_analytics.freezed.dart';

/// `GET mentor/analytics/personal/`: the mentor's totals.
@freezed
abstract class MentorAnalytics with _$MentorAnalytics {
  const factory MentorAnalytics({
    required int sessionsTotal,
    required int sessionsCompleted,
    required int sessionsUpcoming,
    required int sessionsCancelled,
    required num karmaEarned,
    required num hoursContributed,
    required int ratingCount,
    double? ratingAverage,
  }) = _MentorAnalytics;
}
