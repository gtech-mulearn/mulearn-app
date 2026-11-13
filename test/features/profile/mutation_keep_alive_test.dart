import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/profile/presentation/providers/college_change_controller.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _profile = '/api/v1/dashboard/profile/user-profile/';

/// Plan 2 minor 5: an action that refreshes shared state after its request
/// must finish that refresh even if its screen (and so its auto-dispose
/// controller) closed while the request was in flight.
void main() {
  test('a college change finishes its refresh after the sheet closes', () async {
    final adapter = FakeHttpAdapter({
      'GET $_profile': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
      'PATCH /api/v1/dashboard/college/change-college/': (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': ['College changed']},
            'response': <String, dynamic>{},
          }),
    });
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(c.dispose);
    c.listen(myProfilePayloadProvider, (_, __) {});
    await c.read(myProfilePayloadProvider.future);

    // The sheet listens to the controller, starts the change, then closes.
    final sheet = c.listen(changeCollegeControllerProvider, (_, __) {});
    final pending = c.read(changeCollegeControllerProvider.notifier).submit(orgId: 'o1', departmentId: 'd1');
    sheet.close();
    await Future<void>.delayed(Duration.zero);
    await pending;
    await c.read(myProfilePayloadProvider.future);

    final fetches = adapter.requests.where((RequestOptions r) => r.uri.path == _profile).length;
    expect(fetches, 2, reason: 'the shared profile was refetched after the change');
  });
}
