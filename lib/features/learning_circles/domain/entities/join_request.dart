import 'package:freezed_annotation/freezed_annotation.dart';

part 'join_request.freezed.dart';

/// A pending request to join a circle, visible to the circle's lead
/// (`GET learningcircle/join/{id}/`).
@freezed
abstract class JoinRequest with _$JoinRequest {
  const factory JoinRequest({
    required String linkId,
    required String userId,
    required String fullName,
    required String muid,
    String? profilePicUrl,
    String? requestedAt,
  }) = _JoinRequest;
}
