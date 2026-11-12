import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer.dart';
import 'package:mulearn_app/core/models/event_organizer_ig_dto.dart';
import 'package:mulearn_app/core/models/event_organizer_org_dto.dart';

part 'event_organizer_dto.freezed.dart';
part 'event_organizer_dto.g.dart';

/// `organizer` on event list/detail/featured rows — `OrganizerInfoSerializer`
/// in api/dashboard/events/serializers.py.
@freezed
abstract class EventOrganizerDto with _$EventOrganizerDto {
  const factory EventOrganizerDto({
    required String organiserType,
    EventOrganizerIgDto? organiserIg,
    EventOrganizerOrgDto? organiserCampus,
    EventOrganizerOrgDto? organiserCompany,
    String? organiserCiId,
  }) = _EventOrganizerDto;

  const EventOrganizerDto._();

  factory EventOrganizerDto.fromJson(Map<String, dynamic> json) =>
      _$EventOrganizerDtoFromJson(json);

  EventOrganizer toDomain() => EventOrganizer(
        organiserType: organiserType,
        organiserIg: organiserIg?.toDomain(),
        organiserCampus: organiserCampus?.toDomain(),
        organiserCompany: organiserCompany?.toDomain(),
        organiserCiId: organiserCiId,
      );
}
