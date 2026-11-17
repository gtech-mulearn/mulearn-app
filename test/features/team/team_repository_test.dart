import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/team/domain/entities/announcement.dart';
import 'package:mulearn_app/features/team/domain/entities/campaign_draft.dart';
import 'package:mulearn_app/features/team/domain/entities/push_campaign.dart';
import 'package:mulearn_app/features/team/domain/repositories/team_repository.dart';
import 'package:mulearn_app/features/team/presentation/providers/team_repository_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'team_test_support.dart';

TeamRepository repoFor(FakeHttpAdapter adapter) {
  final container = ProviderContainer(
    overrides: [dioProvider.overrideWithValue(fakeDio(adapter))],
  );
  addTearDown(container.dispose);
  return container.read(teamRepositoryProvider);
}

const _broadcasts = '$teamBase/notification/broadcast/list/all/';
const _campaigns = '$teamBase/push/admin/campaigns/';
const _activity = '$teamBase/notification/activity-log/';
const _colleges = '$teamBase/dashboard/organisation/institutes/college/';

void main() {
  test(
    'announcements: total from count, source mapped, unknown is system',
    () async {
      final adapter = teamAdapter({
        'GET $_broadcasts': (_) =>
            FakeResponse(200, loadFixture('serializer/team_broadcasts_page')),
      });
      final page = await repoFor(adapter).announcements(1);
      expect(page.total, 45);
      expect(page.hasNext, isTrue);
      expect(page.items, hasLength(2));
      expect(page.items[0].source, AnnouncementSource.team);
      expect(page.items[0].targetName, 'Global (All Users)');
      expect(page.items[0].createdByName, 'Asha Nair');
      expect(page.items[0].expiresAt, DateTime.utc(2026, 11, 23, 9, 30));
      expect(page.items[1].source, AnnouncementSource.system);
      expect(page.items[1].url, isNull);
      final query = callsTo(
        adapter,
        'GET',
        _broadcasts,
      ).single.uri.queryParameters;
      expect(query, {'page': '1', 'page_size': '20'});
    },
  );

  test('createCampaign posts the audience and a UTC scheduled_at', () async {
    final first =
        ((loadFixture('serializer/team_campaigns')['response']
                as Map)['campaigns']
            as List)[0];
    final adapter = teamAdapter({
      'POST $_campaigns': (_) =>
          FakeResponse(200, okEnvelope(first, message: 'Campaign saved.')),
    });
    final created = await repoFor(adapter).createCampaign(
      CampaignDraft(
        title: 'Streak week',
        body: 'Seven days in a row earns a badge.',
        route: '/tasks',
        audienceType: AudienceType.roles,
        audienceIds: const ['Mentor', 'Student'],
        scheduledAt: DateTime.utc(2026, 11, 20, 4, 30),
      ),
    );
    final sent = callsTo(adapter, 'POST', _campaigns).single.data as Map;
    expect(sent, {
      'title': 'Streak week',
      'body': 'Seven days in a row earns a badge.',
      'route': '/tasks',
      'audience': {
        'type': 'roles',
        'ids': ['Mentor', 'Student'],
      },
      'scheduled_at': '2026-11-20T04:30:00.000Z',
      'respect_quiet_hours': true,
    });
    expect(created.status, CampaignStatus.scheduled);
    expect(created.audienceType, AudienceType.roles);
    expect(created.audienceIds, ['Mentor', 'Student']);
    expect(created.targetCount, 1200);
  });

  test('campaigns parses the list and nullable fields', () async {
    final adapter = teamAdapter({
      'GET $_campaigns': (_) =>
          FakeResponse(200, loadFixture('serializer/team_campaigns')),
    });
    final list = await repoFor(adapter).campaigns();
    expect(list, hasLength(2));
    expect(list[1].status, CampaignStatus.sent);
    expect(list[1].audienceType, AudienceType.all);
    expect(list[1].route, isNull);
    expect(list[1].scheduledAt, isNull);
    expect(list[1].sentAt, DateTime.utc(2026, 11, 10, 8, 5));
    expect(list[1].createdBy, isNull);
    expect(list[1].respectQuietHours, isFalse);
  });

  test('campaignAction hits the send path', () async {
    final adapter = teamAdapter({
      'POST ${_campaigns}c1/send/': (_) => FakeResponse(
        200,
        okEnvelope({'status': 'sending'}, message: 'Sending started.'),
      ),
    });
    await repoFor(adapter).campaignAction('c1', CampaignAction.send);
    expect(callsTo(adapter, 'POST', '${_campaigns}c1/send/'), hasLength(1));
  });

  test('sendTestPush returns the success message', () async {
    final adapter = teamAdapter({
      'POST $teamBase/push/admin/test/': (_) => FakeResponse(
        200,
        okEnvelope({}, message: 'Test push sent to your devices.'),
      ),
    });
    expect(
      await repoFor(adapter).sendTestPush(),
      'Test push sent to your devices.',
    );
  });

  test('sendTestPush failure throws ApiException with the message', () async {
    final adapter = teamAdapter({
      'POST $teamBase/push/admin/test/': (_) =>
          FakeResponse(400, failure('Push is not configured on this server.')),
    });
    await expectLater(
      repoFor(adapter).sendTestPush(),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'Push is not configured on this server.',
        ),
      ),
    );
  });

  test('sendTestPush with hasError on a 200 also throws', () async {
    final adapter = teamAdapter({
      'POST $teamBase/push/admin/test/': (_) =>
          FakeResponse(200, failure('No push was sent.')),
    });
    await expectLater(
      repoFor(adapter).sendTestPush(),
      throwsA(
        isA<ApiException>().having(
          (e) => e.message,
          'message',
          'No push was sent.',
        ),
      ),
    );
  });

  test('activity sends pageIndex, perPage and action', () async {
    final adapter = teamAdapter({
      'GET $_activity': (_) =>
          FakeResponse(200, loadFixture('serializer/team_activity_page')),
    });
    final page = await repoFor(
      adapter,
    ).activity(2, action: 'PUSH_CAMPAIGN_SEND');
    final query = callsTo(adapter, 'GET', _activity).single.uri.queryParameters;
    expect(query, {
      'pageIndex': '2',
      'perPage': '20',
      'action': 'PUSH_CAMPAIGN_SEND',
    });
    expect(page.hasNext, isTrue);
    expect(page.items, hasLength(2));
    expect(page.items[0].actorName, 'Asha Nair');
    expect(page.items[0].actorMuid, 'asha@mulearn');
    expect(page.items[0].roles, ['Admins']);
    expect(page.items[0].audienceSize, 1200);
    expect(page.items[0].createdAt, DateTime.utc(2026, 11, 17, 10, 5));
    expect(page.items[1].title, '600 announcements');
    expect(page.items[1].oldData, {'count': 600, 'truncated': true});
  });

  test('activity without an action omits the filter', () async {
    final adapter = teamAdapter({
      'GET $_activity': (_) =>
          FakeResponse(200, loadFixture('serializer/team_activity_page')),
    });
    await repoFor(adapter).activity(1);
    final query = callsTo(adapter, 'GET', _activity).single.uri.queryParameters;
    expect(query.containsKey('action'), isFalse);
  });

  test('searchColleges under 2 characters makes no request', () async {
    final adapter = teamAdapter();
    expect(await repoFor(adapter).searchColleges('a'), isEmpty);
    expect(adapter.requests, isEmpty);
  });

  test('searchColleges queries search and perPage', () async {
    final adapter = teamAdapter({
      'GET $_colleges': (_) => FakeResponse(
        200,
        okEnvelope({
          'data': [
            {
              'id': 'o1',
              'title': 'College of Engineering Trivandrum',
              'code': 'CET',
            },
          ],
        }),
      ),
    });
    final colleges = await repoFor(adapter).searchColleges('Engin');
    expect(colleges.single.id, 'o1');
    expect(colleges.single.title, 'College of Engineering Trivandrum');
    final query = callsTo(adapter, 'GET', _colleges).single.uri.queryParameters;
    expect(query, {'search': 'Engin', 'perPage': '20'});
  });

  test('interestGroups maps name to title', () async {
    final adapter = teamAdapter({
      'GET $teamBase/dashboard/ig/list/': (_) => FakeResponse(
        200,
        okEnvelope({
          'interestGroup': [
            {'id': 'ig1', 'name': 'Web Development', 'members': 10},
          ],
        }),
      ),
    });
    final igs = await repoFor(adapter).interestGroups();
    expect(igs.single.id, 'ig1');
    expect(igs.single.title, 'Web Development');
  });

  test('roles maps id and title', () async {
    final adapter = teamAdapter({
      'GET $teamBase/register/role/list/': (_) => FakeResponse(
        200,
        okEnvelope({
          'roles': [
            {'id': 'r1', 'title': 'Mentor'},
          ],
        }),
      ),
    });
    final roles = await repoFor(adapter).roles();
    expect(roles.single.title, 'Mentor');
  });

  test('announcement writes use the broadcast paths', () async {
    final row =
        ((loadFixture('serializer/team_broadcasts_page')['response']
                as Map)['results']
            as List)[0];
    final adapter = teamAdapter({
      'POST $teamBase/notification/admin/broadcast/': (_) => FakeResponse(
        200,
        okEnvelope({}, message: 'Broadcast dispatched successfully.'),
      ),
      'DELETE $teamBase/notification/broadcast/delete/id/b1/': (_) =>
          FakeResponse(200, okEnvelope({})),
      'DELETE $teamBase/notification/broadcast/delete/all/': (_) =>
          FakeResponse(200, okEnvelope({})),
      'PATCH $teamBase/notification/broadcast/update/id/b1/': (_) =>
          FakeResponse(200, okEnvelope(row)),
    });
    final repo = repoFor(adapter);
    await repo.sendToEveryone(
      title: 'Hi',
      description: 'There',
      redirectUrl: '/events',
      expiresInDays: 3,
    );
    expect(
      callsTo(
        adapter,
        'POST',
        '$teamBase/notification/admin/broadcast/',
      ).single.data,
      {
        'title': 'Hi',
        'description': 'There',
        'redirect_url': '/events',
        'expires_in_days': 3,
      },
    );
    final updated = await repo.updateAnnouncement(
      'b1',
      title: 'New',
      expiresAt: DateTime.utc(2026, 12),
    );
    expect(
      callsTo(
        adapter,
        'PATCH',
        '$teamBase/notification/broadcast/update/id/b1/',
      ).single.data,
      {'title': 'New', 'expires_at': '2026-12-01T00:00:00.000Z'},
    );
    expect(updated.id, 'b1000000-0000-4000-8000-000000000001');
    await repo.deleteAnnouncement('b1');
    await repo.deleteAllAnnouncements();
    expect(adapter.requests.where((r) => r.method == 'DELETE'), hasLength(2));
  });
}
