import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/learning_circles/data/datasources/learning_circles_remote_datasource.dart';
import 'package:mulearn_app/features/learning_circles/data/repositories/learning_circles_repository_impl.dart';
import 'package:mulearn_app/features/learning_circles/presentation/providers/learning_circles_controller.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';

const _myInvites = 'GET /api/v1/dashboard/learningcircle/invite/status/';

LearningCirclesRepositoryImpl repoWith(FakeHttpAdapter adapter) =>
    LearningCirclesRepositoryImpl(LearningCirclesRemoteDataSource(fakeDio(adapter)));

void main() {
  test('my pending invites parse the invitee-side shape', () async {
    final repo = repoWith(FakeHttpAdapter({
      _myInvites: (_) => FakeResponse(200, loadFixture('serializer/my_invites')),
    }));

    final invites = await repo.getMyPendingInvites();

    expect(invites, hasLength(2));
    expect(invites[0].linkId, 'l1');
    expect(invites[0].circleTitle, 'Flutter Study Group');
    expect(invites[0].igName, 'Mobile Development');
    expect(invites[0].invitedByName, 'Fixture User');
    expect(invites[0].isLeadInvite, isFalse);
    expect(invites[1].invitedByName, isNull);
    expect(invites[1].isLeadInvite, isTrue);
  });

  test('parses the pending invites recorded live on dev', () async {
    final repo = repoWith(FakeHttpAdapter({
      _myInvites: (_) => FakeResponse(200, loadFixture('dev/my_invites')),
    }));

    final invites = await repo.getMyPendingInvites();

    expect(invites, hasLength(2));
    expect(invites.map((i) => i.circleTitle), everyElement(isNotEmpty));
    expect(invites.where((i) => i.isLeadInvite), hasLength(1));
    expect(invites.map((i) => i.invitedByName), everyElement(isNotNull));
  });

  test('accepting sends action=accept to the invite link', () async {
    final adapter = FakeHttpAdapter({
      'POST /api/v1/dashboard/learningcircle/invite/status/l1/': (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': ['Invitation accepted successfully']},
            'response': <String, dynamic>{},
          }),
    });

    await repoWith(adapter).respondToInvite('l1', accept: true);

    expect(adapter.requests.single.data, {'action': 'accept'});
  });

  test('declining sends action=reject', () async {
    final adapter = FakeHttpAdapter({
      'POST /api/v1/dashboard/learningcircle/invite/status/l1/': (_) => const FakeResponse(200, {
            'hasError': false,
            'statusCode': 200,
            'message': {'general': ['Invitation rejected successfully']},
            'response': <String, dynamic>{},
          }),
    });

    await repoWith(adapter).respondToInvite('l1', accept: false);

    expect(adapter.requests.single.data, {'action': 'reject'});
  });

  test('already responded message surfaces', () async {
    final container = ProviderContainer(overrides: [
      learningCirclesRepositoryProvider.overrideWithValue(repoWith(FakeHttpAdapter({
        'POST /api/v1/dashboard/learningcircle/invite/status/l1/': (_) => const FakeResponse(400, {
              'hasError': true,
              'statusCode': 400,
              'message': {'general': ['This invitation has already been responded to']},
              'response': <String, dynamic>{},
            }),
      }))),
    ]);
    addTearDown(container.dispose);
    // The Circles screen watches this provider; keep it alive the same way.
    container.listen(circleActionsControllerProvider, (_, __) {});

    await container
        .read(circleActionsControllerProvider.notifier)
        .respondToInvite('l1', accept: true);

    final error = container.read(circleActionsControllerProvider).error;
    expect(error, isA<ApiException>());
    expect((error! as ApiException).message, 'This invitation has already been responded to');
  });
}
