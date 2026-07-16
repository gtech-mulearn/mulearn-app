// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_venue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EventVenueDto _$EventVenueDtoFromJson(Map<String, dynamic> json) =>
    _EventVenueDto(
      venueType: json['venue_type'] as String,
      venueAddress: json['venue_address'] as String?,
      venueCity: json['venue_city'] as String?,
      venueMapsUrl: json['venue_maps_url'] as String?,
      venueOnlineLink: json['venue_online_link'] as String?,
      venuePlatform: json['venue_platform'] as String?,
    );

Map<String, dynamic> _$EventVenueDtoToJson(_EventVenueDto instance) =>
    <String, dynamic>{
      'venue_type': instance.venueType,
      'venue_address': instance.venueAddress,
      'venue_city': instance.venueCity,
      'venue_maps_url': instance.venueMapsUrl,
      'venue_online_link': instance.venueOnlineLink,
      'venue_platform': instance.venuePlatform,
    };
