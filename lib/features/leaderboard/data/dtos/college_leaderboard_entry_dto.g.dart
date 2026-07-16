// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_leaderboard_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollegeLeaderboardEntryDto _$CollegeLeaderboardEntryDtoFromJson(
  Map<String, dynamic> json,
) => _CollegeLeaderboardEntryDto(
  code: json['code'] as String,
  title: json['title'] as String,
  totalStudents: (json['total_students'] as num).toInt(),
  totalKarma: json['total_karma'] as num,
);

Map<String, dynamic> _$CollegeLeaderboardEntryDtoToJson(
  _CollegeLeaderboardEntryDto instance,
) => <String, dynamic>{
  'code': instance.code,
  'title': instance.title,
  'total_students': instance.totalStudents,
  'total_karma': instance.totalKarma,
};
