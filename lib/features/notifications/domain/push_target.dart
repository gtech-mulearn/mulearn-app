import 'package:mulearn_app/core/notifications/push/push_messaging.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/notification_target.dart';

/// Where a tapped push leads.
///
/// Engagement nudges and admin campaigns carry an in-app `route` chosen by
/// the server. Activity pushes carry the notification's own fields (type,
/// entity, redirect URL) and route exactly like a tap in the feed.
NotificationTarget pushTarget(PushOpen open, {required Uri dashboardBase}) {
  final route = open.route;
  if (route != null && route.startsWith('/') && !route.startsWith('//')) {
    return AppRoute(route);
  }
  if (open.type == null && open.redirectUrl == null) return const NoTarget();
  return notificationTarget(
    AppNotification(
      id: open.dedupeKey ?? '',
      title: open.title,
      description: open.body,
      isBroadcast: false,
      read: false,
      createdAt: DateTime.now(),
      type: open.type,
      entityType: open.entityType,
      entityId: open.entityId,
      redirectUrl: open.redirectUrl,
    ),
    dashboardBase: dashboardBase,
  );
}
