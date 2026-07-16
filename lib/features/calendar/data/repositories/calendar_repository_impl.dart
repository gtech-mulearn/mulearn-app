import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/calendar/data/datasources/calendar_remote_datasource.dart';
import 'package:mulearn_app/features/calendar/data/dtos/calendar_entry_dto.dart';
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
          ..._flatten(events, CalendarEntryKind.event),
          ..._flatten(sessions, CalendarEntryKind.session),
        ];
      });

  List<CalendarEntry> _flatten(
    Map<String, dynamic> buckets,
    CalendarEntryKind kind,
  ) {
    const bucketKeys = ['upcoming', 'ongoing', 'completed'];
    return bucketKeys
        .expand((key) => buckets[key] as List<dynamic>? ?? [])
        .cast<Map<String, dynamic>>()
        .map((json) => CalendarEntryDto.fromJson(json).toDomain(kind))
        .toList();
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
