import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mulearn_app/core/utils/app_logger.dart';

/// Whether the system lets the app show notifications.
enum PushPermission { granted, denied, notDetermined }

/// A push the user tapped: its FCM data (route, type, entity, dedupe key).
class PushOpen {
  const PushOpen(this.data);

  final Map<String, String> data;

  String? get dedupeKey => _nonEmpty(data['dedupe_key']);

  /// An in-app path the server chose (engagement and campaigns).
  String? get route => _nonEmpty(data['route']);

  /// The notification fields activity pushes carry, so the app can route a
  /// tap exactly like a tap in the notification feed.
  String? get type => _nonEmpty(data['type']);
  String? get entityType => _nonEmpty(data['entity_type']);
  String? get entityId => _nonEmpty(data['entity_id']);
  String? get redirectUrl => _nonEmpty(data['redirect_url']);
  String get title => data['title'] ?? '';
  String get body => data['body'] ?? '';

  static String? _nonEmpty(String? v) =>
      v == null || v.trim().isEmpty ? null : v.trim();
}

/// The device side of push. [FirebasePushMessaging] in builds with Firebase
/// config; [NoopPushMessaging] otherwise, so every caller works either way.
abstract interface class PushMessaging {
  bool get available;
  Future<void> init();
  Future<PushPermission> permission();
  Future<PushPermission> requestPermission();
  Future<String?> token();
  Stream<String> get tokenRefresh;

  /// Taps on pushes while the app runs or from the background.
  Stream<PushOpen> get opens;

  /// The push that launched the app from a terminated state, once.
  Future<PushOpen?> takeInitialOpen();
  Future<void> deleteToken();
}

class NoopPushMessaging implements PushMessaging {
  const NoopPushMessaging();

  @override
  bool get available => false;
  @override
  Future<void> init() async {}
  @override
  Future<PushPermission> permission() async => PushPermission.denied;
  @override
  Future<PushPermission> requestPermission() async => PushPermission.denied;
  @override
  Future<String?> token() async => null;
  @override
  Stream<String> get tokenRefresh => const Stream.empty();
  @override
  Stream<PushOpen> get opens => const Stream.empty();
  @override
  Future<PushOpen?> takeInitialOpen() async => null;
  @override
  Future<void> deleteToken() async {}
}

/// The Android channel FCM and the app both post to (AndroidManifest
/// `default_notification_channel_id`).
const pushChannelId = 'mulearn_default';

class FirebasePushMessaging implements PushMessaging {
  FirebasePushMessaging({
    FirebaseMessaging? messaging,
    FlutterLocalNotificationsPlugin? local,
  }) : _messaging = messaging ?? FirebaseMessaging.instance,
       _local = local ?? FlutterLocalNotificationsPlugin();

  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _local;
  final _opens = StreamController<PushOpen>.broadcast();
  bool _initialised = false;
  int _nextId = 1;

  /// True when Firebase was initialised in bootstrap.
  static bool get firebaseReady => Firebase.apps.isNotEmpty;

  @override
  bool get available => true;

  @override
  Future<void> init() async {
    if (_initialised) return;
    _initialised = true;
    await _local.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings(
          '@drawable/ic_launcher_monochrome',
        ),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final open = _decode(response.payload);
        if (open != null) _opens.add(open);
      },
    );
    await _local
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(
          const AndroidNotificationChannel(
            pushChannelId,
            'μLearn',
            description: 'Circles, events, karma and reminders',
            importance: Importance.high,
          ),
        );
    // Foreground: FCM doesn't show a banner by itself, so post one locally.
    FirebaseMessaging.onMessage.listen(_showInForeground);
    // Background tap: FCM showed it; route when the user taps.
    FirebaseMessaging.onMessageOpenedApp.listen(
      (m) => _opens.add(_fromRemote(m)),
    );
  }

  Future<void> _showInForeground(RemoteMessage m) async {
    final n = m.notification;
    if (n == null) return;
    final payload = jsonEncode({
      ...m.data.map((k, v) => MapEntry(k, '$v')),
      'title': n.title ?? '',
      'body': n.body ?? '',
    });
    try {
      await _local.show(
        id: _nextId++,
        title: n.title,
        body: n.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            pushChannelId,
            'μLearn',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: payload,
      );
    } on Object catch (e, st) {
      appLogger.w(
        'push: could not show a foreground notification',
        error: e,
        stackTrace: st,
      );
    }
  }

  static PushOpen _fromRemote(RemoteMessage m) => PushOpen({
    ...m.data.map((k, v) => MapEntry(k, '$v')),
    'title': m.notification?.title ?? '',
    'body': m.notification?.body ?? '',
  });

  static PushOpen? _decode(String? payload) {
    if (payload == null || payload.isEmpty) return null;
    try {
      final map = jsonDecode(payload);
      if (map is! Map) return null;
      return PushOpen({for (final e in map.entries) '${e.key}': '${e.value}'});
    } on FormatException {
      return null;
    }
  }

  @override
  Future<PushPermission> permission() async =>
      _map((await _messaging.getNotificationSettings()).authorizationStatus);

  @override
  Future<PushPermission> requestPermission() async =>
      _map((await _messaging.requestPermission()).authorizationStatus);

  static PushPermission _map(AuthorizationStatus s) => switch (s) {
    AuthorizationStatus.authorized ||
    AuthorizationStatus.provisional => PushPermission.granted,
    AuthorizationStatus.denied ||
    AuthorizationStatus.deniedPermanently => PushPermission.denied,
    AuthorizationStatus.notDetermined => PushPermission.notDetermined,
  };

  // The token API is deprecated in firebase_messaging 17 in favour of
  // register()/onRegistered (Firebase Installation IDs for FCM direct send).
  // The backend sends to registration tokens (send_each_for_multicast), so
  // the app keeps tokens until both sides move together.
  @override
  // ignore: deprecated_member_use -- token API kept on purpose, see above.
  Future<String?> token() => _messaging.getToken();

  @override
  // ignore: deprecated_member_use -- token API kept on purpose, see above.
  Stream<String> get tokenRefresh => _messaging.onTokenRefresh;

  @override
  Stream<PushOpen> get opens => _opens.stream;

  @override
  Future<PushOpen?> takeInitialOpen() async {
    final remote = await _messaging.getInitialMessage();
    if (remote != null) return _fromRemote(remote);
    final launch = await _local.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      return _decode(launch!.notificationResponse?.payload);
    }
    return null;
  }

  @override
  // ignore: deprecated_member_use -- token API kept on purpose, see above.
  Future<void> deleteToken() => _messaging.deleteToken();
}
