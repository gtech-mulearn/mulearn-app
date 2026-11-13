// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampusStudentDto _$CampusStudentDtoFromJson(Map<String, dynamic> json) =>
    _CampusStudentDto(
      fullName: json['full_name'] as String? ?? '',
      muid: json['muid'] as String? ?? '',
      karma: (json['karma'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt(),
      level: json['level'] as String? ?? '',
      joinDate: json['join_date'] as String?,
      lastKarmaGained: json['last_karma_gained'] as String?,
      graduationYear: json['graduation_year'] as String?,
      department: json['department'] as String?,
      isAlumni: json['is_alumni'] as bool? ?? false,
      igCount: (json['ig_count'] as num?)?.toInt() ?? 0,
      lcCount: (json['lc_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CampusStudentDtoToJson(_CampusStudentDto instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'muid': instance.muid,
      'karma': instance.karma,
      'rank': instance.rank,
      'level': instance.level,
      'join_date': instance.joinDate,
      'last_karma_gained': instance.lastKarmaGained,
      'graduation_year': instance.graduationYear,
      'department': instance.department,
      'is_alumni': instance.isAlumni,
      'ig_count': instance.igCount,
      'lc_count': instance.lcCount,
    };
