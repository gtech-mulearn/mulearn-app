import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';
import 'package:mulearn_app/features/events/data/datasources/events_remote_datasource.dart';
import 'package:mulearn_app/features/events/data/dtos/event_dto.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_page.dart';
import 'package:mulearn_app/features/events/domain/repositories/events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  const EventsRepositoryImpl(this._remote);

  final EventsRemoteDataSource _remote;

  @override
  Future<EventPage> getEvents({int page = 1}) => _guard(() async {
        final payload = await _remote.fetchEvents(page: page);
        final items = payload['data'] as List<dynamic>? ?? [];
        final pagination = payload['pagination'] as Map<String, dynamic>?;
        return EventPage(
          events: _parseSkippingErrors(
            items,
            (json) => EventDto.fromJson(json).toDomain(),
          ),
          hasNext: pagination?['isNext'] as bool? ?? false,
          totalPages: pagination?['totalPages'] as int? ?? 1,
        );
      });

  /// Skips rows that don't match [EventDto]'s expected shape instead of
  /// crashing the whole page — mirrors the same defensive pattern used in
  /// `LearningCirclesRepositoryImpl` for backends whose list rows don't
  /// reliably match the assumed DTO shape.
  List<T> _parseSkippingErrors<T>(
    List<dynamic> items,
    T Function(Map<String, dynamic>) parse,
  ) {
    final results = <T>[];
    for (final item in items) {
      try {
        results.add(parse(item as Map<String, dynamic>));
      } on Object catch (e, st) {
        appLogger.e('Skipping malformed event list row', error: e, stackTrace: st);
      }
    }
    return results;
  }

  @override
  Future<Event> getEventDetail(String id) => _guard(() async {
        final json = await _remote.fetchEventDetail(id);
        return EventDto.fromJson(json).toDomain();
      });

  @override
  Future<void> setInterested(String id, {required bool interested}) =>
      _guard(() => _remote.setInterested(id, interested: interested));

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
