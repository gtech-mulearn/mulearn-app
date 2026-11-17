import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/router/route_paths.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';
import 'team_test_support.dart';

const _firstId = 'b1000000-0000-4000-8000-000000000001';

Future<void> _settle(WidgetTester tester, [int frames = 8]) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

Map<String, dynamic> _page({
  required List<Map<String, dynamic>> results,
  int? count,
}) => okEnvelope({
  'count': count ?? results.length,
  'page': 1,
  'page_size': 20,
  'results': results,
});

Map<String, dynamic> _row(
  String id,
  String title, {
  String source = 'team',
  String? createdBy = 'Asha Nair',
  String? target = 'Global (All Users)',
}) => {
  'id': id,
  'title': title,
  'description': 'Bring a laptop and a teammate.',
  'url': '/events',
  'target_type': 'global',
  'target_details': target == null ? null : {'type': 'global', 'name': target},
  'source': source,
  'created_by_name': createdBy,
  'created_at': '2026-11-16T09:30:00Z',
  'expires_at': '2026-11-23T09:30:00Z',
};

FakeHttpAdapter _listAdapter({
  Map<String, FakeResponse Function(RequestOptions)> extra = const {},
}) => teamAdapter({
  // The fixture says 45 in total; later pages are empty and the last.
  'GET ${TeamPaths.broadcasts}': (o) => o.queryParameters['page'] == 1
      ? FakeResponse(200, loadFixture('serializer/team_broadcasts_page'))
      : FakeResponse(
          200,
          okEnvelope({
            'count': 45,
            'page': 3,
            'page_size': 20,
            'results': <Map<String, dynamic>>[],
          }),
        ),
  ...extra,
});

Finder _rich(String text) => find.textContaining(text, findRichText: true);

void main() {
  testWidgets('the list shows source labels, the creator and the target', (
    tester,
  ) async {
    await pumpTeam(tester, _listAdapter(), RoutePaths.teamAnnouncements);

    expect(find.text('Announcements'), findsOneWidget);
    expect(_rich('Hack night on Friday'), findsOneWidget);
    expect(_rich('Team · Asha Nair · Global (All Users)'), findsOneWidget);
    // An unknown source reads as System.
    expect(
      _rich('System · Asha Nair · College of Engineering Trivandrum'),
      findsOneWidget,
    );
    expect(find.text('Mon 16 Nov'), findsNWidgets(1));
    expect(find.byTooltip('New announcement'), findsOneWidget);
  });

  testWidgets('a missing creator and target read as System and Everyone', (
    tester,
  ) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.broadcasts}': (_) => FakeResponse(
        200,
        _page(
          results: [
            _row(
              'b2',
              'Circle created',
              source: 'learning_circle',
              createdBy: null,
              target: null,
            ),
          ],
        ),
      ),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamAnnouncements);

    expect(_rich('Learning circle · System · Everyone'), findsOneWidget);
  });

  testWidgets('the empty state shows and offers no Delete all', (tester) async {
    final adapter = teamAdapter({
      'GET ${TeamPaths.broadcasts}': (_) =>
          FakeResponse(200, _page(results: const [])),
    });
    await pumpTeam(tester, adapter, RoutePaths.teamAnnouncements);

    expect(find.text('No announcements'), findsOneWidget);
    expect(find.text('Delete all'), findsNothing);
  });

  testWidgets('delete all asks with the count and deletes only on confirm', (
    tester,
  ) async {
    final adapter = _listAdapter(
      extra: {
        'DELETE ${TeamPaths.broadcastDeleteAll}': (_) =>
            FakeResponse(200, okEnvelope(null)),
      },
    );
    await pumpTeam(tester, adapter, RoutePaths.teamAnnouncements);

    await tester.tap(find.text('Delete all'));
    await _settle(tester);

    expect(find.text('Delete all 45 announcements?'), findsOneWidget);
    expect(
      find.text(
        'This includes ones the system created for learning circles, '
        "projects and events. This can't be undone.",
      ),
      findsOneWidget,
    );
    expect(callsTo(adapter, 'DELETE', TeamPaths.broadcastDeleteAll), isEmpty);

    // The dialog's confirm button is the last "Delete all" on screen.
    await tester.tap(find.text('Delete all').last);
    await _settle(tester);

    expect(
      callsTo(adapter, 'DELETE', TeamPaths.broadcastDeleteAll),
      hasLength(1),
    );
    // Every mutation refreshes the list.
    expect(
      callsTo(
        adapter,
        'GET',
        TeamPaths.broadcasts,
      ).where((r) => r.queryParameters['page'] == 1),
      hasLength(2),
    );
  });

  testWidgets('cancelling delete all makes no request', (tester) async {
    final adapter = _listAdapter();
    await pumpTeam(tester, adapter, RoutePaths.teamAnnouncements);

    await tester.tap(find.text('Delete all'));
    await _settle(tester);
    await tester.tap(find.text('Cancel'));
    await _settle(tester);

    expect(adapter.requests.where((r) => r.method == 'DELETE'), isEmpty);
    expect(find.text('Delete all 45 announcements?'), findsNothing);
  });

  testWidgets('a failed delete all shows the backend message', (tester) async {
    final adapter = _listAdapter(
      extra: {
        'DELETE ${TeamPaths.broadcastDeleteAll}': (_) =>
            FakeResponse(400, failure('Could not delete announcements.')),
      },
    );
    await pumpTeam(tester, adapter, RoutePaths.teamAnnouncements);

    await tester.tap(find.text('Delete all'));
    await _settle(tester);
    await tester.tap(find.text('Delete all').last);
    await _settle(tester);

    expect(find.text('Could not delete announcements.'), findsOneWidget);
  });

  testWidgets('new posts to the broadcast endpoint only after confirming, '
      'then shows what was sent', (tester) async {
    var sent = false;
    final adapter = teamAdapter({
      'GET ${TeamPaths.broadcasts}': (_) => FakeResponse(
        200,
        _page(
          results: [
            if (sent) _row('b9', 'Hack night moved'),
            _row('b1', 'Older one'),
          ],
        ),
      ),
      'POST ${TeamPaths.sendToEveryone}': (_) {
        sent = true;
        return FakeResponse(200, okEnvelope(null));
      },
    });
    final router = await pumpTeam(
      tester,
      adapter,
      RoutePaths.teamAnnouncements,
    );
    unawaited(router.push(RoutePaths.teamAnnouncementNew));
    await _settle(tester);

    await tester.enterText(find.byType(TextField).at(0), 'Hack night moved');
    await tester.enterText(
      find.byType(TextField).at(1),
      'Now at 7 pm in the main lab.',
    );
    await tester.tap(find.text('Send to everyone'));
    await _settle(tester);

    expect(find.text('Send to everyone?'), findsOneWidget);
    expect(
      find.text("It appears in every member's notifications."),
      findsOneWidget,
    );
    expect(callsTo(adapter, 'POST', TeamPaths.sendToEveryone), isEmpty);

    await tester.tap(find.text('Send'));
    await _settle(tester, 12);

    final posts = callsTo(adapter, 'POST', TeamPaths.sendToEveryone);
    expect(posts, hasLength(1));
    expect(jsonDecode(jsonEncode(posts.single.data)), {
      'title': 'Hack night moved',
      'description': 'Now at 7 pm in the main lab.',
      'expires_in_days': 7,
    });
    // Back on the list, which now shows the new announcement.
    expect(_rich('Hack night moved'), findsOneWidget);
    expect(find.text('Send to everyone?'), findsNothing);
  });

  testWidgets('new will not send without a title or message', (tester) async {
    final adapter = _listAdapter();
    final router = await pumpTeam(
      tester,
      adapter,
      RoutePaths.teamAnnouncements,
    );
    unawaited(router.push(RoutePaths.teamAnnouncementNew));
    await _settle(tester);

    await tester.tap(find.text('Send to everyone'));
    await _settle(tester);

    expect(find.text('Send to everyone?'), findsNothing);
    expect(callsTo(adapter, 'POST', TeamPaths.sendToEveryone), isEmpty);
  });

  testWidgets('edit sends a PATCH with only the changed fields', (
    tester,
  ) async {
    final adapter = _listAdapter(
      extra: {
        'PATCH ${TeamPaths.broadcastUpdate(_firstId)}': (_) =>
            FakeResponse(200, okEnvelope(_row(_firstId, 'Hack night is on'))),
      },
    );
    final router = await pumpTeam(
      tester,
      adapter,
      RoutePaths.teamAnnouncements,
    );
    unawaited(router.push(RoutePaths.teamAnnouncementEditPath(_firstId)));
    await _settle(tester);

    expect(find.text('Hack night on Friday'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), 'Hack night is on');
    await tester.tap(find.text('Save'));
    await _settle(tester, 12);

    final patches = callsTo(
      adapter,
      'PATCH',
      TeamPaths.broadcastUpdate(_firstId),
    );
    expect(patches, hasLength(1));
    expect(jsonDecode(jsonEncode(patches.single.data)), {
      'title': 'Hack night is on',
    });
  });

  testWidgets('edit with nothing changed sends nothing', (tester) async {
    final adapter = _listAdapter();
    final router = await pumpTeam(
      tester,
      adapter,
      RoutePaths.teamAnnouncements,
    );
    unawaited(router.push(RoutePaths.teamAnnouncementEditPath(_firstId)));
    await _settle(tester);

    await tester.tap(find.text('Save'));
    await _settle(tester, 12);

    expect(adapter.requests.where((r) => r.method == 'PATCH'), isEmpty);
  });

  testWidgets('a row opens the detail, which deletes after confirming', (
    tester,
  ) async {
    final adapter = _listAdapter(
      extra: {
        'DELETE ${TeamPaths.broadcastDelete(_firstId)}': (_) =>
            FakeResponse(200, okEnvelope(null)),
      },
    );
    await pumpTeam(tester, adapter, RoutePaths.teamAnnouncements);

    await tester.tap(_rich('Hack night on Friday'));
    await _settle(tester, 14);

    expect(
      find.text('Bring a laptop and a teammate to the campus lab at 6 pm.'),
      findsOneWidget,
    );
    expect(find.text('Asha Nair'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await _settle(tester);
    expect(find.text('Delete this announcement?'), findsOneWidget);
    expect(
      callsTo(adapter, 'DELETE', TeamPaths.broadcastDelete(_firstId)),
      isEmpty,
    );

    await tester.tap(find.text('Delete').last);
    await _settle(tester, 12);

    expect(
      callsTo(adapter, 'DELETE', TeamPaths.broadcastDelete(_firstId)),
      hasLength(1),
    );
  });

  testWidgets('an announcement that is not loaded shows not found', (
    tester,
  ) async {
    await pumpTeam(
      tester,
      _listAdapter(),
      RoutePaths.teamAnnouncementPath('missing'),
    );

    expect(find.text('Looks like you wandered off the path.'), findsOneWidget);
  });
}
