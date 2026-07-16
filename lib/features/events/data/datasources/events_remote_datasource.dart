import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

class EventsRemoteDataSource {
  EventsRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/events/?page=` — `{data: [...], pagination:
  /// {count, totalPages, isNext, isPrev, nextPage}}`.
  Future<Map<String, dynamic>> fetchEvents({int page = 1}) async {
    final response = await _dio.get<dynamic>(
      ApiPaths.events,
      queryParameters: {'page': page},
    );
    return ApiEnvelope.unwrapObject(response);
  }

  Future<Map<String, dynamic>> fetchEventDetail(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.eventDetail(id));
    return ApiEnvelope.unwrapObject(response);
  }

  Future<void> setInterested(String id, {required bool interested}) async {
    final response = interested
        ? await _dio.post<dynamic>(ApiPaths.eventInterest(id))
        : await _dio.delete<dynamic>(ApiPaths.eventInterest(id));
    ApiEnvelope.unwrapObject(response);
  }
}
