// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learner_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LearnerSummaryDto _$LearnerSummaryDtoFromJson(Map<String, dynamic> json) =>
    _LearnerSummaryDto(
      stats: LearnerStatsDto.fromJson(json['stats'] as Map<String, dynamic>),
      nextMeeting: json['next_meeting'] == null
          ? null
          : NextMeetingDto.fromJson(
              json['next_meeting'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$LearnerSummaryDtoToJson(_LearnerSummaryDto instance) =>
    <String, dynamic>{
      'stats': instance.stats,
      'next_meeting': instance.nextMeeting,
    };

_LearnerStatsDto _$LearnerStatsDtoFromJson(Map<String, dynamic> json) =>
    _LearnerStatsDto(
      weeklyKarma: json['weekly_karma'] as num? ?? 0,
      totalKarma: json['total_karma'] as num? ?? 0,
      activeCircles: json['active_circles'] as num? ?? 0,
      streakDays: json['streak_days'] as num? ?? 0,
    );

Map<String, dynamic> _$LearnerStatsDtoToJson(_LearnerStatsDto instance) =>
    <String, dynamic>{
      'weekly_karma': instance.weeklyKarma,
      'total_karma': instance.totalKarma,
      'active_circles': instance.activeCircles,
      'streak_days': instance.streakDays,
    };

_NextMeetingDto _$NextMeetingDtoFromJson(Map<String, dynamic> json) =>
    _NextMeetingDto(
      id: json['id'] as String,
      circleId: json['circle_id'] as String,
      startsAt: json['starts_at'] as String,
      circleName: json['circle_name'] as String? ?? '',
      title: json['title'] as String? ?? '',
      durationMinutes: json['duration_minutes'] as num?,
      rsvpStatus: json['rsvp_status'] as String?,
    );

Map<String, dynamic> _$NextMeetingDtoToJson(_NextMeetingDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'circle_id': instance.circleId,
      'starts_at': instance.startsAt,
      'circle_name': instance.circleName,
      'title': instance.title,
      'duration_minutes': instance.durationMinutes,
      'rsvp_status': instance.rsvpStatus,
    };
