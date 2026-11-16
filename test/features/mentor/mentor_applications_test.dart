import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/mentor_application_dto.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/core/utils/clock.dart';
import 'package:mulearn_app/features/mentor/data/mentor_applications_data.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_application_form.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_applications_screen.dart';

import '../../support/fake_http_adapter.dart';

const _register = '/api/v1/dashboard/mentor/register/';
const _profile = '/api/v1/dashboard/mentor/profile/';

Map<String, dynamic> _ok(Object? response, [String message = 'Done']) => {
  'hasError': false,
  'statusCode': 200,
  'message': {
    'general': [message],
  },
  'response': response,
};

MentorApplicationDraft _draft({
  MentorTier tier = MentorTier.ig,
  MentorChoice? org,
  String about =
      'I build Flutter apps for a living and run a weekend coding club.',
  List<String> expertise = const ['Flutter', 'Dart', 'Firebase'],
  String reason = 'I want to help learners ship their first real app.',
  List<String> igs = const ['ig1'],
  String linkedin = '',
}) => MentorApplicationDraft(
  tier: tier,
  organization: org,
  about: about,
  expertise: expertise,
  reason: reason,
  preferredIgIds: igs,
  linkedin: linkedin,
);

MentorApplication _app(
  String status, {
  String id = 'a1',
  String tier = 'IG_MENTOR',
  String? org,
  String? reason,
  DateTime? at,
}) => MentorApplication(
  id: id,
  status: status,
  mentorTier: tier,
  organization: org,
  rejectionReason: reason,
  createdAt: at ?? DateTime.utc(2026, 11, 10),
);

void main() {
  group('where a mentor stands (the home tile)', () {
    test('no application: none', () {
      expect(MentorStanding.of(const []), MentorStanding.none);
    });

    test('any approved wins', () {
      expect(
        MentorStanding.of([_app('REJECTED'), _app('APPROVED', id: 'a2')]),
        MentorStanding.approved,
      );
    });

    test('one waiting is in review', () {
      expect(
        MentorStanding.of([_app('REJECTED'), _app('PENDING', id: 'a2')]),
        MentorStanding.pending,
      );
    });

    test('otherwise the newest decides', () {
      expect(
        MentorStanding.of([
          _app('GRANT_REVOKED', at: DateTime.utc(2026)),
          _app('REJECTED', id: 'a2', at: DateTime.utc(2026, 6)),
        ]),
        MentorStanding.rejected,
      );
    });
  });

  test("the status list's rejection reason and date are read", () {
    final a = MentorApplicationDto.fromJson(const {
      'id': 'a1',
      'status': 'REJECTED',
      'mentor_tier': 'CAMPUS_MENTOR',
      'organization': 'CET',
      'created_at': '2026-11-12T16:05:55Z',
      'rejection_reason': ' Add more about your teaching. ',
    }).toDomain();
    expect(a.isRejected, isTrue);
    expect(a.rejectionReason, 'Add more about your teaching.');
    expect(a.createdAt, DateTime.utc(2026, 11, 12, 16, 5, 55));
    expect(MentorTier.parse(a.mentorTier), MentorTier.campus);
  });

  group('the form rules (dashboard + backend)', () {
    test('a complete IG Mentor application has no problems', () {
      expect(_draft().problems(), isEmpty);
    });

    test('each short or missing answer says what to fix', () {
      final p = _draft(
        tier: MentorTier.company,
        about: 'Too short',
        expertise: const ['Flutter'],
        reason: 'Short',
        igs: const [],
        linkedin: 'github.com/me',
      ).problems();
      expect(p.keys, {
        MentorField.organization,
        MentorField.about,
        MentorField.expertise,
        MentorField.reason,
        MentorField.interestGroups,
        MentorField.linkedin,
      });
    });

    test('more than five Interest Groups is refused', () {
      expect(_draft(igs: List.generate(6, (i) => 'ig$i')).problems().keys, [
        MentorField.interestGroups,
      ]);
    });

    test('a LinkedIn profile link passes, with or without the scheme', () {
      expect(_draft(linkedin: 'linkedin.com/in/asha').problems(), isEmpty);
      expect(
        _draft(linkedin: 'https://www.linkedin.com/in/asha/').problems(),
        isEmpty,
      );
    });
  });

  group('requests', () {
    test(
      'a new application sends tier, organisation and joined expertise',
      () async {
        final adapter = FakeHttpAdapter({
          'POST $_register': (_) => FakeResponse(
            200,
            _ok(const {}, 'Mentor registration submitted successfully.'),
          ),
        });
        final repo = MentorApplicationsRepositoryImpl(
          MentorApplicationsRemoteDataSource(fakeDio(adapter)),
        );
        final message = await repo.submit(
          _draft(tier: MentorTier.campus, org: (id: 'cet', name: 'CET')),
        );
        expect(message, 'Mentor registration submitted successfully.');
        final body = adapter.requests.single.data as Map<String, dynamic>;
        expect(body['mentor_tier'], 'CAMPUS_MENTOR');
        expect(body['org'], 'cet');
        expect(body['expertise'], 'Flutter, Dart, Firebase');
        expect(body['preferred_ig_ids'], ['ig1']);
        expect(body.containsKey('id'), isFalse);
      },
    );

    test(
      'an edit names the application and leaves tier and org alone',
      () async {
        final adapter = FakeHttpAdapter({
          'PATCH $_register': (_) => FakeResponse(200, _ok(const {})),
        });
        final repo = MentorApplicationsRepositoryImpl(
          MentorApplicationsRemoteDataSource(fakeDio(adapter)),
        );
        await repo.update(
          'a1',
          _draft(tier: MentorTier.campus, org: (id: 'cet', name: 'CET')),
        );
        final body = adapter.requests.single.data as Map<String, dynamic>;
        expect(body['id'], 'a1');
        expect(body.containsKey('mentor_tier'), isFalse);
        expect(body.containsKey('org'), isFalse);
      },
    );

    test("the backend's refusal reaches the mentor", () async {
      final adapter = FakeHttpAdapter({
        'POST $_register': (_) => const FakeResponse(400, {
          'hasError': true,
          'statusCode': 400,
          'message': {
            'general': [
              'You already have an active or pending IG mentor application.',
            ],
          },
          'response': <String, Object>{},
        }),
      });
      final repo = MentorApplicationsRepositoryImpl(
        MentorApplicationsRemoteDataSource(fakeDio(adapter)),
      );
      expect(
        () => repo.submit(_draft()),
        throwsA(
          isA<ApiException>().having(
            (e) => e.message,
            'message',
            contains('already have an active or pending'),
          ),
        ),
      );
    });

    test('the profile fills the form (live dev shape, 2026-11-16)', () async {
      final adapter = FakeHttpAdapter({
        'GET $_profile': (_) => FakeResponse(
          200,
          _ok(const {
            'about': 'Mobile and web developer.',
            'expertise': 'Flutter, React, Django',
            'hours': '2-5',
            'linkedin': '',
            'applications': [
              {
                'id': 'a1',
                'mentor_tier': 'COMPANY_MENTOR',
                'org': 'acme',
                'org_name': 'Acme Labs',
                'reason': 'To give back.',
                'preferred_ig_ids': ['ig1', 'ig2'],
                'status': 'REJECTED',
              },
            ],
          }),
        ),
      });
      final repo = MentorApplicationsRepositoryImpl(
        MentorApplicationsRemoteDataSource(fakeDio(adapter)),
      );
      final s = (await repo.snapshot())!;
      expect(s.expertise, ['Flutter', 'React', 'Django']);
      expect(s.hours, '2-5');
      final a = s.application('a1')!;
      expect(a.tier, MentorTier.company);
      expect(a.organization, (id: 'acme', name: 'Acme Labs'));
      expect(a.preferredIgIds, ['ig1', 'ig2']);
    });

    // What dev sends a mentor before their first application: HTTP 400, the
    // 404 only in the envelope (seen on the phone 2026-11-16).
    test('no profile yet starts the form blank', () async {
      final adapter = FakeHttpAdapter({
        'GET $_profile': (_) => const FakeResponse(400, {
          'hasError': true,
          'statusCode': 404,
          'message': {
            'general': ['No approved mentor profiles found.'],
          },
          'response': <String, Object>{},
        }),
      });
      final repo = MentorApplicationsRepositoryImpl(
        MentorApplicationsRemoteDataSource(fakeDio(adapter)),
      );
      expect(await repo.snapshot(), isNull);
    });
  });

  group('the applications screen', () {
    Future<void> pump(WidgetTester tester, List<MentorApplication> apps) async {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, __) => const MentorApplicationsScreen(),
          ),
          GoRoute(
            path: '/mentor/apply',
            builder: (_, __) => const Text('FORM'),
          ),
        ],
      );
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            mentorApplicationsProvider.overrideWith((ref) async => apps),
            clockProvider.overrideWithValue(() => DateTime.utc(2026, 11, 16)),
          ],
          child: MaterialApp.router(
            theme: MuThemeData.light(),
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('with none: the three tiers and who decides', (tester) async {
      await pump(tester, const []);
      expect(find.text('Become a mentor'), findsOneWidget);
      for (final t in MentorTier.values) {
        expect(find.text(t.label), findsOneWidget);
      }
      expect(find.text('Apply to mentor'), findsOneWidget);
    });

    testWidgets('a rejected one shows why and offers to apply again', (
      tester,
    ) async {
      await pump(tester, [
        _app('REJECTED', reason: 'Add more about your teaching.'),
      ]);
      expect(find.text('Not approved'), findsOneWidget);
      expect(find.text('Add more about your teaching.'), findsOneWidget);
      expect(find.text('Apply again'), findsOneWidget);
    });

    testWidgets('one in review can be edited, and says who reviews it', (
      tester,
    ) async {
      await pump(tester, [
        _app('PENDING', tier: 'COMPANY_MENTOR', org: 'Acme Labs'),
      ]);
      expect(find.text('Under review'), findsOneWidget);
      expect(find.text('Acme Labs'), findsOneWidget);
      expect(find.textContaining('Your company reviews it'), findsOneWidget);
      await tester.tap(find.text('Edit application'));
      await tester.pumpAndSettle();
      expect(find.text('FORM'), findsOneWidget);
    });
  });
}
