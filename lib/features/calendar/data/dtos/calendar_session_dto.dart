import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';

part 'calendar_session_dto.freezed.dart';
part 'calendar_session_dto.g.dart';

/// One item of `calendar/events/`'s `sessions.{upcoming,ongoing,completed}`
/// buckets — MentorshipSessionCalendarSerializer (api/calendar/serializers.py):
/// `{id, title, description, mode, starts_at, ends_at, status, meeting_link,
/// venue, mentor_name, mentee_count}`. Only filled for users the backend
/// detects as mentors. The backend sends `mode`/`status` upper-case
/// (`ONLINE`, `SCHEDULED`); they are lower-cased to match the events'
/// `venue_type`/`status` vocabulary on [CalendarEntry].
@freezed
abstract class CalendarSessionDto with _$CalendarSessionDto {
  const factory CalendarSessionDto({
    required String id,
    required String title,
    required String startsAt,
    required String endsAt,
    @Default('') String status,
    String? mode,
    String? meetingLink,
    String? venue,
    String? mentorName,
    int? menteeCount,
  }) = _CalendarSessionDto;

  const CalendarSessionDto._();

  factory CalendarSessionDto.fromJson(Map<String, dynamic> json) =>
      _$CalendarSessionDtoFromJson(json);

  CalendarEntry toDomain() => CalendarEntry(
        id: id,
        title: title,
        start: startsAt,
        end: endsAt,
        status: status.toLowerCase(),
        kind: CalendarEntryKind.session,
        venueType: mode?.toLowerCase(),
        organiserName: mentorName,
      );
}
