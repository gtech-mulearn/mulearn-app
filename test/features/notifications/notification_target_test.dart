import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/features/notifications/domain/entities/app_notification.dart';
import 'package:mulearn_app/features/notifications/domain/notification_target.dart';

/// Where a tapped notification leads. Mirrors the dashboard's
/// `notification-href.ts` (a safe redirect_url wins, then the typed link),
/// mapped to app routes where the app has the screen, to the web dashboard
/// otherwise.
void main() {
  final base = Uri.parse('https://mulearn-dashboard.vercel.app');

  AppNotification n({String? type, String? entityType, String? entityId, String? redirectUrl}) => AppNotification(
        id: 'x',
        title: 't',
        description: 'd',
        isBroadcast: type == null,
        read: false,
        createdAt: DateTime.utc(2026, 11, 13),
        type: type,
        entityType: entityType,
        entityId: entityId,
        redirectUrl: redirectUrl,
      );

  NotificationTarget target(AppNotification x) => notificationTarget(x, dashboardBase: base);

  group('redirect_url', () {
    test('dashboard paths the app has become app routes', () {
      expect(target(n(redirectUrl: '/dashboard/learning-circle/')), const AppRoute('/circles'));
      expect(target(n(redirectUrl: '/dashboard/learning-circle/c1')), const AppRoute('/circles/c1'));
      expect(target(n(redirectUrl: '/dashboard/events/e1')), const AppRoute('/events/e1'));
      expect(target(n(redirectUrl: '/dashboard/events')), const AppRoute('/events'));
      expect(target(n(redirectUrl: '/dashboard/profile')), const AppRoute('/profile'));
      expect(target(n(redirectUrl: 'https://mulearn-dashboard.vercel.app/dashboard/events/e2?x=1')),
          const AppRoute('/events/e2'));
    });

    test('other relative paths open on the web dashboard', () {
      expect(target(n(redirectUrl: '/dashboard/jobs')),
          WebPage(Uri.parse('https://mulearn-dashboard.vercel.app/dashboard/jobs')));
    });

    test('an https link elsewhere opens externally, like the dashboard', () {
      expect(target(n(redirectUrl: 'https://example.org/x')), WebPage(Uri.parse('https://example.org/x')));
    });
  });

  group('typed', () {
    test('circle notifications open the circle', () {
      expect(target(n(type: 'LC_INVITE', entityType: 'learning_circle', entityId: 'c9')), const AppRoute('/circles/c9'));
    });

    test('published and cancelled events open the public event page', () {
      // EVENT_PUBLISHED goes to everyone in the event's scope
      // (Audience.event_scope), not only its organiser.
      expect(target(n(type: 'EVENT_PUBLISHED', entityType: 'event', entityId: 'e9')), const AppRoute('/events/e9'));
      expect(target(n(type: 'EVENT_CANCELLED', entityType: 'event', entityId: 'e9')), const AppRoute('/events/e9'));
    });

    test('organiser-side event notices open the manage page on the web', () {
      expect(target(n(type: 'EVENT_APPROVAL_STAGE', entityType: 'event', entityId: 'e9')),
          WebPage(Uri.parse('https://mulearn-dashboard.vercel.app/dashboard/manage-events/e9')));
      expect(target(n(type: 'EVENT_COLLAB_INVITED', entityType: 'event', entityId: 'e9')),
          WebPage(Uri.parse('https://mulearn-dashboard.vercel.app/dashboard/manage-events/e9')));
    });

    test('karma notices open Profile; media content opens Weekly Twitches on the web', () {
      expect(target(n(type: 'KARMA_AWARDED', entityType: 'karma_activity_log', entityId: 'k')), const AppRoute('/profile'));
      expect(target(n(type: 'SALT_MANGO_TREE_ANNOUNCED', entityType: 'media_content', entityId: 'm')),
          WebPage(Uri.parse('https://mulearn-dashboard.vercel.app/dashboard/weekly-twitches')));
    });

    test('company and job notices open their web pages', () {
      expect(target(n(type: 'JOB_APPLICATION_STATUS', entityType: 'job_application', entityId: 'j')),
          WebPage(Uri.parse('https://mulearn-dashboard.vercel.app/dashboard/jobs')));
      expect(target(n(type: 'COMPANY_REJECTED', entityType: 'company', entityId: 'co')),
          WebPage(Uri.parse('https://mulearn-dashboard.vercel.app/dashboard/company/profile/edit')));
    });
  });

  test('unsafe or unknown targets open nothing', () {
    expect(target(n(redirectUrl: 'javascript:alert(1)')), const NoTarget());
    expect(target(n(redirectUrl: 'http://example.org/x')), const NoTarget());
    expect(target(n(redirectUrl: '//evil.example/x')), const NoTarget());
    expect(target(n(type: 'SOMETHING_NEW')), const NoTarget());
    expect(target(n(type: 'LC_INVITE', entityType: 'learning_circle')), const NoTarget(), reason: 'no id');
  });

  test('an unsafe redirect falls back to the typed link', () {
    expect(target(n(type: 'LC_INVITE', entityType: 'learning_circle', entityId: 'c1', redirectUrl: 'javascript:x')),
        const AppRoute('/circles/c1'));
  });
}
