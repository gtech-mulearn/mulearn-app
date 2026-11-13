import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _userInfo = 'GET /api/v1/dashboard/user/info/';
const _mentorStatus = 'GET /api/v1/dashboard/mentor/status/';

void main() {
  late TokenStorage tokens;

  setUp(() async {
    tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
  });

  ProviderContainer containerWith(FakeHttpAdapter adapter, {bool noRetry = false}) {
    final container = ProviderContainer(retry: noRetry ? (_, __) => null : null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  int callsTo(FakeHttpAdapter adapter, String path) =>
      adapter.requests.where((r) => r.path == path).length;

  test('a learner never calls mentor status', () async {
    final adapter = FakeHttpAdapter({
      _userInfo: (_) => FakeResponse(200, loadFixture('dev/user_info')),
    });
    final c = containerWith(adapter);

    final caps = await c.read(capabilitiesProvider.future);

    expect(caps!.isLearner, isTrue);
    expect(callsTo(adapter, '/api/v1/dashboard/mentor/status/'), 0);
  });

  test('a mentor whose application is approved is an approved mentor', () async {
    final c = containerWith(FakeHttpAdapter({
      _userInfo: (_) => FakeResponse(200, loadFixture('dev/user_info_mentor')),
      _mentorStatus: (_) => FakeResponse(200, loadFixture('dev/mentor_status')),
    }));

    final caps = await c.read(capabilitiesProvider.future);

    expect(caps!.isMentorApproved, isTrue);
  });

  test('"No mentor requests found" means no applications, not an error', () async {
    final c = containerWith(FakeHttpAdapter({
      _userInfo: (_) => FakeResponse(200, loadFixture('dev/user_info_mentor')),
      _mentorStatus: (_) => const FakeResponse(400, {
            'hasError': true,
            'statusCode': 400,
            'message': {'general': ['No mentor requests found for your account.']},
            'response': <String, dynamic>{},
          }),
    }));

    final caps = await c.read(capabilitiesProvider.future);

    expect(caps!.isMentor, isTrue);
    expect(caps.isMentorApproved, isFalse);
  });

  test('a failed mentor-status fetch is an error, not a downgrade', () async {
    final c = containerWith(noRetry: true, FakeHttpAdapter({
      _userInfo: (_) => FakeResponse(200, loadFixture('dev/user_info_mentor')),
      _mentorStatus: (_) => const FakeResponse(-1, null),
    }));

    // Riverpod 3 retries a failing provider by default (the app keeps that),
    // during which capabilities stays loading. With retries off, the failure
    // must surface as the error itself — never as a downgraded value.
    await expectLater(
      c.read(capabilitiesProvider.future),
      throwsA(isA<ApiException>().having((e) => e.kind, 'kind', ApiErrorKind.network)),
    );
  });

  test('a failed user-info fetch makes capabilities an error at once, not a long spinner', () async {
    final c = containerWith(FakeHttpAdapter({_userInfo: (_) => const FakeResponse(-1, null)}))
      ..listen(capabilitiesProvider, (_, __) {});

    await Future<void>.delayed(const Duration(milliseconds: 100));

    final state = c.read(capabilitiesProvider);
    expect(state.isLoading, isFalse);
    expect(state.error, isA<ApiException>());
  });

  test('currentUser refetches after an account switch', () async {
    var fixture = 'dev/user_info';
    final adapter = FakeHttpAdapter({_userInfo: (_) => FakeResponse(200, loadFixture(fixture))});
    final c = containerWith(adapter)..listen(currentUserProvider, (_, __) {});

    expect((await c.read(currentUserProvider.future))!.roles, ['Student']);

    c.read(appAuthControllerProvider.notifier).setSignedOut();
    expect(await c.read(currentUserProvider.future), isNull);

    fixture = 'dev/user_info_mentor';
    c.read(appAuthControllerProvider.notifier).setSignedIn();
    expect((await c.read(currentUserProvider.future))!.roles, ['Mentor']);
    expect(callsTo(adapter, '/api/v1/dashboard/user/info/'), 2);
  });

  test('signed out means no user and no request', () async {
    await tokens.clear();
    final adapter = FakeHttpAdapter({});
    final c = containerWith(adapter);

    expect(await c.read(currentUserProvider.future), isNull);
    expect(await c.read(capabilitiesProvider.future), isNull);
    expect(adapter.requests, isEmpty);
  });

  test('the Dio used is the app one (sanity)', () {
    expect(fakeDio(FakeHttpAdapter({})), isA<Dio>());
  });
}
