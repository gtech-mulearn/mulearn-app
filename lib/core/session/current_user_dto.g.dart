// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurrentUserDto _$CurrentUserDtoFromJson(Map<String, dynamic> json) =>
    _CurrentUserDto(
      muid: json['muid'] as String,
      fullName: json['full_name'] as String,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      existInGuild: json['exist_in_guild'] as bool? ?? false,
      profilePic: json['profile_pic'] as String?,
      company: json['company'] as String?,
    );

Map<String, dynamic> _$CurrentUserDtoToJson(_CurrentUserDto instance) =>
    <String, dynamic>{
      'muid': instance.muid,
      'full_name': instance.fullName,
      'roles': instance.roles,
      'exist_in_guild': instance.existInGuild,
      'profile_pic': instance.profilePic,
      'company': instance.company,
    };
