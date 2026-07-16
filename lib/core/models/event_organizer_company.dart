import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_organizer_company.freezed.dart';

/// The company organizing an event, when [EventOrganizer.organiserType] is
/// `"company"` — pure-Dart domain entity (rules.md §2).
@freezed
abstract class EventOrganizerCompany with _$EventOrganizerCompany {
  const factory EventOrganizerCompany({
    required String id,
    required String title,
    required String orgType,
  }) = _EventOrganizerCompany;
}
