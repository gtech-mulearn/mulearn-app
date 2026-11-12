import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/received_circle_invite.dart';

part 'received_circle_invite_dto.freezed.dart';
part 'received_circle_invite_dto.g.dart';

/// One item of `GET learningcircle/invite/status/` —
/// CircleInviteStatusSerializer: `{link_id, circle_id, circle_title, ig,
/// is_lead_invite, invited_by: {user_id, full_name, profile_pic} | null,
/// created_at}`. Confirmed live on dev 2026-11-12.
@freezed
abstract class ReceivedCircleInviteDto with _$ReceivedCircleInviteDto {
  const factory ReceivedCircleInviteDto({
    required String linkId,
    required String circleId,
    required String circleTitle,
    String? ig,
    @Default(false) bool isLeadInvite,
    CircleInviterDto? invitedBy,
    String? createdAt,
  }) = _ReceivedCircleInviteDto;

  const ReceivedCircleInviteDto._();

  factory ReceivedCircleInviteDto.fromJson(Map<String, dynamic> json) =>
      _$ReceivedCircleInviteDtoFromJson(json);

  ReceivedCircleInvite toDomain() => ReceivedCircleInvite(
        linkId: linkId,
        circleId: circleId,
        circleTitle: circleTitle,
        igName: ig,
        isLeadInvite: isLeadInvite,
        invitedByName: invitedBy?.fullName,
        invitedByProfilePic: invitedBy?.profilePic,
        createdAt: createdAt,
      );
}

/// `invited_by` — null when the inviter's account no longer exists.
@freezed
abstract class CircleInviterDto with _$CircleInviterDto {
  const factory CircleInviterDto({
    String? userId,
    String? fullName,
    String? profilePic,
  }) = _CircleInviterDto;

  factory CircleInviterDto.fromJson(Map<String, dynamic> json) =>
      _$CircleInviterDtoFromJson(json);
}
