import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/session/workspace_access.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/core/widgets/mu_state_display.dart';
import 'package:mulearn_app/features/campus/data/dtos/approval_dtos.dart';
import 'package:mulearn_app/features/campus/presentation/screens/campus_approvals_screen.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';
import '../../support/fixtures.dart';

const _links = '/api/v1/dashboard/user/unverified-org-links/';
const _events = '/api/v1/dashboard/campus/events/';
const _invites = '/api/v1/dashboard/events/my-invites/';
const _inviteEvent = '9923c2fd-56a4-426d-bfd5-694d3b532a32';
const _inviteId = 'c8496edd-ee2a-4f1c-9f11-8c0cc4cedc94';

/// Plan 4, Task 11 (K4): college links (Campus Lead), campus events (every
/// campus role) and collaboration invites (Campus Lead).
void main() {
  late FakeHttpAdapter adapter;

  Map<String, dynamic> ok([String message = '']) => {
        'hasError': false,
        'statusCode': 200,
        'message': {'general': message.isEmpty ? <String>[] : [message]},
        'response': <String, dynamic>{},
      };

  setUp(() {
    adapter = FakeHttpAdapter({
      'GET $_links': (_) => FakeResponse(200, loadFixture('serializer/campus_org_links_one')),
      'GET $_events': (_) => FakeResponse(200, loadFixture('serializer/campus_events_pending')),
      'GET $_invites': (_) => FakeResponse(200, loadFixture('dev/campus_collab_invites_one')),
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

  Future<void> pump(WidgetTester tester, {bool campusLead = true}) async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
    final container = ProviderContainer(retry: (_, __) => null, overrides: [
      dioProvider.overrideWithValue(fakeDio(adapter)),
      tokenStorageProvider.overrideWithValue(tokens),
      clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 13, 9)),
      workspaceAccessProvider.overrideWith(
        (ref) async => WorkspaceAccess(
          mentor: WorkspaceState.hidden,
          campus: WorkspaceState.open,
          enablerCampuses: campusLead ? WorkspaceState.hidden : WorkspaceState.open,
          campusLead: campusLead,
        ),
      ),
    ]);
    addTearDown(container.dispose);
    final router = GoRouter(initialLocation: '/a', routes: [GoRoute(path: '/a', builder: (_, __) => const CampusApprovalsScreen())]);
    addTearDown(router.dispose);
    tester.view.physicalSize = const Size(1080, 5000);
    addTearDown(tester.view.resetPhysicalSize);
    await tester.pumpWidget(UncontrolledProviderScope(container: container, child: MaterialApp.router(routerConfig: router)));
    await settle(tester);
  }

  Future<void> drainToast(WidgetTester tester) => tester.pump(const Duration(seconds: 4));

  test('a college link request carries no contact details', () {
    final row = ((loadFixtureResponse('serializer/campus_org_links_one')! as Map)['data'] as List).first;
    final link = OrgLinkRequestDto.fromJson(row as Map<String, dynamic>).toDomain();
    expect(link.fullName, 'QA Pending Link');
    expect(link.graduationYear, '2028');
    expect(link.toString(), isNot(contains('9999999999')));
    expect(link.toString(), isNot(contains('example.com')));
  });

  test('the recorded collaboration invite parses', () {
    final row = (loadFixtureResponse('dev/campus_collab_invites_one')! as List).first;
    final invite = CollabInviteDto.fromJson(row as Map<String, dynamic>).toDomain();
    expect(invite.id, _inviteId);
    expect(invite.eventId, _inviteEvent);
    expect(invite.roleLabel, 'Co-host');
    expect(invite.entityName, 'St. Josephs Colege of Engineering and Technology');
  });

  testWidgets('a campus lead sees all three sections', (tester) async {
    await pump(tester);

    expect(find.textContaining('COLLEGE LINKS'), findsOneWidget);
    expect(find.text('QA Pending Link'), findsOneWidget);
    expect(find.textContaining('CAMPUS EVENTS'), findsOneWidget);
    expect(find.text('Robotics club open day'), findsOneWidget);
    expect(find.textContaining('COLLABORATION INVITES'), findsOneWidget);
    expect(find.textContaining('[QA] Collaboration invite check'), findsOneWidget);
  });

  testWidgets('an enabler sees campus events only (links and invites are Campus Lead)', (tester) async {
    await pump(tester, campusLead: false);

    expect(find.textContaining('CAMPUS EVENTS'), findsOneWidget);
    expect(find.textContaining('COLLEGE LINKS'), findsNothing);
    expect(find.textContaining('COLLABORATION INVITES'), findsNothing);
    expect(adapter.requests.where((r) => r.uri.path == _links || r.uri.path == _invites), isEmpty);
  });

  testWidgets('verify asks first and sends verified: true', (tester) async {
    adapter.routes['PATCH ${_links}link-1/'] = (_) => FakeResponse(200, ok());
    await pump(tester);

    await tester.tap(find.text('Verify'));
    await settle(tester);
    expect(find.textContaining('Verify QA Pending Link as a member of'), findsOneWidget);
    await tester.tap(find.descendant(of: find.byType(AlertDialog), matching: find.text('Verify')));
    await settle(tester);

    expect(bodyOf('PATCH', '${_links}link-1/'), {'verified': true});
    await drainToast(tester);
  });

  testWidgets('rejecting an event needs a reason before any request', (tester) async {
    adapter.routes['POST /api/v1/dashboard/events/campus/ev-1/reject/'] = (_) => FakeResponse(200, ok('Event rejected.'));
    await pump(tester);

    await tester.tap(find.widgetWithText(TextButton, 'Reject').first);
    await settle(tester);
    await tester.tap(find.widgetWithText(FilledButton, 'Reject event'));
    await settle(tester);
    expect(find.text('A rejection reason is required.'), findsOneWidget);
    expect(adapter.requests.where((RequestOptions r) => r.method == 'POST'), isEmpty);

    await tester.enterText(find.byType(TextField).last, 'Clashes with exams');
    await tester.tap(find.widgetWithText(FilledButton, 'Reject event'));
    await settle(tester);
    expect(bodyOf('POST', '/api/v1/dashboard/events/campus/ev-1/reject/'), {'reason': 'Clashes with exams'});
    await drainToast(tester);
  });

  testWidgets('an event someone already handled says so and refreshes', (tester) async {
    adapter.routes['POST /api/v1/dashboard/events/campus/ev-1/approve/'] = (_) => const FakeResponse(400, {
          'hasError': true,
          'statusCode': 400,
          'message': {'general': ['Event is not pending campus approval.']},
          'response': <String, dynamic>{},
        });
    await pump(tester);
    final loads = adapter.requests.where((r) => r.uri.path == _events).length;

    await tester.tap(find.widgetWithText(FilledButton, 'Approve').first);
    await settle(tester);

    expect(find.text('Event is not pending campus approval.'), findsOneWidget);
    expect(adapter.requests.where((r) => r.uri.path == _events).length, greaterThan(loads));
    await drainToast(tester);
  });

  testWidgets('accepting an invite posts to its event', (tester) async {
    adapter.routes['POST /api/v1/dashboard/events/manage/$_inviteEvent/collaborators/$_inviteId/accept/'] =
        (_) => FakeResponse(200, ok('Invite accepted.'));
    await pump(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Accept'));
    await settle(tester);

    expect(adapter.requests.where((r) => r.uri.path.endsWith('/$_inviteId/accept/')), hasLength(1));
    await drainToast(tester);
  });

  testWidgets('nothing to review shows the illustrated empty state', (tester) async {
    adapter.routes['GET $_links'] = (_) => FakeResponse(200, loadFixture('dev/campus_org_links_empty'));
    adapter.routes['GET $_events'] = (_) => FakeResponse(200, loadFixture('dev/campus_events_pending_empty'));
    adapter.routes['GET $_invites'] = (_) => const FakeResponse(200, {
          'hasError': false,
          'statusCode': 200,
          'message': {'general': <String>[]},
          'response': <Object>[],
        });
    await pump(tester);

    expect(find.byType(MuStateDisplay), findsOneWidget);
    expect(find.text('Nothing to review'), findsOneWidget);
  });
}
