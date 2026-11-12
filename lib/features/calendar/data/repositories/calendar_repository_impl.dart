import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/calendar/data/datasources/calendar_remote_datasource.dart';
import 'package:mulearn_app/features/calendar/data/dtos/calendar_entry_dto.dart';
import 'package:mulearn_app/features/calendar/data/dtos/calendar_session_dto.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry.dart';
import 'package:mulearn_app/features/calendar/domain/entities/calendar_entry_kind.dart';
import 'package:mulearn_app/features/calendar/domain/repositories/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  const CalendarRepositoryImpl(this._remote);

  final CalendarRemoteDataSource _remote;

  @override
  Future<List<CalendarEntry>> getEntries({
    required DateTime start,
    required DateTime end,
  }) =>
      _guard(() async {
        final payload = await _remote.fetchEntries(
          startDate: _isoDate(start),
          endDate: _isoDate(end),
        );
        final events = payload['events'] as Map<String, dynamic>? ?? {};
        final sessions = payload['sessions'] as Map<String, dynamic>? ?? {};
        return [
          ..._parseEach(
            _bucketItems(events),
            (json) => CalendarEntryDto.fromJson(json).toDomain(CalendarEntryKind.event),
          ),
          ..._parseEach(
            _bucketItems(sessions),
            (json) => CalendarSessionDto.fromJson(json).toDomain(),
          ),
        ];
      });

  /// Items from the `upcoming`, `ongoing` and `completed` buckets, in order.
  Iterable<dynamic> _bucketItems(Map<String, dynamic> buckets) =>
      const ['upcoming', 'ongoing', 'completed']
          .expand((key) => buckets[key] as List<dynamic>? ?? const []);

  /// Parses each item on its own, so one malformed entry is logged and
  /// skipped instead of blanking the whole calendar.
  List<CalendarEntry> _parseEach(
    Iterable<dynamic> items,
    CalendarEntry Function(Map<String, dynamic> json) parse,
  ) {
    final entries = <CalendarEntry>[];
    for (final item in items) {
      try {
        entries.add(parse(item as Map<String, dynamic>));
      } on Object catch (e, st) {
        appLogger.e('Skipping a calendar item that failed to parse', error: e, stackTrace: st);
      }
    }
    return entries;
  }

  String _isoDate(DateTime date) =>
      '${date.year.toString().padLeft(4, '0')}-'
      '${date.month.toString().padLeft(2, '0')}-'
      '${date.day.toString().padLeft(2, '0')}';

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
