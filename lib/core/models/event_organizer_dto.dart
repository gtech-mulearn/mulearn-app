import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer.dart';
import 'package:mulearn_app/core/models/event_organizer_company_dto.dart';

part 'event_organizer_dto.freezed.dart';
part 'event_organizer_dto.g.dart';

@freezed
abstract class EventOrganizerDto with _$EventOrganizerDto {
  const factory EventOrganizerDto({
    required String organiserType,
    String? organiserIg,
    String? organiserCampus,
    EventOrganizerCompanyDto? organiserCompany,
    String? organiserCiId,
  }) = _EventOrganizerDto;

  const EventOrganizerDto._();

  factory EventOrganizerDto.fromJson(Map<String, dynamic> json) =>
      _$EventOrganizerDtoFromJson(json);

  EventOrganizer toDomain() => EventOrganizer(
        organiserType: organiserType,
        organiserIg: organiserIg,
        organiserCampus: organiserCampus,
        organiserCompany: organiserCompany?.toDomain(),
        organiserCiId: organiserCiId,
      );
}
