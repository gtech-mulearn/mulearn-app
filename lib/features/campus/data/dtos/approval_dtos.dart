import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/campus/domain/entities/approvals.dart';

part 'approval_dtos.freezed.dart';
part 'approval_dtos.g.dart';

DateTime? _time(String? v) => v == null || v.isEmpty ? null : DateTime.tryParse(v)?.toUtc();

/// One row of `user/unverified-org-links/` (`UnverifiedOrgLinkUsersSerializer`).
/// `email` and `mobile` are not read.
@freezed
abstract class OrgLinkRequestDto with _$OrgLinkRequestDto {
  const factory OrgLinkRequestDto({
    required String id,
    @Default('') String fullName,
    @Default('') String muid,
    @Default('') String orgTitle,
    String? graduationYear,
    @Default(false) bool isAlumni,
    String? linkCreatedAt,
  }) = _OrgLinkRequestDto;

  const OrgLinkRequestDto._();

  factory OrgLinkRequestDto.fromJson(Map<String, dynamic> json) => _$OrgLinkRequestDtoFromJson(json);

  OrgLinkRequest toDomain() => OrgLinkRequest(
        id: id,
        fullName: fullName,
        muid: muid,
        orgTitle: orgTitle,
        isAlumni: isAlumni,
        graduationYear: (graduationYear ?? '').isEmpty ? null : graduationYear,
        requestedAt: _time(linkCreatedAt),
      );
}

/// One row of `campus/events/?status=pending_campus_approval`.
@freezed
abstract class PendingCampusEventDto with _$PendingCampusEventDto {
  const factory PendingCampusEventDto({
    required String id,
    @Default('') String title,
    String? startDatetime,
    String? endDatetime,
    String? venueCity,
    @Default(<String>[]) List<String> tags,
  }) = _PendingCampusEventDto;

  const PendingCampusEventDto._();

  factory PendingCampusEventDto.fromJson(Map<String, dynamic> json) => _$PendingCampusEventDtoFromJson(json);

  PendingCampusEvent toDomain() => PendingCampusEvent(
        id: id,
        title: title,
        tags: tags,
        start: _time(startDatetime),
        end: _time(endDatetime),
        venueCity: (venueCity ?? '').isEmpty ? null : venueCity,
      );
}

/// One item of `events/my-invites/` (`MyEventInviteSerializer`).
@freezed
abstract class CollabInviteDto with _$CollabInviteDto {
  const factory CollabInviteDto({
    required String id,
    required String eventId,
    @Default('') String eventTitle,
    String? eventStartDatetime,
    @Default('') String roleLabel,
    Map<String, dynamic>? entityDetail,
  }) = _CollabInviteDto;

  const CollabInviteDto._();

  factory CollabInviteDto.fromJson(Map<String, dynamic> json) => _$CollabInviteDtoFromJson(json);

  CollabInvite toDomain() => CollabInvite(
        id: id,
        eventId: eventId,
        eventTitle: eventTitle,
        roleLabel: roleLabel,
        entityName: '${entityDetail?['title'] ?? entityDetail?['name'] ?? ''}',
        eventStart: _time(eventStartDatetime),
      );
}
