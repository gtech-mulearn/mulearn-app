import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/config/flavor_config.dart';
import 'package:mulearn_app/core/notifications/push/push_messaging.dart';
import 'package:mulearn_app/core/notifications/push/push_preferences.dart';
import 'package:mulearn_app/features/notifications/domain/notification_target.dart';
import 'package:mulearn_app/features/notifications/domain/push_target.dart';

void main() {
  final base = Uri.parse('https://mulearn-dashboard.vercel.app');

  NotificationTarget target(Map<String, String> data) =>
      pushTarget(PushOpen(data), dashboardBase: base);

  group('pushTarget', () {
    test('a server-chosen route wins (nudges, campaigns)', () {
      expect(
        target({'route': '/meetings/m1', 'type': 'LC_INVITE'}),
        const AppRoute('/meetings/m1'),
      );
    });

    test('a non-app route is ignored', () {
      expect(target({'route': '//evil.example/x'}), const NoTarget());
      expect(target({'route': 'https://x.test'}), const NoTarget());
    });

    test('an activity push routes like the notification feed', () {
      expect(
        target({
          'type': 'LC_JOIN_APPROVED',
          'entity_type': 'learning_circle',
          'entity_id': 'c9',
        }),
        const AppRoute('/circles/c9'),
      );
      expect(
        target({'type': 'JOB_APPLICATION_STATUS'}),
        const AppRoute('/opportunities'),
      );
    });

    test('empty strings from FCM count as missing', () {
      expect(
        target({'route': '', 'type': '', 'redirect_url': ''}),
        const NoTarget(),
      );
    });
  });

  group('PushPreferences.fromJson', () {
    test('reads stored values and falls back on bad ones', () {
      final p = PushPreferences.fromJson({
        'push_enabled': false,
        'engagement_enabled': true,
        'muted_categories': ['KARMA', 3, 'LC'],
        'quiet_start': 23,
        'quiet_end': 99,
        'timezone': 'Asia/Dubai',
      });
      expect(p.pushEnabled, isFalse);
      expect(p.mutedCategories, ['KARMA', 'LC']);
      expect((p.quietStart, p.quietEnd), (23, 8));
      expect(p.timezone, 'Asia/Dubai');
    });

    test('an empty payload means the defaults', () {
      final p = PushPreferences.fromJson(const {});
      expect(
        (p.pushEnabled, p.engagementEnabled, p.quietStart, p.quietEnd),
        (true, true, 22, 8),
      );
    });
  });

  test('firebaseOptionsFrom needs every value', () {
    expect(
      firebaseOptionsFrom(
        apiKey: 'k',
        appId: 'a',
        senderId: '',
        projectId: 'p',
      ),
      isNull,
    );
    final o = firebaseOptionsFrom(
      apiKey: 'k',
      appId: 'a',
      senderId: 's',
      projectId: 'p',
    );
    expect(o?.projectId, 'p');
    expect(o?.messagingSenderId, 's');
  });
}
