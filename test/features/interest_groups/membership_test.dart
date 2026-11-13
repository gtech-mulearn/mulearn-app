import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/my_profile_payload.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/interest_groups/presentation/providers/interest_groups_controller.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _profile = '/api/v1/dashboard/profile/user-profile/';

/// FEAT-08 — InterestGroupMembershipAPI (dash_ig_view.py:1243): POST
/// `<id>/join/` (cap 3), DELETE `<id>/leave/`. Unlike ig-edit, they never rewrite
/// the whole membership list.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_profile': (_) => FakeResponse(200, loadFixture('dev/user_profile')),
      'POST /api/v1/dashboard/ig/g4/join/': (_) => FakeResponse(400, loadFixture('dev/ig_join_cap')),
      'POST /api/v1/dashboard/ig/g1/join/': (_) => FakeResponse(200, loadFixture('dev/ig_join_ok')),
      'DELETE /api/v1/dashboard/ig/g1/leave/': (_) => FakeResponse(200, loadFixture('dev/ig_leave_ok')),
    });
  });

  Future<ProviderContainer> container() async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final c = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
    ]);
    addTearDown(c.dispose);
    c.listen(myProfilePayloadProvider, (_, __) {});
    await c.read(myProfilePayloadProvider.future);
    return c;
  }

  int profileFetches() => adapter.requests.where((RequestOptions r) => r.uri.path == _profile).length;

  test('join and leave use the dedicated endpoints, never ig-edit', () async {
    final c = await container();
    final membership = c.read(interestGroupMembershipControllerProvider.notifier);

    await membership.toggle('g1', join: true);
    await membership.toggle('g1', join: false);

    final calls = [for (final r in adapter.requests) '${r.method} ${r.uri.path}'];
    expect(calls, containsAllInOrder(['POST /api/v1/dashboard/ig/g1/join/', 'DELETE /api/v1/dashboard/ig/g1/leave/']));
    expect(calls.where((c) => c.contains('ig-edit')), isEmpty);
    expect(profileFetches(), greaterThan(1), reason: 'the shared profile refreshes after a change');
  });

  test('a raced fourth group shows the backend message', () async {
    final c = await container();

    await c.read(interestGroupMembershipControllerProvider.notifier).toggle('g4', join: true);

    final error = c.read(interestGroupMembershipControllerProvider).error;
    expect(error, isA<ApiException>().having((e) => e.message, 'message', 'Cannot join more than 3 interest groups'));
  });
}
