// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSearchResultDto _$UserSearchResultDtoFromJson(Map<String, dynamic> json) =>
    _UserSearchResultDto(
      id: json['id'] as String,
      muid: json['muid'] as String,
      fullName: json['full_name'] as String,
      karma: json['karma'] as String?,
      profilePic: json['profile_pic'] as String?,
      interestGroups:
          (json['interest_groups'] as List<dynamic>?)
              ?.map((e) => UserSearchIgDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      organizations:
          (json['organizations'] as List<dynamic>?)
              ?.map((e) => UserSearchOrgDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserSearchResultDtoToJson(
  _UserSearchResultDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'muid': instance.muid,
  'full_name': instance.fullName,
  'karma': instance.karma,
  'profile_pic': instance.profilePic,
  'interest_groups': instance.interestGroups,
  'organizations': instance.organizations,
};
