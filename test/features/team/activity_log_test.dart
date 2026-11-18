import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/router/route_paths.dart';
import 'package:mulearn_app/core/utils/date_format.dart';
import 'package:mulearn_app/features/team/domain/entities/activity_entry.dart';
import 'package:mulearn_app/features/team/presentation/activity_labels.dart';

import '../../support/fake_http_adapter.dart';
import 'team_test_support.dart';

Future<void> _settle(WidgetTester tester, [int frames = 8]) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Finder _rich(String text) => find.textContaining(text, findRichText: true);

Map<String, dynamic> _entry(
  String id,
  String action,
  String label, {
  String actor = 'Asha Nair',
  List<String> roles = const ['Admins'],
  String? title,
  int? audienceSize,
  String? audienceLabel,
  String? entityName,
  String? entityId,
  Map<String, Object?>? campaign,
  Map<String, Object?>? oldData,
  Map<String, Object?>? newData,
}) => {
  'id': id,
  'action': action,
  'label': label,
  'actor': {'full_name': actor, 'muid': 'a@mulearn'},
  'roles': roles,
  'title': title,
  'entity_name': entityName,
  'entity_id': entityId,
  'campaign': campaign,
  'audience_size': audienceSize,
  'audience_label': audienceLabel,
  'created_at': '2026-11-18T06:00:00+00:00',
  'old_data': oldData,
  'new_data': newData,
};

Map<String, Object?> _liveCampaign() => {
  'status': 'sent',
  'target_count': 4120,
  'sent_count': 3900,
  'skipped_count': 150,
  'failed_count': 70,
};

Map<String, dynamic> _sendRow({Map<String, Object?>? campaign}) => _entry(
  'l1',
  'PUSH_CAMPAIGN_SEND',
  'Sent push campaign',
  title: 'Streak week',
  audienceSize: 4120,
  entityName: 'push_campaign',
  entityId: 'c1',
  campaign: campaign,
  newData: const {},
);

Map<String, dynamic> _page(
  List<Map<String, dynamic>> data, {
  bool next = false,
}) => okEnvelope({
  'data': data,
  'pagination': {
    'count': data.length,
    'totalPages': next ? 2 : 1,
    'isNext': next,
    'isPrev': false,
    'nextPage': next ? 2 : null,
  },
});

FakeResponse Function(RequestOptions) _ok(
  List<Map<String, dynamic>> data, {
  bool next = false,
}) =>
    (_) => FakeResponse(200, _page(data, next: next));

ActivityEntry _e({
  String action = 'NOTIF_BROADCAST_UPDATE',
  Map<String, Object?>? oldData,
  Map<String, Object?>? newData,
}) => ActivityEntry(
  id: 'l1',
  action: action,
  label: 'x',
  actorName: 'Asha Nair',
  actorMuid: 'a@mulearn',
  roles: const ['Admins'],
  createdAt: DateTime.utc(2026, 11, 18, 6),
  oldData: oldData,
  newData: newData,
);

void main() {
  group('what changed', () {
    test('a create lists Key: value with readable names', () {
      expect(
        activityChangeLines(
          _e(
            action: 'NOTIF_BROADCAST_CREATE',
            newData: {
              'title': 'Hack night',
              'description': 'Bring a laptop.',
              'url': '/events',
              'respect_quiet_hours': true,
            },
          ),
        ),
        [
          'Title: Hack night',
          'Message: Bring a laptop.',
          'Opens: /events',
          'Respect quiet hours: Yes',
        ],
      );
    });

    test('an update lists only what changed, before → after', () {
      expect(
        activityChangeLines(
          _e(
            oldData: {'title': 'A', 'redirect_url': null, 'same': 1},
            newData: {'title': 'B', 'redirect_url': '/tasks', 'same': 1},
          ),
        ),
        ['Title: A → B', 'Opens: — → /tasks'],
      );
    });

    test('a delete says Deleted and a time reads in local time', () {
      final when = DateTime.utc(2026, 11, 23, 9, 30);
      final lines = activityChangeLines(
        _e(
          action: 'NOTIF_BROADCAST_DELETE',
          oldData: {'title': 'Gone', 'expires_at': when.toIso8601String()},
          newData: const {},
        ),
      );
      expect(lines[0], 'Deleted: Title: Gone');
      expect(lines[1], 'Deleted: Expires at: ${formatDayTime(when.toLocal())}');
    });

    test('a test push reads its outcome', () {
      expect(
        activityChangeLines(
          _e(
            action: 'PUSH_TEST_SEND',
            newData: {
              'title': 'Test push',
              'outcome': {'sent': 2},
            },
          ),
        ),
        ['Title: Test push', 'Sent to 2 devices'],
      );
      expect(
        activityChangeLines(
          _e(
            action: 'PUSH_TEST_SEND',
            newData: {
              'outcome': {'error': 'not configured'},
            },
          ),
        ),
        ['No device'],
      );
    });

    test('nothing recorded gives no lines and long values are cut', () {
      expect(activityChangeLines(_e(newData: const {})), isEmpty);
      final lines = activityChangeLines(
        _e(action: 'PUSH_CONFIG_UPDATE', newData: {'blob': 'x' * 500}),
      );
      expect(lines.single.length, 'Blob: '.length + 160 + 1);
      expect(lines.single.endsWith('…'), isTrue);
    });
  });

  testWidgets('rows show the actor, roles, title and audience', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _entry(
          'l1',
          'NOTIF_BROADCAST_SEND',
          'Sent announcement to everyone',
          roles: ['Fellow', 'Associate'],
          title: 'Hack night',
          audienceSize: 1200,
        ),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    expect(find.text('Activity log'), findsWidgets);
    expect(find.text('Sent announcement to everyone'), findsWidgets);
    // Head counts carry thousands separators.
    expect(
      _rich('Asha Nair (Fellow + Associate) · Hack night · 1,200 people'),
      findsOneWidget,
    );
    expect(find.text('3h ago'), findsOneWidget);
  });

  testWidgets('a missing title reads as a dash and no roles leaves no "()"', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _entry(
          'l1',
          'PUSH_CONFIG_UPDATE',
          'Changed push settings',
          roles: const [],
        ),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    expect(_rich('Asha Nair · —'), findsOneWidget);
    expect(_rich('()'), findsNothing);
  });

  testWidgets('Admins reads as Admin', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _entry('l1', 'PUSH_TEST_SEND', 'Sent test push', title: 'Test push'),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    expect(_rich('Asha Nair (Admin) · Test push'), findsOneWidget);
    expect(_rich('Admins'), findsNothing);
  });

  testWidgets(
    'one person reads as 1 person, and a label stands in for a size',
    (tester) async {
      final adapter = teamAdapter({
        'GET ${TeamPaths.activityLog}': _ok([
          _entry('l1', 'PUSH_TEST_SEND', 'Sent test push', audienceSize: 1),
          _entry(
            'l2',
            'PUSH_CONFIG_UPDATE',
            'Changed push settings',
            audienceLabel: 'Everyone',
          ),
        ]),
      });
      await pumpTeam(tester, adapter, RoutePaths.teamLog);
      await _settle(tester);

      expect(_rich('· 1 person'), findsOneWidget);
      expect(_rich('— · Everyone'), findsOneWidget);
    },
  );

  testWidgets('choosing a chip requests that action from page 1', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _entry('l1', 'PUSH_CAMPAIGN_SEND', 'Sent push campaign'),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    final chip = find.text('Sent push campaign').first;
    await tester.ensureVisible(chip);
    await _settle(tester);
    await tester.tap(chip);
    await _settle(tester);

    final query = callsTo(
      adapter,
      'GET',
      TeamPaths.activityLog,
    ).last.uri.queryParameters;
    expect(query['action'], 'PUSH_CAMPAIGN_SEND');
    expect(query['pageIndex'], '1');
  });

  testWidgets('a row opens a sheet with before and after', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _entry(
          'l1',
          'NOTIF_BROADCAST_UPDATE',
          'Edited announcement',
          oldData: {
            'title': 'Old title',
            'items': [1, 2],
          },
          newData: {
            'title': 'New title',
            'items': [1, 2, 3],
          },
        ),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    await tester.tap(_rich('Asha Nair'));
    await _settle(tester);

    expect(_rich('Title: Old title → New title'), findsOneWidget);
    expect(_rich('Items: [1,2] → [1,2,3]'), findsOneWidget);
    expect(_rich('No details were recorded.'), findsNothing);
  });

  testWidgets('a campaign send opens with its live counts', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _sendRow(campaign: _liveCampaign()),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    await tester.tap(_rich('Asha Nair'));
    await _settle(tester);

    expect(find.widgetWithText(MuPill, 'Sent'), findsOneWidget);
    expect(find.text('4,120'), findsOneWidget);
    expect(find.text('3,900'), findsOneWidget);
    expect(find.text('150'), findsOneWidget);
    expect(find.text('70'), findsOneWidget);
    expect(find.text('Delivered'), findsOneWidget);
    expect(find.text('Skipped'), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
    expect(find.text('Streak week'), findsWidgets);
    expect(find.text('Asha Nair · a@mulearn · Admin'), findsOneWidget);
    expect(find.text('4,120 people'), findsOneWidget);
    expect(_rich('What changed'), findsNothing);
    expect(_rich('No details were recorded.'), findsNothing);
  });

  testWidgets('Open campaign closes the sheet and opens that campaign', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _sendRow(campaign: _liveCampaign()),
      ]),
      'GET ${TeamPaths.campaigns}': (_) =>
          FakeResponse(200, okEnvelope({'campaigns': <Object>[]})),
    });
    final router = await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);
    await tester.tap(_rich('Asha Nair'));
    await _settle(tester);

    await tester.tap(find.text('Open campaign'));
    await _settle(tester, 20);

    expect(
      router.routerDelegate.currentConfiguration.last.matchedLocation,
      RoutePaths.teamCampaignPath('c1'),
    );
    expect(find.text('Open campaign'), findsNothing);
  });

  testWidgets('a campaign that no longer exists says so and has no link', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([_sendRow()]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    await tester.tap(_rich('Asha Nair'));
    await _settle(tester);

    expect(find.text('This campaign no longer exists'), findsOneWidget);
    expect(find.text('Open campaign'), findsNothing);
  });

  testWidgets('the delete-all sheet lists a few titles, not JSON', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': _ok([
        _entry(
          'l1',
          'NOTIF_BROADCAST_DEL_ALL',
          'Deleted all announcements',
          title: '600 announcements',
          entityName: 'broadcast_notification',
          entityId: 'all',
          oldData: {
            'count': 600,
            'items': [
              for (var i = 1; i <= 8; i++)
                {'id': 'b$i', 'title': 'Title $i', 'target_type': 'global'},
            ],
            'truncated': true,
          },
          newData: const {},
        ),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    await tester.tap(_rich('Asha Nair'));
    await _settle(tester);

    expect(_rich('Deleted 600 announcements'), findsOneWidget);
    expect(_rich('• Title 1'), findsOneWidget);
    expect(_rich('• Title 5'), findsOneWidget);
    expect(_rich('Title 6'), findsNothing);
    expect(_rich('and 595 more'), findsOneWidget);
    expect(_rich('target_type'), findsNothing);
    expect(_rich('{'), findsNothing);
  });

  testWidgets('loading more requests pageIndex 2', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.activityLog}': (o) => FakeResponse(
        200,
        o.queryParameters['pageIndex'] == 1
            ? _page([
                for (var i = 0; i < 20; i++)
                  _entry('l$i', 'PUSH_TEST_SEND', 'Sent test push'),
              ], next: true)
            : _page([_entry('l99', 'PUSH_TEST_SEND', 'Sent test push')]),
      ),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    await tester.drag(find.byType(Scrollable).last, const Offset(0, -20000));
    await _settle(tester);

    final pages = [
      for (final r in callsTo(adapter, 'GET', TeamPaths.activityLog))
        r.uri.queryParameters['pageIndex'],
    ];
    expect(pages, contains('2'));
  });

  testWidgets('the empty state shows', (tester) async {
    final adapter = teamAdapter({'GET ${TeamPaths.activityLog}': _ok([])});
    await pumpTeam(tester, adapter, RoutePaths.teamLog);
    await _settle(tester);

    expect(find.text('Nothing logged yet'), findsOneWidget);
  });
}
