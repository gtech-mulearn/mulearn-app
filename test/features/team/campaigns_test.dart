import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/router/route_paths.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'team_test_support.dart';

Future<void> _settle(WidgetTester tester, [int frames = 8]) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Finder _rich(String text) => find.textContaining(text, findRichText: true);

Map<String, dynamic> _campaign({
  String id = 'c-new',
  String title = 'Hello',
  String status = 'draft',
  int targetCount = 4120,
  String? scheduledAt,
  Map<String, dynamic> audience = const {'type': 'all', 'ids': <String>[]},
}) => {
  'id': id,
  'title': title,
  'body': 'A short message.',
  'route': null,
  'audience': audience,
  'status': status,
  'scheduled_at': scheduledAt,
  'respect_quiet_hours': true,
  'target_count': targetCount,
  'sent_count': 0,
  'skipped_count': 0,
  'failed_count': 0,
  'created_at': '2026-11-18T08:00:00Z',
  'sent_at': null,
  'created_by': 'Asha Nair',
};

FakeResponse _list(List<Map<String, dynamic>> rows) =>
    FakeResponse(200, okEnvelope({'campaigns': rows}));

Map<String, FakeResponse Function(RequestOptions)> _options() => {
  'GET ${TeamPaths.roles}': (_) => FakeResponse(
    200,
    okEnvelope({
      'roles': [
        {'id': 'r1', 'title': 'Student'},
        {'id': 'r2', 'title': 'Mentor'},
        {'id': 'r3', 'title': 'Enabler'},
      ],
    }),
  ),
  'GET ${TeamPaths.interestGroups}': (_) => FakeResponse(
    200,
    okEnvelope({
      'interestGroup': [
        {'id': 'ig1', 'name': 'Web'},
      ],
    }),
  ),
};

Future<void> _fillBasics(WidgetTester tester) async {
  await tester.enterText(find.byType(TextField).at(0), 'Hello');
  await tester.enterText(find.byType(TextField).at(1), 'A short message.');
  await _settle(tester, 2);
}

void main() {
  testWidgets('the list shows status pills, the audience and phone counts', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) =>
          FakeResponse(200, loadFixture('serializer/team_campaigns')),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaigns);

    expect(find.text('Push campaigns'), findsOneWidget);
    expect(_rich('Streak week'), findsOneWidget);
    expect(
      _rich('Mentor, Student · ~1,200 phones · Asha Nair'),
      findsOneWidget,
    );
    expect(_rich('Everyone · ~5,000 phones · —'), findsOneWidget);
    expect(find.widgetWithText(MuPill, 'Scheduled'), findsOneWidget);
    expect(find.widgetWithText(MuPill, 'Sent'), findsOneWidget);
  });

  testWidgets('a scheduled campaign shows when it goes out, not Just now', (
    tester,
  ) async {
    final now = teamTestNow.toLocal();
    final tomorrow6pm = DateTime(now.year, now.month, now.day + 1, 18);
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) => _list([
        _campaign(
          status: 'scheduled',
          scheduledAt: tomorrow6pm.toUtc().toIso8601String(),
        ),
      ]),
    });
    final router = await pumpTeam(tester, adapter, RoutePaths.teamCampaigns);

    expect(find.text('Tomorrow · 6:00 PM'), findsOneWidget);
    expect(find.text('Just now'), findsNothing);

    unawaited(router.push(RoutePaths.teamCampaignPath('c-new')));
    await _settle(tester, 12);
    expect(find.text('Tomorrow · 6:00 PM'), findsWidgets);
  });

  testWidgets('a type the app does not know reads as a custom audience', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) => _list([
        _campaign(
          audience: {
            'type': 'cohort',
            'ids': <String>['x'],
          },
        ),
      ]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaigns);

    expect(_rich('Custom audience · ~4,120 phones'), findsOneWidget);
    expect(_rich('Everyone'), findsNothing);
  });

  testWidgets('a row opens the campaign', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) =>
          FakeResponse(200, loadFixture('serializer/team_campaigns')),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaigns);

    await tester.tap(_rich('Streak week'));
    await _settle(tester, 12);

    expect(find.text('Send now'), findsOneWidget);
    expect(find.text('Cancel campaign'), findsOneWidget);
  });

  testWidgets('roles are sent as titles', (tester) async {
    final adapter = teamAdapter({
      ..._options(),
      'POST ${TeamPaths.campaigns}': (_) => FakeResponse(
        200,
        okEnvelope(_campaign(), message: 'Campaign saved.'),
      ),
      'GET ${TeamPaths.campaigns}': (_) => _list([_campaign()]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignNew);

    await _fillBasics(tester);
    await tester.tap(find.text('Roles'));
    await _settle(tester);
    await tester.tap(find.text('Student'));
    await tester.pump();
    await tester.tap(find.text('Mentor'));
    await tester.pump();
    await tester.tap(find.text('Save'));
    await _settle(tester, 14);

    final sent =
        callsTo(adapter, 'POST', TeamPaths.campaigns).single.data as Map;
    expect(sent['audience'], {
      'type': 'roles',
      'ids': ['Student', 'Mentor'],
    });
    expect(sent['title'], 'Hello');
    expect(sent['body'], 'A short message.');
    expect(sent['route'], isNull);
    expect(sent['respect_quiet_hours'], isTrue);
    // Lands on the new campaign.
    expect(find.text('Send now'), findsOneWidget);
  });

  testWidgets('college search asks only from 2 characters', (tester) async {
    final adapter = teamAdapter({
      ..._options(),
      'GET ${TeamPaths.colleges}': (_) => FakeResponse(
        200,
        okEnvelope({
          'data': [
            {'id': 'col1', 'title': 'Amrita School'},
          ],
        }),
      ),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignNew);

    await tester.tap(find.text('Colleges'));
    await _settle(tester);
    await tester.tap(find.text('Search colleges'));
    await _settle(tester, 12);
    final search = find.descendant(
      of: find.byType(MuSearchField),
      matching: find.byType(TextField),
    );
    await tester.enterText(search, 'a');
    await tester.pump(const Duration(milliseconds: 600));
    await _settle(tester, 2);
    expect(callsTo(adapter, 'GET', TeamPaths.colleges), isEmpty);

    await tester.enterText(search, 'am');
    await tester.pump(const Duration(milliseconds: 600));
    await _settle(tester, 4);
    final calls = callsTo(adapter, 'GET', TeamPaths.colleges);
    expect(calls, hasLength(1));
    expect(calls.single.queryParameters['search'], 'am');

    await tester.tap(find.text('Amrita School'));
    await _settle(tester, 12);
    // The pick is a removable chip.
    expect(find.text('Amrita School'), findsOneWidget);
    expect(find.byTooltip('Remove Amrita School'), findsOneWidget);
    // The remove button is a full touch target.
    final size = tester.getSize(find.byTooltip('Remove Amrita School'));
    expect(size.width, greaterThanOrEqualTo(MuSizes.touchMin));
    expect(size.height, greaterThanOrEqualTo(MuSizes.touchMin));
  });

  testWidgets('Send now confirms with the phone count, then posts', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) => _list([_campaign()]),
      'POST ${TeamPaths.campaignAction('c-new', 'send')}': (_) =>
          FakeResponse(200, okEnvelope(null, message: 'Sending.')),
    });
    final router = await pumpTeam(
      tester,
      adapter,
      RoutePaths.teamCampaignPath('c-new'),
    );

    await tester.tap(find.text('Send now'));
    await _settle(tester, 12);

    expect(find.text('This goes to 4,120 phones.'), findsOneWidget);
    expect(
      callsTo(adapter, 'POST', TeamPaths.campaignAction('c-new', 'send')),
      isEmpty,
    );

    await tester.tap(find.text('Send'));
    await _settle(tester, 12);

    expect(
      callsTo(adapter, 'POST', TeamPaths.campaignAction('c-new', 'send')),
      hasLength(1),
    );
    router.go(RoutePaths.team);
    await _settle(tester);
  });

  testWidgets(
    'Send now on a scheduled campaign says it replaces the schedule',
    (tester) async {
      final adapter = teamAdapter({
        'GET ${TeamPaths.campaigns}': (_) => _list([
          _campaign(status: 'scheduled', scheduledAt: '2026-11-25T10:00:00Z'),
        ]),
      });
      await pumpTeam(tester, adapter, RoutePaths.teamCampaignPath('c-new'));

      await tester.tap(find.text('Send now'));
      await _settle(tester, 12);

      expect(
        find.text('This goes to 4,120 phones. It replaces the schedule.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('Send now says 1 phone, not 1 phones', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) => _list([_campaign(targetCount: 1)]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignPath('c-new'));

    await tester.tap(find.text('Send now'));
    await _settle(tester, 12);

    expect(find.text('This goes to 1 phone.'), findsOneWidget);
  });

  testWidgets('Cancel campaign confirms, then posts', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) =>
          _list([_campaign(status: 'sending')]),
      'POST ${TeamPaths.campaignAction('c-new', 'cancel')}': (_) =>
          FakeResponse(200, okEnvelope(null)),
    });
    final router = await pumpTeam(
      tester,
      adapter,
      RoutePaths.teamCampaignPath('c-new'),
    );
    expect(find.text('Send now'), findsNothing);

    await tester.tap(find.text('Cancel campaign'));
    await _settle(tester, 12);
    expect(
      callsTo(adapter, 'POST', TeamPaths.campaignAction('c-new', 'cancel')),
      isEmpty,
    );
    await tester.tap(find.text('Yes, cancel it'));
    await _settle(tester, 12);

    expect(
      callsTo(adapter, 'POST', TeamPaths.campaignAction('c-new', 'cancel')),
      hasLength(1),
    );
    router.go(RoutePaths.team);
    await _settle(tester);
  });

  testWidgets('a path starting with // is not an app path', (tester) async {
    final adapter = teamAdapter({..._options()});
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignNew);

    await _fillBasics(tester);
    await tester.tap(find.text('Just open the app'));
    await _settle(tester);
    await tester.tap(find.text('Another app path…').last);
    await _settle(tester, 12);
    await tester.enterText(find.byType(TextField).at(2), '//evil.example');
    await tester.tap(find.text('Save'));
    await _settle(tester);

    expect(
      find.text('Start the path with a single /, like /events.'),
      findsOneWidget,
    );
    expect(callsTo(adapter, 'POST', TeamPaths.campaigns), isEmpty);
  });

  testWidgets('typing in the μID box clears its error', (tester) async {
    final adapter = teamAdapter({..._options()});
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignNew);

    await _fillBasics(tester);
    await tester.tap(find.text('μIDs'));
    await _settle(tester);
    await tester.tap(find.text('Save'));
    await _settle(tester);
    expect(find.text('Add at least one μID.'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(2), 'asha@mulearn');
    await _settle(tester, 2);

    expect(find.text('Add at least one μID.'), findsNothing);
  });

  testWidgets('Schedule sends a UTC time an hour from now by default', (
    tester,
  ) async {
    final adapter = teamAdapter({
      ..._options(),
      'POST ${TeamPaths.campaigns}': (_) =>
          FakeResponse(200, okEnvelope(_campaign(status: 'scheduled'))),
      'GET ${TeamPaths.campaigns}': (_) =>
          _list([_campaign(status: 'scheduled')]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignNew);

    await _fillBasics(tester);
    await tester.tap(find.text('Schedule'));
    await _settle(tester);
    expect(find.byIcon(LucideIcons.calendarDays), findsOneWidget);
    await tester.tap(find.text('Save'));
    await _settle(tester, 14);

    final sent =
        callsTo(adapter, 'POST', TeamPaths.campaigns).single.data as Map;
    expect(sent['scheduled_at'], '2026-11-18T10:00:00.000Z');
  });

  testWidgets('a backend error shows as a toast', (tester) async {
    final adapter = teamAdapter({
      ..._options(),
      'POST ${TeamPaths.campaigns}': (_) =>
          FakeResponse(400, failure('Pick a time in the future.')),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignNew);

    await _fillBasics(tester);
    await tester.tap(find.text('Save'));
    await _settle(tester, 12);

    expect(find.text('Pick a time in the future.'), findsOneWidget);
    expect(find.text('Send now'), findsNothing);
  });

  testWidgets('a sending campaign shows the pull hint and no timer', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) =>
          _list([_campaign(status: 'sending')]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignPath('c-new'));

    expect(
      find.text('Sending now. Pull down for the latest numbers.'),
      findsOneWidget,
    );
    expect(callsTo(adapter, 'GET', TeamPaths.campaigns), hasLength(1));
    await tester.pump(const Duration(seconds: 30));
    expect(callsTo(adapter, 'GET', TeamPaths.campaigns), hasLength(1));
  });

  testWidgets('pull to refresh on the detail reloads', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) =>
          _list([_campaign(status: 'sending')]),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaignPath('c-new'));
    expect(callsTo(adapter, 'GET', TeamPaths.campaigns), hasLength(1));

    await tester.fling(find.byType(ListView), const Offset(0, 400), 1000);
    await _settle(tester, 30);

    expect(callsTo(adapter, 'GET', TeamPaths.campaigns), hasLength(2));
  });

  testWidgets('the detail shows a new campaign when the refresh fails', (
    tester,
  ) async {
    var gets = 0;
    final adapter = teamAdapter({
      ..._options(),
      'POST ${TeamPaths.campaigns}': (_) =>
          FakeResponse(200, okEnvelope(_campaign())),
      'GET ${TeamPaths.campaigns}': (_) {
        gets++;
        return gets == 1
            ? _list(const [])
            : FakeResponse(500, failure('Down.'));
      },
    });
    final router = await pumpTeam(tester, adapter, RoutePaths.teamCampaigns);
    unawaited(router.push(RoutePaths.teamCampaignNew));
    await _settle(tester, 12);

    await _fillBasics(tester);
    await tester.tap(find.text('Save'));
    await _settle(tester, 14);

    expect(gets, 2);
    expect(find.text('Send now'), findsOneWidget);
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('it does not poll when nothing is sending', (tester) async {
    var gets = 0;
    final adapter = teamAdapter({
      'GET ${TeamPaths.campaigns}': (_) {
        gets++;
        return _list([_campaign(status: 'sent')]);
      },
    });
    await pumpTeam(tester, adapter, RoutePaths.teamCampaigns);
    await tester.pump(const Duration(seconds: 30));
    await _settle(tester, 2);
    expect(gets, 1);
  });
}
