import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_company.dart';

part 'event_organizer_company_dto.freezed.dart';
part 'event_organizer_company_dto.g.dart';

@freezed
abstract class EventOrganizerCompanyDto with _$EventOrganizerCompanyDto {
  const factory EventOrganizerCompanyDto({
    required String id,
    required String title,
    required String orgType,
  }) = _EventOrganizerCompanyDto;

  const EventOrganizerCompanyDto._();

  factory EventOrganizerCompanyDto.fromJson(Map<String, dynamic> json) =>
      _$EventOrganizerCompanyDtoFromJson(json);

  EventOrganizerCompany toDomain() => EventOrganizerCompany(
        id: id,
        title: title,
        orgType: orgType,
      );
}
