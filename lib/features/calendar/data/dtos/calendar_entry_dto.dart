import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';

part 'calendar_entry_dto.freezed.dart';
part 'calendar_entry_dto.g.dart';

/// One item of `calendar/events/`'s `events.{upcoming,ongoing,completed}`
/// buckets — EventCalendarItemSerializer: `{id, title, slug, status, start,
/// end, venue_type, organiser_name, category_name, is_featured}` (confirmed
/// live on dev 2026-11-12). Mentor sessions use their own shape:
/// [CalendarSessionDto].
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
