import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_organizer_ig.freezed.dart';

/// The interest group organising an event, when
/// [EventOrganizer.organiserType] is `global_ig` or `campus_ig` — pure-Dart
/// domain entity (rules.md §2).
@freezed
abstract class EventOrganizerIg with _$EventOrganizerIg {
  const factory EventOrganizerIg({
    required String id,
    required String name,
    String? iconImage,
  }) = _EventOrganizerIg;
}
