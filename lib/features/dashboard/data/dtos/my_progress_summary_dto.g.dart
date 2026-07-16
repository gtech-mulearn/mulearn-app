// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_progress_summary_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MyProgressSummaryDto _$MyProgressSummaryDtoFromJson(
  Map<String, dynamic> json,
) => _MyProgressSummaryDto(
  fullName: json['full_name'] as String,
  muid: json['muid'] as String,
  karma: json['karma'] as num?,
  level: json['level'] as String?,
  profilePic: json['profile_pic'] as String?,
  rank: json['rank'] as num?,
  percentile: json['percentile'] as num?,
);

Map<String, dynamic> _$MyProgressSummaryDtoToJson(
  _MyProgressSummaryDto instance,
) => <String, dynamic>{
  'full_name': instance.fullName,
  'muid': instance.muid,
  'karma': instance.karma,
  'level': instance.level,
  'profile_pic': instance.profilePic,
  'rank': instance.rank,
  'percentile': instance.percentile,
};
