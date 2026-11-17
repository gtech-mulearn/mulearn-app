import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/router/route_paths.dart';

import '../../support/fake_http_adapter.dart';
import 'team_test_support.dart';

Future<void> _settle(WidgetTester tester, [int frames = 8]) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Map<String, dynamic> _entry(
  String id,
  String action,
  String label, {
  String actor = 'Asha Nair',
  List<String> roles = const ['Admins'],
  String? title,
  int? audienceSize,
  String? audienceLabel,
  Map<String, Object?>? oldData,
  Map<String, Object?>? newData,
}) => {
  'id': id,
  'action': action,
  'label': label,
  'actor': {'full_name': actor, 'muid': 'a@mulearn'},
  'roles': roles,
  'title': title,
  'audience_size': audienceSize,
  'audience_label': audienceLabel,
  'created_at': '2026-11-18T06:00:00+00:00',
  'old_data': oldData,
  'new_data': newData,
};

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

void main() {
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
    expect(
      find.textContaining(
        'Asha Nair (Fellow + Associate) · Hack night · 1200 people',
        findRichText: true,
      ),
      findsOneWidget,
    );
    expect(find.text('3h ago'), findsOneWidget);
  });

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

    await tester.tap(find.textContaining('Asha Nair', findRichText: true));
    await _settle(tester);

    expect(
      find.textContaining('title: Old title → New title', findRichText: true),
      findsOneWidget,
    );
    expect(
      find.textContaining('items: [1,2] → [1,2,3]', findRichText: true),
      findsOneWidget,
    );
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
