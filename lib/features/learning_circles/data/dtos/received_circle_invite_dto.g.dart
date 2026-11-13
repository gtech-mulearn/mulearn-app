// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_circle_invite_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReceivedCircleInviteDto _$ReceivedCircleInviteDtoFromJson(
  Map<String, dynamic> json,
) => _ReceivedCircleInviteDto(
  linkId: json['link_id'] as String,
  circleId: json['circle_id'] as String,
  circleTitle: json['circle_title'] as String,
  ig: json['ig'] as String?,
  isLeadInvite: json['is_lead_invite'] as bool? ?? false,
  invitedBy: json['invited_by'] == null
      ? null
      : CircleInviterDto.fromJson(json['invited_by'] as Map<String, dynamic>),
  createdAt: json['created_at'] as String?,
);

Map<String, dynamic> _$ReceivedCircleInviteDtoToJson(
  _ReceivedCircleInviteDto instance,
) => <String, dynamic>{
  'link_id': instance.linkId,
  'circle_id': instance.circleId,
  'circle_title': instance.circleTitle,
  'ig': instance.ig,
  'is_lead_invite': instance.isLeadInvite,
  'invited_by': instance.invitedBy,
  'created_at': instance.createdAt,
};

_CircleInviterDto _$CircleInviterDtoFromJson(Map<String, dynamic> json) =>
    _CircleInviterDto(
      userId: json['user_id'] as String?,
      fullName: json['full_name'] as String?,
      profilePic: json['profile_pic'] as String?,
    );

Map<String, dynamic> _$CircleInviterDtoToJson(_CircleInviterDto instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'profile_pic': instance.profilePic,
    };
