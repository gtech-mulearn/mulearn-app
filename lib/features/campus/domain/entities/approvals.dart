import 'package:freezed_annotation/freezed_annotation.dart';

part 'approvals.freezed.dart';

/// A learner asking to be verified at the campus (an unverified college
/// link). Deliberately no email or mobile: the app needs no contact data.
@freezed
abstract class OrgLinkRequest with _$OrgLinkRequest {
  const factory OrgLinkRequest({
    required String id,
    required String fullName,
    required String muid,
    required String orgTitle,
    required bool isAlumni,
    DateTime? requestedAt,
    String? graduationYear,
  }) = _OrgLinkRequest;
}

/// A campus event waiting for the campus's approval.
@freezed
abstract class PendingCampusEvent with _$PendingCampusEvent {
  const factory PendingCampusEvent({
    required String id,
    required String title,
    required List<String> tags,
    DateTime? start,
    DateTime? end,
    String? venueCity,
  }) = _PendingCampusEvent;
}

/// An invitation for the campus to collaborate on an event.
@freezed
abstract class CollabInvite with _$CollabInvite {
  const factory CollabInvite({
    required String id,
    required String eventId,
    required String eventTitle,
    required String roleLabel,
    required String entityName,
    DateTime? eventStart,
  }) = _CollabInvite;
}
