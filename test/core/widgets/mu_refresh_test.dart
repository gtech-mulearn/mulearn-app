import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/widgets/mu_refresh.dart';
import 'package:mulearn_app/features/events/domain/entities/event_filter.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';
import 'package:mulearn_app/features/events/presentation/screens/events_screen.dart';

import '../../features/events/events_test_support.dart';
import '../../support/fake_http_adapter.dart';
import '../../support/fixtures.dart';

/// UX-05: pull-to-refresh waits for the refetch, and a failed refresh keeps
/// what the screen already shows.
void main() {
  Future<void> pull(WidgetTester tester, {Finder? on}) async {
    await tester.fling(on ?? find.byType(ListView).first, const Offset(0, 400), 1000);
    await tester.pump();
    await tester.pump(const Duration(seconds: 1)); // the indicator's settle animation
  }

  testWidgets('the indicator stays until the refetch finishes', (tester) async {
    final done = Completer<void>();
    var calls = 0;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MuRefresh(
          onRefresh: () {
            calls++;
            return done.future;
          },
          child: ListView(children: const [SizedBox(height: 2000, child: Text('rows'))]),
        ),
      ),
    ));

    await pull(tester);
    expect(calls, 1);
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);

    done.complete();
    await tester.pumpAndSettle();
    expect(find.byType(RefreshProgressIndicator), findsNothing);
  });

  testWidgets("a failed refetch is a toast with the backend's message", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MuRefresh(
          onRefresh: () async => throw const ApiException(message: 'Server unavailable'),
          child: ListView(children: const [SizedBox(height: 2000, child: Text('rows'))]),
        ),
      ),
    ));

    await pull(tester);
    await tester.pumpAndSettle();

    expect(find.text('Server unavailable'), findsOneWidget);
    expect(find.text('rows'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });

  testWidgets('Events keeps its rows when a refresh fails', (tester) async {
    var fail = false;
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/events/': (_) => fail ? const FakeResponse(-1, null) : FakeResponse(200, loadFixture('dev/events_page1')),
    });
    final c = await eventsContainer(adapter);
    await tester.pumpWidget(UncontrolledProviderScope(container: c, child: const MaterialApp(home: EventsScreen())));
    await settle(tester);
    final first = c.read(eventsListControllerProvider(const EventFilter())).value!.items.first.title;
    expect(find.text(first), findsOneWidget);

    final before = adapter.requests.length;
    fail = true;
    await pull(tester);
    await settle(tester);
    await tester.pumpAndSettle();

    expect(adapter.requests.length, greaterThan(before), reason: 'the pull refetched');
    expect(find.text(first), findsOneWidget, reason: 'the list stays');
    expect(find.text('Retry'), findsNothing, reason: 'no full-screen error');
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
