import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/campus/data/dtos/enabler_dtos.dart';
import 'package:mulearn_app/features/campus/presentation/screens/enabler_campus_screen.dart';
import 'package:mulearn_app/features/campus/presentation/screens/enabler_campuses_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/enabler';
const _campus = 'ad3a3793-d780-4ec1-b03e-fac92e0faa0d';
const _notes = '$_base/campuses/$_campus/notes/';

/// Plan 4, Task 12 (K5): an enabler's campuses, a campus's review and the
/// enabler's notes about it.
void main() {
  late FakeHttpAdapter adapter;

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_base/home-summary/': (_) => FakeResponse(200, loadFixture('dev/enabler_home_summary')),
      'GET $_base/campuses/': (_) => FakeResponse(200, loadFixture('dev/enabler_campuses')),
      'GET $_base/campuses/$_campus/review/': (_) => FakeResponse(200, loadFixture('dev/enabler_campus_review')),
      'GET $_notes': (_) => FakeResponse(200, loadFixture('dev/enabler_campus_notes_one')),
    });
  });

  Map<String, dynamic> bodyOf(String method, String path) {
    final r = adapter.requests.lastWhere((RequestOptions r) => r.method == method && r.uri.path == path);
    return (r.data is String ? jsonDecode(r.data as String) : r.data) as Map<String, dynamic>;
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> pump(WidgetTester tester, String location) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 13, 14)),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: location, routes: [
      GoRoute(path: '/enabler/campuses', builder: (_, __) => const EnablerCampusesScreen()),
      GoRoute(path: '/enabler/campuses/:id', builder: (_, s) => EnablerCampusScreen(campusId: s.pathParameters['id']!)),
    ]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    await settle(tester);
  }

  Future<void> drainToast(WidgetTester tester) => tester.pump(const Duration(seconds: 4));

  test('the recorded note parses', () {
    final row = ((loadFixtureResponse('dev/enabler_campus_notes_one')! as Map)['data'] as List).first;
    final note = CampusNoteDto.fromJson(row as Map<String, dynamic>).toDomain();
    expect(note.note, startsWith('[QA] app plan 4 check'));
    expect((note.priority, note.status), ('medium', 'open'));
    expect(note.followUp, DateTime(2026, 11, 27));
  });

  testWidgets('the campuses list shows the totals and each campus', (tester) async {
    await pump(tester, '/enabler/campuses');

    expect(find.text('1 campus · 23 students · 0 karma'), findsOneWidget);
    expect(find.text('St. Josephs Colege of Engineering and Technology'), findsOneWidget);
    expect(find.text('SJC · Central Zone · College'), findsOneWidget);

    await tester.tap(find.text('St. Josephs Colege of Engineering and Technology'));
    await settle(tester);
    expect(find.byType(EnablerCampusScreen), findsOneWidget);
  });

  testWidgets('a campus shows its notes with priority, status and follow-up', (tester) async {
    await pump(tester, '/enabler/campuses/$_campus');

    expect(find.textContaining('[QA] app plan 4 check'), findsOneWidget);
    expect(find.text('Follow up Fri 27 Nov'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Open'), findsOneWidget);
  });

  testWidgets('a blank note is refused before any request', (tester) async {
    await pump(tester, '/enabler/campuses/$_campus');

    await tester.tap(find.text('Add note'));
    await settle(tester);
    await tester.tap(find.text('Save note'));
    await settle(tester);

    expect(find.text('Write a note first.'), findsOneWidget);
    expect(adapter.requests.where((RequestOptions r) => r.method == 'POST'), isEmpty);
  });

  testWidgets('a note is saved with its priority, and the list reloads', (tester) async {
    adapter.routes['POST $_notes'] = (_) => const FakeResponse(200, {
          'hasError': false,
          'statusCode': 200,
          'message': {'general': ['Note added successfully']},
          'response': <String, dynamic>{},
        });
    await pump(tester, '/enabler/campuses/$_campus');
    final loads = adapter.requests.where((r) => r.uri.path == _notes && r.method == 'GET').length;

    await tester.tap(find.text('Add note'));
    await settle(tester);
    await tester.enterText(find.widgetWithText(TextField, 'Note'), '  Visited the IoT lab  ');
    await tester.tap(find.text('High'));
    await tester.tap(find.text('Save note'));
    await settle(tester);

    expect(bodyOf('POST', _notes), {'note': 'Visited the IoT lab', 'priority': 'high'});
    expect(adapter.requests.where((r) => r.uri.path == _notes && r.method == 'GET').length, greaterThan(loads));
    expect(find.text('Note added successfully'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('a campus the enabler is not assigned to says so', (tester) async {
    adapter.routes['POST $_notes'] = (_) => FakeResponse(400, loadFixture('dev/enabler_note_not_assigned'));
    await pump(tester, '/enabler/campuses/$_campus');

    await tester.tap(find.text('Add note'));
    await settle(tester);
    await tester.enterText(find.widgetWithText(TextField, 'Note'), 'Hello');
    await tester.tap(find.text('Save note'));
    await settle(tester);

    expect(find.text('Not assigned to this campus'), findsOneWidget);
    await drainToast(tester);
  });

  testWidgets('no notes yet explains what they are for', (tester) async {
    adapter.routes['GET $_notes'] = (_) => FakeResponse(200, loadFixture('dev/enabler_campus_notes'));
    await pump(tester, '/enabler/campuses/$_campus');

    expect(find.text('No notes yet. Add what you discussed and when to follow up.'), findsOneWidget);
  });
}
