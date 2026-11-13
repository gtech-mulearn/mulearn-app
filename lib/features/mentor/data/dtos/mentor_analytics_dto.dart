import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_analytics.dart';

part 'mentor_analytics_dto.freezed.dart';
part 'mentor_analytics_dto.g.dart';

/// `GET mentor/analytics/personal/` (`MentorPersonalAnalyticsAPI`):
/// `{sessions:{total, completed, upcoming, cancelled}, karma_earned,
/// hours_contributed, rating:{average, count}, …}`.
@freezed
abstract class MentorAnalyticsDto with _$MentorAnalyticsDto {
  const factory MentorAnalyticsDto({
    @Default(<String, dynamic>{}) Map<String, dynamic> sessions,
    @Default(0) num karmaEarned,
    @Default(0) num hoursContributed,
    @Default(<String, dynamic>{}) Map<String, dynamic> rating,
  }) = _MentorAnalyticsDto;

  const MentorAnalyticsDto._();

  factory MentorAnalyticsDto.fromJson(Map<String, dynamic> json) => _$MentorAnalyticsDtoFromJson(json);

  MentorAnalytics toDomain() {
    int n(String key) => (sessions[key] as num?)?.toInt() ?? 0;
    return MentorAnalytics(
      sessionsTotal: n('total'),
      sessionsCompleted: n('completed'),
      sessionsUpcoming: n('upcoming'),
      sessionsCancelled: n('cancelled'),
      karmaEarned: karmaEarned,
      hoursContributed: hoursContributed,
      ratingAverage: (rating['average'] as num?)?.toDouble(),
      ratingCount: (rating['count'] as num?)?.toInt() ?? 0,
    );
  }
}
