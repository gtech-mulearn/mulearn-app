// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'circle_invite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CircleInviteDto _$CircleInviteDtoFromJson(Map<String, dynamic> json) =>
    _CircleInviteDto(
      linkId: json['link_id'] as String,
      fullName: json['full_name'] as String,
      muid: json['muid'] as String,
      status: json['status'] as String? ?? 'pending',
      userId: json['user_id'] as String?,
      profilePic: json['profile_pic'] as String?,
      invitedAt: json['invited_at'] as String?,
      circleId: json['circle_id'] as String?,
      circleTitle: json['circle_title'] as String?,
      isLeadInvite: json['is_lead_invite'] as bool? ?? false,
    );

Map<String, dynamic> _$CircleInviteDtoToJson(_CircleInviteDto instance) =>
    <String, dynamic>{
      'link_id': instance.linkId,
      'full_name': instance.fullName,
      'muid': instance.muid,
      'status': instance.status,
      'user_id': instance.userId,
      'profile_pic': instance.profilePic,
      'invited_at': instance.invitedAt,
      'circle_id': instance.circleId,
      'circle_title': instance.circleTitle,
      'is_lead_invite': instance.isLeadInvite,
    };
