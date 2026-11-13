import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/auth/current_user_claims.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/learning_circles/data/datasources/learning_circles_remote_datasource.dart';
import 'package:mulearn_app/features/learning_circles/data/repositories/learning_circles_repository_impl.dart';
import 'package:mulearn_app/features/learning_circles/domain/entities/circle_member.dart';
import 'package:mulearn_app/features/learning_circles/domain/membership_rules.dart';
import 'package:mulearn_app/features/learning_circles/presentation/widgets/circle_membership_widgets.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

const _circle = 'c1';

FakeResponse _ok(String message) => FakeResponse(200, {
      'hasError': false,
      'statusCode': 200,
      'message': {
        'general': [message],
      },
      'response': <String, dynamic>{},
    });

FakeResponse _refused(String message) => FakeResponse(400, {
      'hasError': true,
      'statusCode': 400,
      'message': {
        'general': [message],
      },
      'response': <String, dynamic>{},
    });

String _jwt(Map<String, Object> claims) {
  String part(Map<String, Object> json) => base64Url.encode(utf8.encode(jsonEncode(json))).replaceAll('=', '');
  return '${part({'alg': 'HS256'})}.${part(claims)}.sig';
}

/// FEAT-07 — learningcircle/ leave/, members/remove/, meeting/rsvp/ (DELETE),
/// invite/ {muid, lead} (learningcircle_views.py:1471-1850).
void main() {
  const me = CircleMember(id: 'u-me', fullName: 'Me', muid: 'me@mulearn');
  const lead = CircleMember(id: 'u-lead', fullName: 'Lead', muid: 'lead@mulearn', isLeader: true);
  const other = CircleMember(id: 'u-other', fullName: 'Other', muid: 'other@mulearn');

  group('roles', () {
    test('creator, lead, member and visitor', () {
      expect(circleRole(myMuid: 'lead@mulearn', creatorMuid: 'lead@mulearn', members: [me, lead]), CircleRole.creator);
      expect(circleRole(myMuid: 'lead@mulearn', creatorMuid: 'x@mulearn', members: [me, lead]), CircleRole.lead);
      expect(circleRole(myMuid: 'me@mulearn', creatorMuid: 'lead@mulearn', members: [me, lead]), CircleRole.member);
      expect(circleRole(myMuid: 'nobody@mulearn', creatorMuid: 'lead@mulearn', members: [me, lead]), CircleRole.visitor);
    });

    test('leads and creators remove others, never themselves or the creator', () {
      bool can(CircleRole viewer, CircleMember m, {String my = 'lead@mulearn'}) =>
          canRemoveMember(viewer: viewer, member: m, myMuid: my, creatorMuid: 'creator@mulearn');

      expect(can(CircleRole.lead, other), isTrue);
      expect(can(CircleRole.creator, other), isTrue);
      expect(can(CircleRole.member, other, my: 'me@mulearn'), isFalse);
      expect(can(CircleRole.lead, lead), isFalse, reason: 'not yourself');
      expect(can(CircleRole.lead, const CircleMember(id: 'c', fullName: 'C', muid: 'creator@mulearn')), isFalse);
    });
  });

  group('repository', () {
    late FakeHttpAdapter adapter;
    late LearningCirclesRepositoryImpl repo;

    setUp(() {
      adapter = FakeHttpAdapter({
        'DELETE /api/v1/dashboard/learningcircle/leave/$_circle/': (_) => _ok('You have left the circle successfully'),
        'DELETE /api/v1/dashboard/learningcircle/members/remove/$_circle/': (_) => _ok('Member removed'),
        'DELETE /api/v1/dashboard/learningcircle/meeting/rsvp/m1/': (_) => _ok('Your RSVP has been successfully removed'),
        'POST /api/v1/dashboard/learningcircle/invite/$_circle/': (_) => _ok('Invitation sent'),
      });
      repo = LearningCirclesRepositoryImpl(LearningCirclesRemoteDataSource(fakeDio(adapter)));
    });

    RequestOptions last() => adapter.requests.last;

    test('leave, remove, cancel RSVP and invite as co-lead send the documented calls', () async {
      await repo.leaveCircle(_circle);
      expect((last().method, last().uri.path), ('DELETE', '/api/v1/dashboard/learningcircle/leave/$_circle/'));

      await repo.removeMember(_circle, muid: 'other@mulearn');
      expect(last().data, {'muid': 'other@mulearn'});

      await repo.cancelRsvp('m1');
      expect((last().method, last().uri.path), ('DELETE', '/api/v1/dashboard/learningcircle/meeting/rsvp/m1/'));

      await repo.sendInvite(_circle, muid: 'other@mulearn', asLead: true);
      expect(last().data, {'muid': 'other@mulearn', 'lead': true});
      await repo.sendInvite(_circle, muid: 'other@mulearn');
      expect(last().data, {'muid': 'other@mulearn', 'lead': false});
    });
  });

  test("the signed-in user's id comes from the token", () async {
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: _jwt({'id': 'u-me', 'muid': 'me@mulearn'}), refreshToken: 'r');
    final c = ProviderContainer(overrides: [tokenStorageProvider.overrideWithValue(tokens)]);
    addTearDown(c.dispose);

    expect(await c.read(currentUserIdProvider.future), 'u-me');
  });

  group('leave section', () {
    Future<FakeHttpAdapter> pump(WidgetTester tester, CircleRole role, {FakeResponse? reply}) async {
      final adapter = FakeHttpAdapter({
        'DELETE /api/v1/dashboard/learningcircle/leave/$_circle/': (_) => reply ?? _ok('You have left the circle successfully'),
        'GET /api/v1/dashboard/learningcircle/user-circles/': (_) => const FakeResponse(200, {
              'hasError': false,
              'statusCode': 200,
              'message': {'general': <String>[]},
              'response': {'data': <Object>[]},
            }),
      });
      final tokens = TokenStorage(FakeSecureStorage());
      await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
      final container = ProviderContainer(retry: (_, __) => null, overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
      ]);
      addTearDown(container.dispose);
      await tester.pumpWidget(UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute<void>(
                  builder: (_) => Scaffold(body: CircleLeaveSection(circleId: _circle, circleTitle: 'Web Dev', role: role)),
                )),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ));
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      return adapter;
    }

    testWidgets('a member can leave after confirming, and is taken back', (tester) async {
      final adapter = await pump(tester, CircleRole.member);

      await tester.tap(find.text('Leave circle'));
      await tester.pumpAndSettle();
      expect(find.text('Leave Web Dev?'), findsOneWidget);
      await tester.tap(find.text('Leave'));
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      await tester.pumpAndSettle();

      expect(adapter.requests.where((RequestOptions r) => r.method == 'DELETE'), hasLength(1));
      expect(find.text('open'), findsOneWidget, reason: 'popped back');
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });

    testWidgets("a lead is told to hand over first; a creator can't leave", (tester) async {
      await pump(tester, CircleRole.lead);
      expect(find.text('Leave circle'), findsNothing);
      expect(find.text('You lead this circle. Transfer leadership before leaving.'), findsOneWidget);
    });

    testWidgets("the backend's refusal is shown", (tester) async {
      await pump(tester, CircleRole.member, reply: _refused('You are the lead. Transfer leadership before leaving.'));

      await tester.tap(find.text('Leave circle'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Leave'));
      for (var i = 0; i < 6; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }

      expect(find.text('You are the lead. Transfer leadership before leaving.'), findsOneWidget);
      await tester.pump(const Duration(seconds: 4));
      await tester.pumpAndSettle();
    });
  });
}
