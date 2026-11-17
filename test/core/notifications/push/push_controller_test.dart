import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/config/app_version.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/notifications/push/push_controller.dart';
import 'package:mulearn_app/core/notifications/push/push_messaging.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../../support/fake_http_adapter.dart';
import '../../../support/fake_secure_storage.dart';

class FakeMessaging implements PushMessaging {
  FakeMessaging({
    this.status = PushPermission.granted,
    this.currentToken = 'tok-1',
  });

  PushPermission status;
  PushPermission answer = PushPermission.granted;
  String? currentToken;
  int deleted = 0;
  final refreshes = StreamController<String>.broadcast();

  @override
  bool get available => true;
  @override
  Future<void> init() async {}
  @override
  Future<PushPermission> permission() async => status;
  @override
  Future<PushPermission> requestPermission() async => status = answer;
  @override
  Future<String?> token() async => currentToken;
  @override
  Stream<String> get tokenRefresh => refreshes.stream;
  @override
  Stream<PushOpen> get opens => const Stream.empty();
  @override
  Future<PushOpen?> takeInitialOpen() async => null;
  @override
  Future<void> deleteToken() async {
    deleted++;
    currentToken = null;
  }
}

const _ok = FakeResponse(200, {
  'hasError': false,
  'statusCode': 200,
  'message': {'general': <String>[]},
  'response': <String, dynamic>{},
});

void main() {
  late FakeHttpAdapter adapter;
  late TokenStorage tokens;

  setUp(() async {
    adapter = FakeHttpAdapter({
      'POST /api/v1/push/devices/': (_) => _ok,
      'DELETE /api/v1/push/devices/': (_) => _ok,
    });
    tokens = TokenStorage(FakeSecureStorage());
  });

  Future<ProviderContainer> container(
    FakeMessaging messaging, {
    required bool signedIn,
  }) async {
    if (signedIn) await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(
      overrides: [
        pushMessagingProvider.overrideWithValue(messaging),
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        appVersionProvider.overrideWith(
          (ref) async => const AppVersion(name: '1.2.0', build: '12'),
        ),
      ],
    );
    addTearDown(c.dispose);
    await c.read(appAuthControllerProvider.future);
    return c;
  }

  List<String> calls() => [
    for (final r in adapter.requests) '${r.method} ${r.path}',
  ];

  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 20));

  test('signed in with permission: registers the token once', () async {
    final m = FakeMessaging();
    final c = await container(m, signedIn: true);
    expect(await c.read(pushControllerProvider.future), PushStatus.granted);
    await settle();
    await c.read(pushControllerProvider.notifier).sync();
    expect(calls(), ['POST /api/v1/push/devices/']);
    expect(adapter.requests.single.data, {
      'token': 'tok-1',
      'platform': 'android',
      'app_version': '1.2.0',
    });
  });

  test(
    'no permission yet: nothing is registered and nothing is asked',
    () async {
      final m = FakeMessaging(status: PushPermission.notDetermined);
      final c = await container(m, signedIn: true);
      expect(
        await c.read(pushControllerProvider.future),
        PushStatus.notDetermined,
      );
      await settle();
      expect(calls(), isEmpty);
    },
  );

  test('signed out: never registers', () async {
    final m = FakeMessaging();
    final c = await container(m, signedIn: false);
    await c.read(pushControllerProvider.future);
    await settle();
    expect(calls(), isEmpty);
  });

  test('granting permission from the tile registers right away', () async {
    final m = FakeMessaging(status: PushPermission.notDetermined);
    final c = await container(m, signedIn: true);
    await c.read(pushControllerProvider.future);
    final status = await c
        .read(pushControllerProvider.notifier)
        .requestPermission();
    expect(status, PushStatus.granted);
    expect(c.read(pushControllerProvider).value, PushStatus.granted);
    expect(calls(), ['POST /api/v1/push/devices/']);
  });

  test('a declined prompt leaves pushes off', () async {
    final m = FakeMessaging(status: PushPermission.notDetermined)
      ..answer = PushPermission.denied;
    final c = await container(m, signedIn: true);
    await c.read(pushControllerProvider.future);
    expect(
      await c.read(pushControllerProvider.notifier).requestPermission(),
      PushStatus.denied,
    );
    expect(calls(), isEmpty);
  });

  test('a rotated token is registered again', () async {
    final m = FakeMessaging();
    final c = await container(m, signedIn: true);
    await c.read(pushControllerProvider.future);
    await settle();
    m
      ..currentToken = 'tok-2'
      ..refreshes.add('tok-2');
    await settle();
    expect(adapter.requests.map((r) => (r.data as Map)['token']), [
      'tok-1',
      'tok-2',
    ]);
  });

  test('sign-out unregisters on the server and drops the FCM token', () async {
    final m = FakeMessaging();
    final c = await container(m, signedIn: true);
    await c.read(pushControllerProvider.future);
    await settle();
    await c.read(pushControllerProvider.notifier).unregisterForSignOut();
    expect(calls().last, 'DELETE /api/v1/push/devices/');
    expect(adapter.requests.last.data, {'token': 'tok-1'});
    expect(m.deleted, 1);
  });

  test('unavailable without Firebase: every call is a no-op', () async {
    final c = ProviderContainer(
      overrides: [
        pushMessagingProvider.overrideWithValue(const NoopPushMessaging()),
      ],
    );
    addTearDown(c.dispose);
    expect(await c.read(pushControllerProvider.future), PushStatus.unavailable);
    await c.read(pushControllerProvider.notifier).unregisterForSignOut();
    expect(
      await c.read(pushControllerProvider.notifier).requestPermission(),
      PushStatus.unavailable,
    );
  });
}
