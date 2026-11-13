import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/paging.dart';
import 'package:mulearn_app/core/network/tolerant_parse.dart';
import 'package:mulearn_app/features/notifications/data/datasources/notifications_remote_datasource.dart';
import 'package:mulearn_app/features/notifications/data/dtos/notification_dto.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._remote);

  final NotificationsRemoteDataSource _remote;

  @override
  Future<NotificationPage> getPage(int page) => _guard(() async {
        final body = await _remote.fetchPage(page);
        final items = parseEachOrReport(
          body['results'] as List<dynamic>? ?? const [],
          (json) => NotificationDto.fromJson(json).toDomain(),
          what: 'NotificationDto',
        );
        return (items: items, hasNext: PagePaging.parse(body).hasNext);
      });

  @override
  Future<void> markRead(String id) => _guard(() => _remote.markRead(id));

  @override
  Future<void> markAllRead() => _guard(_remote.markAllRead);

  @override
  Future<void> archive(String id) => _guard(() => _remote.archive(id));

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
