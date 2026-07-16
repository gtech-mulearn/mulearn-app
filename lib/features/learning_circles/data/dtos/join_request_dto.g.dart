// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JoinRequestDto _$JoinRequestDtoFromJson(Map<String, dynamic> json) =>
    _JoinRequestDto(
      linkId: json['link_id'] as String,
      userId: json['user_id'] as String,
      fullName: json['full_name'] as String,
      muid: json['muid'] as String,
      profilePic: json['profile_pic'] as String?,
      requestedAt: json['requested_at'] as String?,
    );

Map<String, dynamic> _$JoinRequestDtoToJson(_JoinRequestDto instance) =>
    <String, dynamic>{
      'link_id': instance.linkId,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'muid': instance.muid,
      'profile_pic': instance.profilePic,
      'requested_at': instance.requestedAt,
    };
