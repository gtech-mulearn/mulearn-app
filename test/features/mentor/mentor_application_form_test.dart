import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/session/mentor_application.dart';
import 'package:mulearn_app/core/session/session_providers.dart';
import 'package:mulearn_app/features/mentor/domain/entities/mentor_application_form.dart';
import 'package:mulearn_app/features/mentor/domain/repositories/mentor_applications_repository.dart';
import 'package:mulearn_app/features/mentor/presentation/providers/mentor_applications_providers.dart';
import 'package:mulearn_app/features/mentor/presentation/screens/mentor_application_form_screen.dart';

class _FakeRepo implements MentorApplicationsRepository {
  final sent = <MentorApplicationDraft>[];

  @override
  Future<String> submit(MentorApplicationDraft draft) async {
    sent.add(draft);
    return 'Mentor registration submitted successfully.';
  }

  @override
  Future<String> update(String id, MentorApplicationDraft draft) async {
    sent.add(draft);
    return 'Updated';
  }

  @override
  Future<MentorProfileSnapshot?> snapshot() async => null;

  @override
  Future<List<MentorChoice>> interestGroups() async => const [
    (id: 'ig1', name: 'Web Development'),
    (id: 'ig2', name: 'Robotics'),
  ];

  @override
  Future<List<MentorChoice>> companies() async => const [
    (id: 'acme', name: 'Acme Labs'),
  ];

  @override
  Future<List<MentorChoice>> searchColleges(String query) async => const [];
}

void main() {
  Future<_FakeRepo> pump(
    WidgetTester tester, {
    List<MentorApplication> apps = const [],
    MentorProfileSnapshot? snapshot,
    String? editId,
  }) async {
    final repo = _FakeRepo();
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, __) => MentorApplicationFormScreen(editId: editId),
        ),
      ],
    );
    await tester.binding.setSurfaceSize(const Size(420, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          mentorApplicationsRepositoryProvider.overrideWithValue(repo),
          mentorProfileSnapshotProvider.overrideWith((ref) async => snapshot),
          mentorApplicationsProvider.overrideWith((ref) async => apps),
        ],
        child: MaterialApp.router(
          theme: MuThemeData.light(),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    return repo;
  }

  testWidgets('missing answers are pointed out and nothing is sent', (
    tester,
  ) async {
    final repo = await pump(tester);
    await tester.tap(find.text('Send application'));
    await tester.pumpAndSettle();
    expect(repo.sent, isEmpty);
    expect(find.text('Pick at least one Interest Group.'), findsWidgets);
    expect(
      find.text(
        'Add at least ${MentorApplicationDraft.expertiseMin} areas of expertise.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('with an IG Mentor application open, that tier is locked', (
    tester,
  ) async {
    await pump(
      tester,
      apps: const [
        MentorApplication(id: 'a1', status: 'PENDING', mentorTier: 'IG_MENTOR'),
      ],
    );
    expect(
      find.text('You already have an IG Mentor application.'),
      findsOneWidget,
    );
  });

  testWidgets('an edit keeps its tier and organisation fixed', (tester) async {
    await pump(
      tester,
      editId: 'a1',
      apps: const [
        MentorApplication(
          id: 'a1',
          status: 'PENDING',
          mentorTier: 'COMPANY_MENTOR',
        ),
      ],
      snapshot: const MentorProfileSnapshot(
        applications: [
          MentorApplicationAnswers(
            id: 'a1',
            tier: MentorTier.company,
            organization: (id: 'acme', name: 'Acme Labs'),
          ),
        ],
      ),
    );
    expect(find.text('Edit your application'), findsOneWidget);
    expect(find.text('Acme Labs'), findsOneWidget);
    expect(find.text('How you’ll mentor'), findsNothing);
    expect(find.text('Save changes'), findsOneWidget);
  });
}
