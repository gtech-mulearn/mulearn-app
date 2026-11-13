import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/events/data/datasources/events_remote_datasource.dart';
import 'package:mulearn_app/features/events/data/dtos/event_dto.dart';
import 'package:mulearn_app/features/events/domain/entities/event.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/domain/entities/event_page.dart';
import 'package:mulearn_app/features/events/domain/repositories/events_repository.dart';

class EventsRepositoryImpl implements EventsRepository {
  const EventsRepositoryImpl(this._remote);

  final EventsRemoteDataSource _remote;

  @override
  Future<EventPage> getEvents({required int pageIndex, EventFilter filter = const EventFilter()}) =>
      _guard(() async {
        final payload = await _remote.fetchEvents(pageIndex: pageIndex, filter: filter);
        final items = payload['data'] as List<dynamic>? ?? [];
        final info = PageIndexPaging.parse(payload['pagination'] as Map<String, dynamic>?);
        return EventPage(
          events: parseEachOrReport(
            items,
            (json) => EventDto.fromJson(json).toDomain(),
            what: 'EventDto',
          ),
          hasNext: info.hasNext,
          totalPages: info.totalPages,
        );
      });

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
