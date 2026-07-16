// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_leaderboard_entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudentLeaderboardEntryDto _$StudentLeaderboardEntryDtoFromJson(
  Map<String, dynamic> json,
) => _StudentLeaderboardEntryDto(
  fullName: json['full_name'] as String,
  totalKarma: json['total_karma'] as num,
  institution: json['institution'] as String,
  profilePic: json['profile_pic'] as String?,
);

Map<String, dynamic> _$StudentLeaderboardEntryDtoToJson(
  _StudentLeaderboardEntryDto instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'total_karma': instance.totalKarma,
  'institution': instance.institution,
  'profile_pic': instance.profilePic,
};
