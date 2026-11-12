import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _profilePath = '/api/v1/dashboard/profile/user-profile/';
const _igEdit = 'PATCH /api/v1/dashboard/profile/ig-edit/';

/// `ig-edit` replaces the whole membership list, so the list sent must be the
/// server's current one, not the copy cached when the session started.
void main() {
  test('joining or leaving starts from a fresh membership list, not the cached one', () async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final full = loadFixture('dev/user_profile');
    final groups = (full['response'] as Map<String, dynamic>)['interest_groups'] as List<dynamic>;
    final ids = [for (final g in groups) (g as Map<String, dynamic>)['id'] as String];
    // At session start the user had two groups; later they joined a third on
    // the web dashboard.
    final stale = {
      ...full,
      'response': {...full['response'] as Map<String, dynamic>, 'interest_groups': groups.take(2).toList()},
    };
    var profileCalls = 0;
    final adapter = FakeHttpAdapter({
      'GET $_profilePath': (_) => FakeResponse(200, profileCalls++ == 0 ? stale : full),
      _igEdit: (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': <String>[]},
            'response': <String, dynamic>{},
          }),
    });
    final c = ProviderContainer(overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(c.dispose);
    c.listen(myProfilePayloadProvider, (_, __) {});
    await c.read(myProfilePayloadProvider.future); // the session-start copy

    await c.read(interestGroupMembershipControllerProvider.notifier).toggle(ids[0], join: false);

    final patch = adapter.requests.singleWhere((r) => r.method == 'PATCH');
    expect(patch.data, {'interest_group': [ids[1], ids[2]]},
        reason: 'the group joined on the web must not be removed');
  });
}
