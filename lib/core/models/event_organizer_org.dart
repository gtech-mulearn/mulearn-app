import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_organizer_org.freezed.dart';

/// The campus or company organising an event — pure-Dart domain entity
/// (rules.md §2). The backend serialises both with `MinimalCampusSerializer`
/// (`{id, title, org_type}`), so one type covers [EventOrganizer.organiserCampus]
/// and [EventOrganizer.organiserCompany].
@freezed
abstract class EventOrganizerOrg with _$EventOrganizerOrg {
  const factory EventOrganizerOrg({
    required String id,
    required String title,
    required String orgType,
  }) = _EventOrganizerOrg;
}
