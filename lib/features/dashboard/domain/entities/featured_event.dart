import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer.dart';
import 'package:mulearn_app/core/models/event_venue.dart';

part 'featured_event.freezed.dart';

/// A featured event shown on the home dashboard — pure-Dart domain entity
/// (rules.md §2). Confirmed against a real
/// `GET /api/v1/dashboard/events/featured/` response; only the fields the
/// home screen's event card actually displays are carried into this entity.
@freezed
abstract class FeaturedEvent with _$FeaturedEvent {
  const factory FeaturedEvent({
    required String id,
    required String title,
    required String slug,
    required String status,
    required String eventScope,
    required String startDatetime,
    required String endDatetime,
    required EventVenue venue,
    required EventOrganizer organizer,
    required bool isCollaboration,
    required int interestCount,
    @Default([]) List<String> tags,
    String? coverImage,
    int? minKarma,
  }) = _FeaturedEvent;
}
