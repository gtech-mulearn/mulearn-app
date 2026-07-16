import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';

abstract interface class CalendarRepository {
  /// [start]/[end] must be no more than 93 days apart (backend-enforced).
  Future<List<CalendarEntry>> getEntries({
    required DateTime start,
    required DateTime end,
  });
}
