// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_member_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CircleMemberDto _$CircleMemberDtoFromJson(Map<String, dynamic> json) =>
    _CircleMemberDto(
      id: json['id'] as String,
      muid: json['muid'] as String,
      fullName: json['full_name'] as String?,
      profilePic: json['profile_pic'] as String?,
      igKarma: (json['ig_karma'] as num?)?.toInt(),
      isLeader: json['is_leader'] as bool? ?? false,
    );

Map<String, dynamic> _$CircleMemberDtoToJson(_CircleMemberDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'muid': instance.muid,
      'full_name': instance.fullName,
      'profile_pic': instance.profilePic,
      'ig_karma': instance.igKarma,
      'is_leader': instance.isLeader,
    };
