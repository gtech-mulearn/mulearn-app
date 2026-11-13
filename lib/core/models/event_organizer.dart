import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_ig.dart';
import 'package:mulearn_app/core/models/event_organizer_org.dart';

part 'event_organizer.freezed.dart';

/// Who organised an event — pure-Dart domain entity (rules.md §2).
/// `organiserType` (`admin`, `global_ig`, `campus_ig`, `campus`, `company`,
/// `partner`) determines which of the other fields is populated; all are
/// null for `admin`. Confirmed live on dev for admin, global_ig and campus.
@freezed
abstract class EventOrganizer with _$EventOrganizer {
  const factory EventOrganizer({
    required String organiserType,
    EventOrganizerIg? organiserIg,
    EventOrganizerOrg? organiserCampus,
    EventOrganizerOrg? organiserCompany,
    String? organiserCiId,
  }) = _EventOrganizer;
}
