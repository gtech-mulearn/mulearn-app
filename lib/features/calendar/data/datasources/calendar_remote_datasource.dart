import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

class CalendarRemoteDataSource {
  CalendarRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET .../calendar/events/?start_date=&end_date=` —
  /// `response.{events,sessions}.{upcoming,ongoing,completed}`.
  Future<Map<String, dynamic>> fetchEntries({
    required String startDate,
    required String endDate,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiPaths.calendarEvents,
      queryParameters: {'start_date': startDate, 'end_date': endDate},
    );
    return ApiEnvelope.unwrapObject(response);
  }
}
