// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_members_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CircleMembersDto _$CircleMembersDtoFromJson(Map<String, dynamic> json) =>
    _CircleMembersDto(
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => CircleMemberDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      owner: json['owner'] == null
          ? null
          : CircleUserRefDto.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CircleMembersDtoToJson(_CircleMembersDto instance) =>
    <String, dynamic>{'members': instance.members, 'owner': instance.owner};
