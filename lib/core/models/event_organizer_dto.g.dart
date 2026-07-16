// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_organizer_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventOrganizerDto _$EventOrganizerDtoFromJson(Map<String, dynamic> json) =>
    _EventOrganizerDto(
      organiserType: json['organiser_type'] as String,
      organiserIg: json['organiser_ig'] as String?,
      organiserCampus: json['organiser_campus'] as String?,
      organiserCompany: json['organiser_company'] == null
          ? null
          : EventOrganizerCompanyDto.fromJson(
              json['organiser_company'] as Map<String, dynamic>,
            ),
      organiserCiId: json['organiser_ci_id'] as String?,
    );

Map<String, dynamic> _$EventOrganizerDtoToJson(_EventOrganizerDto instance) =>
    <String, dynamic>{
      'organiser_type': instance.organiserType,
      'organiser_ig': instance.organiserIg,
      'organiser_campus': instance.organiserCampus,
      'organiser_company': instance.organiserCompany,
      'organiser_ci_id': instance.organiserCiId,
    };
