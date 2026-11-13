import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer.dart';
import 'package:mulearn_app/core/models/event_venue.dart';
import 'package:mulearn_app/features/events/domain/entities/event_linked_task.dart';

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

    /// From the event detail: whether this viewer may register
    /// (`viewer_can_access_registration`) and why not
    /// (`viewer_access_blocked_reason`). List items don't carry them.
    @Default(true) bool canRegister,
    String? blockedReason,

    /// Live (approved) tasks linked to the event.
    @Default([]) List<EventLinkedTask> linkedTasks,
  }) = _Event;

  const Event._();

  bool get isInterested => viewerInterestStatus != 'none';
}
