import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';

part 'calendar_entry.freezed.dart';

/// A single row on the calendar — an event or, for mentors, a mentorship
/// session — flattened from `calendar/events/`'s
/// `{events,sessions}.{upcoming,ongoing,completed}` buckets into one list.
/// [kind] records which top-level bucket it came from.
@freezed
abstract class CalendarEntry with _$CalendarEntry {
  const factory CalendarEntry({
    required String id,
    required String title,
    required String start,
    required String end,
    required String status,
    required CalendarEntryKind kind,
    String? venueType,
    String? organiserName,
    String? categoryName,
    @Default(false) bool isFeatured,
  }) = _CalendarEntry;
}
