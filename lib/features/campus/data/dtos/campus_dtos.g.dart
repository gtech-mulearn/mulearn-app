// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CampusCircleDto _$CampusCircleDtoFromJson(Map<String, dynamic> json) =>
    _CampusCircleDto(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      igName: json['ig_name'] as String?,
      memberCount: (json['member_count'] as num?)?.toInt() ?? 0,
      meetingCount: (json['meeting_count'] as num?)?.toInt() ?? 0,
      lastMeetingTime: json['last_meeting_time'] as String?,
    );

Map<String, dynamic> _$CampusCircleDtoToJson(_CampusCircleDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ig_name': instance.igName,
      'member_count': instance.memberCount,
      'meeting_count': instance.meetingCount,
      'last_meeting_time': instance.lastMeetingTime,
    };

_CampusIgDto _$CampusIgDtoFromJson(Map<String, dynamic> json) => _CampusIgDto(
  id: json['id'] as String,
  name: json['name'] as String? ?? '',
  code: json['code'] as String? ?? '',
  campusMemberCount: (json['campus_member_count'] as num?)?.toInt() ?? 0,
  iconImage: json['icon_image'] as String?,
);

Map<String, dynamic> _$CampusIgDtoToJson(_CampusIgDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'campus_member_count': instance.campusMemberCount,
      'icon_image': instance.iconImage,
    };

_StudentActivityDto _$StudentActivityDtoFromJson(Map<String, dynamic> json) =>
    _StudentActivityDto(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      taskName: json['task_name'] as String? ?? '',
      igName: json['ig_name'] as String?,
      karma: (json['karma'] as num?)?.toInt() ?? 0,
      status: json['status'] as String? ?? 'Pending',
    );

Map<String, dynamic> _$StudentActivityDtoToJson(_StudentActivityDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'task_name': instance.taskName,
      'ig_name': instance.igName,
      'karma': instance.karma,
      'status': instance.status,
    };

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
