import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/auth/current_user_college.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/dashboard/presentation/providers/dashboard_controller.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';
import 'package:mulearn_app/features/profile/presentation/providers/profile_controller.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _profilePath = '/api/v1/dashboard/profile/user-profile/';

/// GET /dashboard/profile/user-profile/ runs get_rank on every call (PERF-01);
/// Profile, Home's summary, IG membership and the user's college all read it.
void main() {
  late TokenStorage tokens;
  late FakeHttpAdapter adapter;

  setUp(() async {
    tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    adapter = FakeHttpAdapter({'GET $_profilePath': (_) => FakeResponse(200, loadFixture('dev/user_profile'))});
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(container.dispose);
    return container;
  }

  int profileCalls() => adapter.requests.where((r) => r.path == _profilePath).length;

  test('four readers share one request', () async {
    final c = makeContainer();

    await Future.wait([
      c.read(profileControllerProvider.future),
      c.read(myProgressSummaryControllerProvider.future),
      c.read(myInterestGroupIdsProvider.future),
      c.read(currentUserCollegeProvider.future),
    ]);

    expect(profileCalls(), 1);
  });

  test('a profile mutation refreshes every reader', () async {
    final c = makeContainer()..listen(myProgressSummaryControllerProvider, (_, __) {});
    await c.read(myProgressSummaryControllerProvider.future);

    c.invalidate(myProfilePayloadProvider); // what a successful mutation does
    await c.read(myProgressSummaryControllerProvider.future);

    expect(profileCalls(), 2);
  });

  test('sign-out resets the shared profile', () async {
    final c = makeContainer()..listen(myProfilePayloadProvider, (_, __) {});
    await c.read(myProfilePayloadProvider.future);

    c.read(appAuthControllerProvider.notifier).setSignedOut();
    await Future<void>.delayed(Duration.zero);
    c.read(appAuthControllerProvider.notifier).setSignedIn();
    await c.read(myProfilePayloadProvider.future);

    expect(profileCalls(), 2);
  });

  test('a failed profile load shows as an error at once (no silent retry loop)', () async {
    adapter = FakeHttpAdapter({'GET $_profilePath': (_) => const FakeResponse(-1, null)});
    final c = makeContainer()..listen(profileControllerProvider, (_, __) {});

    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(c.read(profileControllerProvider).hasError, isTrue,
        reason: 'the Profile screen shows its error and Retry button instead of spinning');
  });
}
