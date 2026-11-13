import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';

part 'notification_target.freezed.dart';

/// Where tapping a notification goes: a screen in the app (a go_router
/// location), a web page opened in the browser (the dashboard for screens the
/// app doesn't have, or a sender's own https link), or nothing.
@freezed
sealed class NotificationTarget with _$NotificationTarget {
  const factory NotificationTarget.appRoute(String location) = AppRoute;
  const factory NotificationTarget.webPage(Uri uri) = WebPage;
  const factory NotificationTarget.none() = NoTarget;
}

/// The dashboard's rule (`notification-href.ts`): a safe `redirect_url`
/// wins, otherwise the typed link; unknown types get nothing. Dashboard
/// paths the app has become app routes; the rest open on [dashboardBase].
///
/// Deliberate difference: `EVENT_PUBLISHED` opens the public event page. The
/// backend sends it to everyone in the event's scope
/// (`Audience.event_scope`), while the dashboard links it to the organiser's
/// manage page.
NotificationTarget notificationTarget(AppNotification n, {required Uri dashboardBase}) {
  final fromUrl = _fromRedirectUrl(n.redirectUrl?.trim(), dashboardBase);
  if (fromUrl != null) return fromUrl;
  return _fromType(n, dashboardBase) ?? const NoTarget();
}

NotificationTarget? _fromRedirectUrl(String? url, Uri base) {
  if (url == null || url.isEmpty) return null;
  if (url.startsWith('/') && !url.startsWith('//')) return _fromPath(url, base);
  final uri = Uri.tryParse(url);
  if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) return null;
  if (uri.origin == base.origin) return _fromPath(uri.path, base);
  return WebPage(uri);
}

final _circle = RegExp(r'^/dashboard/learning-circle/?([^/]*)/?$');
final _event = RegExp(r'^/dashboard/events/?([^/]*)/?$');

NotificationTarget _fromPath(String pathAndQuery, Uri base) {
  final path = Uri.parse(pathAndQuery).path;
  final circle = _circle.firstMatch(path);
  if (circle != null) {
    final id = circle.group(1)!;
    return AppRoute(id.isEmpty ? RoutePaths.learningCircles : RoutePaths.learningCircleDetailPath(id));
  }
  final event = _event.firstMatch(path);
  if (event != null) {
    final id = event.group(1)!;
    return AppRoute(id.isEmpty ? RoutePaths.events : RoutePaths.eventDetailPath(id));
  }
  if (path == '/dashboard/profile' || path == '/dashboard/profile/') return const AppRoute(RoutePaths.profile);
  return WebPage(base.resolve(pathAndQuery));
}

const _manageEventTypes = {
  'ADMIN_EVENT_PENDING',
  'CAMPUS_EVENT_PENDING',
  'MENTOR_EVENT_PENDING',
  'EVENT_APPROVAL_STAGE',
  'EVENT_REJECTED',
};

NotificationTarget? _fromType(AppNotification n, Uri base) {
  final type = n.type ?? '';
  final id = n.entityId;
  WebPage web(String path) => WebPage(base.resolve(path));

  if (type == 'EVENT_PUBLISHED' || type == 'EVENT_CANCELLED') {
    return id == null ? null : AppRoute(RoutePaths.eventDetailPath(id));
  }
  if (_manageEventTypes.contains(type) || type.startsWith('EVENT_CO_OWNER_') || type.startsWith('EVENT_COLLAB_')) {
    return web(id == null ? '/dashboard/manage-events' : '/dashboard/manage-events/${Uri.encodeComponent(id)}');
  }
  if (type == 'ADMIN_COMPANY_PENDING') return web('/dashboard/management/manage-companies');
  if (type == 'COMPANY_DELEGATE_REVOKED') return web('/dashboard');
  if (type == 'COMPANY_REJECTED') return web('/dashboard/company/profile/edit');
  if (type == 'JOB_APPLICATION_STATUS') return web('/dashboard/jobs');
  if (type == 'COMPANY_MENTOR_APPLICATION_SUBMITTED') return web('/dashboard/company/mentors');

  switch (n.entityType) {
    case 'learning_circle':
      return id == null ? null : AppRoute(RoutePaths.learningCircleDetailPath(id));
    case 'company_admin_link':
      return web('/dashboard/company/admin');
    case 'company':
      return web(type.startsWith('COMPANY_DELEGATE_') ? '/dashboard/company/admin' : '/dashboard/company');
    case 'mentor_application':
      return const AppRoute(RoutePaths.home);
    case 'job':
      return web(id == null ? '/dashboard/company/jobs' : '/dashboard/company/jobs/${Uri.encodeComponent(id)}');
    case 'job_application':
      return web('/dashboard/jobs');
    case 'karma_activity_log':
      return const AppRoute(RoutePaths.profile);
    case 'media_content':
      return web('/dashboard/weekly-twitches');
  }
  return null;
}
