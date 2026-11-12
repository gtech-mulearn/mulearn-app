import 'package:freezed_annotation/freezed_annotation.dart';

part 'received_circle_invite.freezed.dart';

/// An invitation the signed-in user has received and not yet answered —
/// `GET learningcircle/invite/status/` (CircleInviteStatusSerializer).
/// Answered with `POST learningcircle/invite/status/<linkId>/`.
@freezed
abstract class ReceivedCircleInvite with _$ReceivedCircleInvite {
  const factory ReceivedCircleInvite({
    required String linkId,
    required String circleId,
    required String circleTitle,
    String? igName,
    @Default(false) bool isLeadInvite,
    String? invitedByName,
    String? invitedByProfilePic,
    String? createdAt,
  }) = _ReceivedCircleInvite;
}
