import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

import '../../support/fake_http_adapter.dart';
import 'team_test_support.dart';

const _failureMessage =
    'No push was sent: register this account on a phone first, then try again.';

Finder _rich(String text) => find.textContaining(text, findRichText: true);

void main() {
  testWidgets('the team home shows the three rows and the test push button', (
    tester,
  ) async {
    await pumpTeam(tester, teamAdapter(), '/team');

    expect(find.text('Team'), findsOneWidget);
    // The description is the row's body, set after the subject.
    expect(
      _rich("Announcements In-app messages in everyone's bell"),
      findsOneWidget,
    );
    expect(_rich("Push campaigns Pushes to learners' phones"), findsOneWidget);
    expect(
      _rich('Activity log Who sent, edited or deleted what'),
      findsOneWidget,
    );
    expect(find.text('Send me a test push'), findsOneWidget);
  });

  testWidgets('a sent test push shows the backend message', (tester) async {
    final adapter = teamAdapter({
      'POST ${TeamPaths.testPush}': (_) => FakeResponse(
        200,
        okEnvelope(null, message: 'Test push sent to 2 devices.'),
      ),
    });
    await pumpTeam(tester, adapter, '/team');

    await tester.tap(find.text('Send me a test push'));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(find.text('Test push sent to 2 devices.'), findsOneWidget);
    expect(callsTo(adapter, 'POST', TeamPaths.testPush), hasLength(1));
  });

  testWidgets('a failed test push shows why', (tester) async {
    final adapter = teamAdapter({
      'POST ${TeamPaths.testPush}': (_) =>
          FakeResponse(400, failure(_failureMessage)),
    });
    await pumpTeam(tester, adapter, '/team');

    await tester.tap(find.text('Send me a test push'));
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }

    expect(
      find.textContaining('register this account on a phone first'),
      findsOneWidget,
    );
  });
}
