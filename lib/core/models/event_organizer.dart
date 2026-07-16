import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/models/event_organizer_company.dart';

part 'event_organizer.freezed.dart';

/// Who organized a [FeaturedEvent] — pure-Dart domain entity (rules.md §2).
/// `organiserType` determines which of the other fields is populated
/// (confirmed live: `admin`/`company` seen so far; `ig`/`campus` fields
/// exist in the shape for parity with the reference dashboard's type).
@freezed
abstract class EventOrganizer with _$EventOrganizer {
  const factory EventOrganizer({
    required String organiserType,
    String? organiserIg,
    String? organiserCampus,
    EventOrganizerCompany? organiserCompany,
    String? organiserCiId,
  }) = _EventOrganizer;
}
