import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';

part 'notification_dto.freezed.dart';
part 'notification_dto.g.dart';

/// One `results[]` item of `GET /api/v1/notification/`
/// (`NotificationListView`, `api/notification/notification_view.py`).
/// Broadcast rows have `type`/`entity_type`/`entity_id` null (recorded on dev).
@freezed
abstract class NotificationDto with _$NotificationDto {
  const factory NotificationDto({
    required String id,
    required String createdAt,
    String? type,
    String? category,
    @Default('') String title,
    @Default('') String description,
    String? entityType,
    String? entityId,
    @Default(false) bool isRead,
    @Default('personal') String source,
    String? redirectUrl,
  }) = _NotificationDto;

  const NotificationDto._();

  factory NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);

  AppNotification toDomain() => AppNotification(
        id: id,
        title: title,
        description: description,
        isBroadcast: source == 'broadcast',
        read: isRead,
        createdAt: DateTime.parse(createdAt).toUtc(),
        type: type,
        category: category,
        entityType: entityType,
        entityId: entityId,
        redirectUrl: redirectUrl,
      );
}
