import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_org.dart';

part 'event_organizer_org_dto.freezed.dart';
part 'event_organizer_org_dto.g.dart';

/// `organizer.organiser_campus` / `organizer.organiser_company` —
/// `MinimalCampusSerializer` in api/dashboard/events/serializers.py.
@freezed
abstract class EventOrganizerOrgDto with _$EventOrganizerOrgDto {
  const factory EventOrganizerOrgDto({
    required String id,
    required String title,
    required String orgType,
  }) = _EventOrganizerOrgDto;

  const EventOrganizerOrgDto._();

  factory EventOrganizerOrgDto.fromJson(Map<String, dynamic> json) =>
      _$EventOrganizerOrgDtoFromJson(json);

  EventOrganizerOrg toDomain() => EventOrganizerOrg(
        id: id,
        title: title,
        orgType: orgType,
      );
}
