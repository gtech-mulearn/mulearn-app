import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';

part 'calendar_entry_dto.freezed.dart';
part 'calendar_entry_dto.g.dart';

/// Raw shape of one entry in any of `calendar/events/`'s six buckets.
/// Confirmed live for `events.*` (rules.md §3/§9): `{id, title, slug,
/// status, start, end, venue_type, organiser_name, category_name,
/// is_featured}`. The `sessions.*` buckets share the same endpoint and are
/// presumed to follow the same shape, but the test account belongs to no
/// learning circle yet, so that presumption is unverified — every field
/// beyond `id`/`title`/`start`/`end` is therefore nullable/defaulted here
/// so a shape mismatch degrades gracefully instead of crashing the parse.
@freezed
abstract class CalendarEntryDto with _$CalendarEntryDto {
  const factory CalendarEntryDto({
    required String id,
    required String title,
    required String start,
    required String end,
    @Default('') String status,
    String? venueType,
    String? organiserName,
    String? categoryName,
    @Default(false) bool isFeatured,
  }) = _CalendarEntryDto;

  const CalendarEntryDto._();

  factory CalendarEntryDto.fromJson(Map<String, dynamic> json) =>
      _$CalendarEntryDtoFromJson(json);

  CalendarEntry toDomain(CalendarEntryKind kind) => CalendarEntry(
        id: id,
        title: title,
        start: start,
        end: end,
        status: status,
        kind: kind,
        venueType: venueType,
        organiserName: organiserName,
        categoryName: categoryName,
        isFeatured: isFeatured,
      );
}
