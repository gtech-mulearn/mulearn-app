import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/problem_statements/data/problem_statements_data.dart';
import 'package:mulearn_app/features/problem_statements/domain/entities/problem_statement.dart';
import 'package:mulearn_app/features/problem_statements/presentation/screens/problem_statement_detail_screen.dart';
import 'package:mulearn_app/features/problem_statements/presentation/screens/problem_statements_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _base = '/api/v1/dashboard/problem-statements/';
const _open = '030157e3-580b-44ca-bbec-00182289fb41'; // "muLearn Platform Challenge", open until 31 Dec

/// The learner feed, detail and interaction endpoints, recorded on dev
/// 2026-11-15 as the QA student (7 published statements, none joined).
/// Writes are faked: the recorded account isn't changed on dev.
void main() {
  test('statements parse with their company, counts, deadline and status', () {
    final page = ProblemStatementsRepositoryImpl.parsePage(
      loadFixtureResponse('dev/problem_statements_feed')! as Map<String, dynamic>,
    );
    expect(page.items, hasLength(7));
    final fraud = page.items.firstWhere((s) => s.title == 'Build a Fraud Detection Model');
    expect(fraud.companyName, 'company 1');
    expect(fraud.isOpen, isTrue);
    expect(fraud.trying, 1);
    expect(fraud.skills, ['python', 'machine-learning']);
    expect(fraud.myStatus, isNull);
    final noDeadline = page.items.firstWhere((s) => s.deadline == null);
    expect(noDeadline.isOpen, isTrue);
    expect(page.items.where((s) => !s.isOpen), isNotEmpty);

    final none = ProblemStatementsRepositoryImpl.parseParticipation(
      loadFixtureResponse('dev/problem_statement_interaction_none')! as Map<String, dynamic>,
    );
    expect(none.status, isNull);
    expect(PsStatus.parse('Submitted'), PsStatus.submitted);
  });

  late FakeHttpAdapter adapter;
  late Map<String, Object?> mine; // the faked interaction row

  Map<String, dynamic> envelope(Object? response) => {
    'hasError': false,
    'statusCode': 200,
    'message': {'general': <String>[]},
    'response': response,
  };

  setUp(() {
    mine = {'status': null, 'submission_url': null, 'submitted_at': null};
    Map<String, dynamic> detail() {
      final d = jsonDecode(jsonEncode(loadFixtureResponse('dev/problem_statement_detail'))) as Map<String, dynamic>;
      d['my_interaction'] = mine['status'];
      return d;
    }

    adapter = FakeHttpAdapter({
      'GET $_base': (RequestOptions r) {
        final feed = jsonDecode(jsonEncode(loadFixtureResponse('dev/problem_statements_feed'))) as Map<String, dynamic>;
        for (final row in (feed['data'] as List).cast<Map<String, dynamic>>()) {
          if (row['id'] == _open) row['my_interaction'] = mine['status'];
        }
        return FakeResponse(200, envelope(feed));
      },
      'GET $_base$_open/': (_) => FakeResponse(200, envelope(detail())),
      'GET $_base$_open/interaction/': (_) => FakeResponse(200, envelope(Map.of(mine))),
      'PUT $_base$_open/interaction/': (_) {
        mine['status'] = 'Trying';
        return FakeResponse(200, envelope({'status': 'Trying'}));
      },
      'PUT $_base$_open/submission/': (RequestOptions r) {
        mine
          ..['status'] = 'Submitted'
          ..['submission_url'] = (r.data as Map)['submission_url']
          ..['submitted_at'] = '2026-11-15T10:00:00Z';
        return FakeResponse(200, envelope(Map.of(mine)));
      },
      'DELETE $_base$_open/submission/': (_) {
        mine
          ..['status'] = 'Trying'
          ..['submission_url'] = null
          ..['submitted_at'] = null;
        return FakeResponse(200, envelope(null));
      },
    });
  });

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> pump(WidgetTester tester, String start) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
        clockProvider.overrideWithValue(() => DateTime(2026, 11, 15, 12)),
      ],
    );
    addTearDown(container.dispose);
    final router = GoRouter(
      initialLocation: start,
      routes: [
        GoRoute(path: '/problem-statements', builder: (_, _) => const ProblemStatementsScreen()),
        GoRoute(
          path: '/problem-statements/:id',
          builder: (_, s) => ProblemStatementDetailScreen(id: s.pathParameters['id']!),
        ),
      ],
    );
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 6000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(theme: MuThemeData.light(), routerConfig: router),
      ),
    );
    await settle(tester);
  }

  testWidgets('Browse lists the feed with deadlines; Participating starts empty', (tester) async {
    await pump(tester, '/problem-statements');

    expect(find.text('muLearn Platform Challenge'), findsOneWidget);
    expect(find.text('Build a Fraud Detection Model'), findsOneWidget);
    expect(find.textContaining('Closes '), findsNWidgets(2), reason: 'the two open ones with a deadline');
    expect(find.text('No deadline'), findsOneWidget);
    expect(find.text('Closed'), findsWidgets);

    await tester.tap(find.text('Participating'));
    await settle(tester);
    expect(find.textContaining("You're not on any yet"), findsOneWidget);
  });

  testWidgets('try it, submit a link, withdraw: each step shows the next one', (tester) async {
    await pump(tester, '/problem-statements/$_open');

    expect(find.text('muLearn Platform Challenge'), findsOneWidget);
    expect(find.text('Be the first to try it'), findsOneWidget);
    await tester.tap(find.widgetWithText(MuButton, "I'm trying it"));
    await settle(tester);
    expect(find.widgetWithText(MuButton, 'Submit solution'), findsOneWidget);
    expect(find.widgetWithText(MuButton, 'Leave'), findsOneWidget);

    await tester.tap(find.widgetWithText(MuButton, 'Submit solution'));
    await settle(tester);
    await tester.enterText(find.byType(TextField), 'github.com/me/tracker');
    await tester.tap(find.widgetWithText(MuButton, 'Submit'));
    await settle(tester);
    final put = adapter.requests.lastWhere((RequestOptions r) => r.method == 'PUT');
    expect((put.data as Map)['submission_url'], 'https://github.com/me/tracker', reason: 'https added');
    expect(find.text('Your solution'), findsOneWidget);
    expect(find.widgetWithText(MuButton, 'Update link'), findsOneWidget);

    await tester.tap(find.widgetWithText(MuButton, 'Withdraw'));
    await settle(tester);
    await tester.tap(find.widgetWithText(MuButton, 'Withdraw').last);
    await settle(tester);
    expect(adapter.requests.where((RequestOptions r) => r.method == 'DELETE'), hasLength(1));
    expect(find.widgetWithText(MuButton, 'Submit solution'), findsOneWidget);
  });
}
