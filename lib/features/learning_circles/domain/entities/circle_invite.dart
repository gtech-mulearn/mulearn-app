import 'package:freezed_annotation/freezed_annotation.dart';

part 'circle_invite.freezed.dart';

/// An invite a circle lead has sent — `GET learningcircle/invite/sent/{circleId}/`
/// (CircleSentInvitesSerializer): `{link_id, user_id, full_name, profile_pic,
/// muid, is_lead_invite, status, invited_at}`. Invites the signed-in user has
/// *received* are [ReceivedCircleInvite].
@freezed
abstract class CircleInvite with _$CircleInvite {
  const factory CircleInvite({
    required String linkId,
    required String fullName,
    required String muid,
    required String status,
    String? userId,
    String? profilePicUrl,
    String? invitedAt,
    @Default(false) bool isLeadInvite,
  }) = _CircleInvite;
}
