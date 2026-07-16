import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_invite.dart';

part 'circle_invite_dto.freezed.dart';
part 'circle_invite_dto.g.dart';

/// Confirmed live for the sent-invites view (rules.md §3/§9): `{link_id,
/// user_id, full_name, profile_pic, muid, is_lead_invite, status,
/// invited_at}`. `circle_id`/`circle_title` are additive fields expected
/// (not verified) on the received-invites view — see [CircleInvite]'s doc.
@freezed
abstract class CircleInviteDto with _$CircleInviteDto {
  const factory CircleInviteDto({
    required String linkId,
    required String fullName,
    required String muid,
    @Default('pending') String status,
    String? userId,
    String? profilePic,
    String? invitedAt,
    String? circleId,
    String? circleTitle,
    @Default(false) bool isLeadInvite,
  }) = _CircleInviteDto;

  const CircleInviteDto._();

  factory CircleInviteDto.fromJson(Map<String, dynamic> json) =>
      _$CircleInviteDtoFromJson(json);

  CircleInvite toDomain() => CircleInvite(
        linkId: linkId,
        fullName: fullName,
        muid: muid,
        status: status,
        userId: userId,
        profilePicUrl: profilePic,
        invitedAt: invitedAt,
        circleId: circleId,
        circleTitle: circleTitle,
        isLeadInvite: isLeadInvite,
      );
}
