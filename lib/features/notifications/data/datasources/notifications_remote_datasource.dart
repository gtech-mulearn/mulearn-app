import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/paging.dart';

/// The v2 notification API (`api/notification/notification_view.py`). Every
/// write sends `{}` like the dashboard (`notification.api.ts`).
class NotificationsRemoteDataSource {
  const NotificationsRemoteDataSource(this._dio);

  final Dio _dio;

  /// `{count, page, page_size, results}`.
  Future<Map<String, dynamic>> fetchPage(int page) async => ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(NotificationPaths.feed, queryParameters: PagePaging.query(page)),
      );

  Future<void> markRead(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.patch<dynamic>(NotificationPaths.read(id), data: <String, dynamic>{}));

  Future<void> markAllRead() async =>
      ApiEnvelope.unwrapObject(await _dio.patch<dynamic>(NotificationPaths.readAll, data: <String, dynamic>{}));

  Future<void> archive(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.patch<dynamic>(NotificationPaths.archive(id), data: <String, dynamic>{}));
}
