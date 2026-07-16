import 'package:freezed_annotation/freezed_annotation.dart';

part 'circle_invite.freezed.dart';

/// An invite to join a circle — confirmed live shape for the *sent*-invites
/// view (`GET learningcircle/invite/sent/{circleId}/`): `{link_id, user_id,
/// full_name, profile_pic, muid, is_lead_invite, status, invited_at}`.
/// The *received* view (`GET learningcircle/invite/status/`) shares this
/// endpoint family but was unverified live (the test account had none
/// pending); [circleId]/[circleTitle] are therefore nullable/best-effort —
/// present when responding to an incoming invite, absent when viewing a
/// circle's own sent list (redundant with the screen's context there).
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
    String? circleId,
    String? circleTitle,
    @Default(false) bool isLeadInvite,
  }) = _CircleInvite;
}
