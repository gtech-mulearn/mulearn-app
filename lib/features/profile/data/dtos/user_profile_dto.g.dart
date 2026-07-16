// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileDto _$UserProfileDtoFromJson(
  Map<String, dynamic> json,
) => _UserProfileDto(
  id: json['id'] as String,
  fullName: json['full_name'] as String,
  muid: json['muid'] as String,
  joined: json['joined'] as String,
  email: json['email'] as String?,
  mobile: json['mobile'] as String?,
  gender: json['gender'] as String?,
  level: json['level'] as String?,
  profilePic: json['profile_pic'] as String?,
  coverPic: json['cover_pic'] as String?,
  collegeCode: json['college_code'] as String?,
  collegeId: json['college_id'] as String?,
  departmentId: json['department_id'] as String?,
  departmentName: json['department_name'] as String?,
  orgDistrictId: json['org_district_id'] as String?,
  isPublic: json['is_public'] as bool?,
  karma: json['karma'] as num?,
  rank: json['rank'] as num?,
  percentile: json['percentile'] as num?,
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  roleVerification:
      (json['role_verification'] as List<dynamic>?)
          ?.map((e) => RoleVerificationDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  isVerified: json['is_verified'] as bool?,
  leadEnablerVerified: json['lead_enabler_verified'] as bool?,
  interestGroups:
      (json['interest_groups'] as List<dynamic>?)
          ?.map((e) => InterestGroupDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  karmaDistribution:
      (json['karma_distribution'] as List<dynamic>?)
          ?.map(
            (e) =>
                KarmaDistributionEntryDto.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserProfileDtoToJson(_UserProfileDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'muid': instance.muid,
      'joined': instance.joined,
      'email': instance.email,
      'mobile': instance.mobile,
      'gender': instance.gender,
      'level': instance.level,
      'profile_pic': instance.profilePic,
      'cover_pic': instance.coverPic,
      'college_code': instance.collegeCode,
      'college_id': instance.collegeId,
      'department_id': instance.departmentId,
      'department_name': instance.departmentName,
      'org_district_id': instance.orgDistrictId,
      'is_public': instance.isPublic,
      'karma': instance.karma,
      'rank': instance.rank,
      'percentile': instance.percentile,
      'roles': instance.roles,
      'role_verification': instance.roleVerification,
      'is_verified': instance.isVerified,
      'lead_enabler_verified': instance.leadEnablerVerified,
      'interest_groups': instance.interestGroups,
      'karma_distribution': instance.karmaDistribution,
    };
