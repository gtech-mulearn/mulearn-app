import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_venue.dart';

part 'event_venue_dto.freezed.dart';
part 'event_venue_dto.g.dart';

@freezed
abstract class EventVenueDto with _$EventVenueDto {
  const factory EventVenueDto({
    required String venueType,
    String? venueAddress,
    String? venueCity,
    String? venueMapsUrl,
    String? venueOnlineLink,
    String? venuePlatform,
  }) = _EventVenueDto;

  const EventVenueDto._();

  factory EventVenueDto.fromJson(Map<String, dynamic> json) =>
      _$EventVenueDtoFromJson(json);

  EventVenue toDomain() => EventVenue(
        venueType: venueType,
        venueAddress: venueAddress,
        venueCity: venueCity,
        venueMapsUrl: venueMapsUrl,
        venueOnlineLink: venueOnlineLink,
        venuePlatform: venuePlatform,
      );
}
