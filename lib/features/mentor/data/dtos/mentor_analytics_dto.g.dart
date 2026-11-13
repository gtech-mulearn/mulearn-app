// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_analytics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MentorAnalyticsDto _$MentorAnalyticsDtoFromJson(
  Map<String, dynamic> json,
) => _MentorAnalyticsDto(
  sessions:
      json['sessions'] as Map<String, dynamic>? ?? const <String, dynamic>{},
  karmaEarned: json['karma_earned'] as num? ?? 0,
  hoursContributed: json['hours_contributed'] as num? ?? 0,
  rating: json['rating'] as Map<String, dynamic>? ?? const <String, dynamic>{},
);

Map<String, dynamic> _$MentorAnalyticsDtoToJson(_MentorAnalyticsDto instance) =>
    <String, dynamic>{
      'sessions': instance.sessions,
      'karma_earned': instance.karmaEarned,
      'hours_contributed': instance.hoursContributed,
      'rating': instance.rating,
    };
