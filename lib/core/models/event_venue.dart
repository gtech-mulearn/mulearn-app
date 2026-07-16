import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_venue.freezed.dart';

/// Where a [FeaturedEvent] takes place — pure-Dart domain entity (rules.md
/// §2). Confirmed live: physical events populate the address/city/maps
/// fields; online events populate the link/platform fields instead.
@freezed
abstract class EventVenue with _$EventVenue {
  const factory EventVenue({
    required String venueType,
    String? venueAddress,
    String? venueCity,
    String? venueMapsUrl,
    String? venueOnlineLink,
    String? venuePlatform,
  }) = _EventVenue;
}
