// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPreferencesDto _$UserPreferencesDtoFromJson(Map<String, dynamic> json) =>
    _UserPreferencesDto(
      interestedInWork: json['interested_in_work'] as bool,
      interestedInGigWork: json['interested_in_gig_work'] as bool,
      domains: (json['domains'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      endgoals: (json['endgoals'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      orgs: (json['orgs'] as List<dynamic>?)
          ?.map((e) => OrgRefDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserPreferencesDtoToJson(_UserPreferencesDto instance) =>
    <String, dynamic>{
      'interested_in_work': instance.interestedInWork,
      'interested_in_gig_work': instance.interestedInGigWork,
      'domains': instance.domains,
      'endgoals': instance.endgoals,
      'orgs': instance.orgs,
    };
