import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer.dart';
import 'package:mulearn_app/core/models/event_venue.dart';

part 'event.freezed.dart';

/// A single event — pure-Dart domain entity (rules.md §2). One shape covers
/// both the list (`GET /events/`) and detail (`GET /events/{id}/`) rows,
/// which share every field below; detail-only fields (description, banner,
/// registration info) are simply `null` on list rows.
@freezed
abstract class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required String slug,
    required String status,
    required String eventScope,
    required String eventType,
    required String startDatetime,
    required String endDatetime,
    required EventVenue venue,
    required EventOrganizer organizer,
    required bool isFeatured,
    required bool isCollaboration,
    required int interestCount,
    required String viewerInterestStatus,
    @Default([]) List<String> tags,
    String? coverImage,
    String? bannerImage,
    String? description,
    String? categoryName,
    String? registrationUrl,
    String? registrationDeadline,
    int? minKarma,
    int? userLimit,
  }) = _Event;

  const Event._();

  bool get isInterested => viewerInterestStatus != 'none';
}
