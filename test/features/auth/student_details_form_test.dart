import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/design_system/design_system.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/repositories/register_repository.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';
import 'package:mulearn_app/features/auth/presentation/widgets/student_details_form.dart';

class _MockRepo extends Mock implements RegisterRepository {}

class _MockTokenStorage extends Mock implements TokenStorage {}

/// The learner step: "I'm not a student" and School / College / Company /
/// Community, matching the dashboard's learner form (2026-11-23).
void main() {
  late _MockRepo repo;
  late _MockTokenStorage tokens;
  var submitted = 0;

  setUp(() {
    submitted = 0;
    repo = _MockRepo();
    tokens = _MockTokenStorage();
    when(() => tokens.hasSession()).thenAnswer((_) async => false);
    when(() => repo.fetchRoles()).thenAnswer(
      (_) async => const [
        ReferenceOption(id: 'role-student', title: 'Student'),
      ],
    );
    when(() => repo.fetchDepartments()).thenAnswer((_) async => const []);
    when(() => repo.fetchCompanies()).thenAnswer(
      (_) async => const [ReferenceOption(id: 'co1', title: 'Faya')],
    );
    when(() => repo.fetchCommunities()).thenAnswer(
      (_) async => const [ReferenceOption(id: 'cm1', title: 'Flutter Kerala')],
    );
    when(() => repo.searchDistricts(any())).thenAnswer((_) async => const []);
    when(() => repo.fetchSchools(any())).thenAnswer((_) async => const []);
    when(
      () => repo.registerUser(
        fullName: any(named: 'fullName'),
        email: any(named: 'email'),
        password: any(named: 'password'),
        roleId: any(named: 'roleId'),
        referralMuid: any(named: 'referralMuid'),
      ),
    ).thenAnswer(
      (_) async => const AuthSession(accessToken: 'a', refreshToken: 'r'),
    );
    when(
      () => repo.selectOrganization(
        organization: any(named: 'organization'),
        isStudent: any(named: 'isStudent'),
        department: any(named: 'department'),
        graduationYear: any(named: 'graduationYear'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => repo.createOrganization(
        title: any(named: 'title'),
        orgType: any(named: 'orgType'),
        department: any(named: 'department'),
        graduationYear: any(named: 'graduationYear'),
      ),
    ).thenAnswer((_) async {});
  });

  Future<void> pump(WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: [
        registerRepositoryProvider.overrideWithValue(repo),
        tokenStorageProvider.overrideWithValue(tokens),
      ],
    );
    addTearDown(container.dispose);
    container
        .read(registerWizardControllerProvider.notifier)
        .setBasicInfo(
          fullName: 'Ada Lovelace',
          email: 'ada@mulearn.org',
          password: 'supersecret',
        );
    tester.view.physicalSize = const Size(1080, 4200);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: StudentDetailsForm(onSubmitted: () => submitted++),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder tile(String title) => find.ancestor(
    of: find.text(title),
    matching: find.byWidgetPredicate((w) => w is MuChoiceTile),
  );

  Future<void> tapAndSettle(WidgetTester tester, Finder finder) async {
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> turnOnNotAStudent(WidgetTester tester) =>
      tapAndSettle(tester, find.text("I'm not a student"));

  Future<void> finish(WidgetTester tester) =>
      tapAndSettle(tester, find.text('Finish sign-up'));

  testWidgets('studying shows four types', (tester) async {
    await pump(tester);

    for (final t in ['School', 'College', 'Company', 'Community']) {
      expect(tile(t), findsOneWidget, reason: t);
    }
  });

  testWidgets('not a student shows company and community only', (tester) async {
    await pump(tester);
    await turnOnNotAStudent(tester);

    expect(tile('School'), findsNothing);
    expect(tile('College'), findsNothing);
    expect(tile('Company'), findsOneWidget);
    expect(tile('Community'), findsOneWidget);
    expect(
      tester.getSemantics(find.bySemanticsLabel('Company')),
      isSemantics(isChecked: true),
    );
  });

  testWidgets('not a student falls back to company', (tester) async {
    await pump(tester);
    await turnOnNotAStudent(tester);
    await tapAndSettle(tester, find.text('Search your company'));
    await tapAndSettle(tester, find.text('Faya'));
    await finish(tester);

    expect(find.text('Pick your college to continue.'), findsNothing);
    verify(
      () => repo.selectOrganization(organization: 'co1', isStudent: false),
    ).called(1);
    expect(submitted, 1);
  });

  testWidgets('community pick submits the community', (tester) async {
    await pump(tester);
    await turnOnNotAStudent(tester);
    await tapAndSettle(tester, tile('Community'));
    await tapAndSettle(tester, find.text('Select your community'));
    await tapAndSettle(tester, find.text('Flutter Kerala'));
    await finish(tester);

    verify(
      () => repo.selectOrganization(organization: 'cm1', isStudent: false),
    ).called(1);
  });

  testWidgets('switching type clears the pick', (tester) async {
    await pump(tester);
    await turnOnNotAStudent(tester);
    await tapAndSettle(tester, find.text('Search your company'));
    await tapAndSettle(tester, find.text('Faya'));
    await tapAndSettle(tester, tile('Community'));
    await finish(tester);

    expect(find.text('Pick your community to continue.'), findsOneWidget);
    verifyNever(
      () => repo.selectOrganization(
        organization: any(named: 'organization'),
        isStudent: any(named: 'isStudent'),
      ),
    );
    expect(submitted, 0);
  });

  testWidgets('re-tapping the chosen type keeps the pick', (tester) async {
    await pump(tester);
    await turnOnNotAStudent(tester);
    await tapAndSettle(tester, find.text('Search your company'));
    await tapAndSettle(tester, find.text('Faya'));
    await tapAndSettle(tester, tile('Company'));
    await finish(tester);

    verify(
      () => repo.selectOrganization(organization: 'co1', isStudent: false),
    ).called(1);
  });

  /// School → pick the district in the search sheet.
  Future<void> pickDistrict(WidgetTester tester) async {
    when(() => repo.searchDistricts('kott')).thenAnswer(
      (_) async => const [
        ReferenceOption(id: 'd1', title: 'Kottayam, Kerala, India'),
      ],
    );
    when(() => repo.fetchSchools('d1')).thenAnswer(
      (_) async => const [ReferenceOption(id: 's1', title: 'Govt HSS Palai')],
    );
    await tapAndSettle(tester, find.text('Search your district'));
    await tester.enterText(find.byType(TextField).last, 'kott');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();
    await tapAndSettle(tester, find.text('Kottayam, Kerala, India'));
  }

  testWidgets('the school list waits for a district', (tester) async {
    await pump(tester);
    await tapAndSettle(tester, tile('School'));

    await tapAndSettle(tester, find.text('Pick your district first'));
    expect(find.text('My school is not listed'), findsNothing);
    expect(find.textContaining('Nothing matches'), findsNothing);

    await pickDistrict(tester);
    await tapAndSettle(tester, find.text('Select your school'));
    await tapAndSettle(tester, find.text('Govt HSS Palai'));
    await finish(tester);

    verify(
      () => repo.selectOrganization(organization: 's1', isStudent: true),
    ).called(1);
  });

  testWidgets('a school not listed keeps its district', (tester) async {
    await pump(tester);
    await tapAndSettle(tester, tile('School'));
    await pickDistrict(tester);
    await tapAndSettle(tester, find.text('Select your school'));
    await tapAndSettle(tester, find.text('My school is not listed'));
    expect(find.text('District'), findsOneWidget);

    await tester.enterText(find.byType(TextField).last, 'Govt HSS Pala');
    await finish(tester);

    verify(
      () => repo.createOrganization(title: 'Govt HSS Pala', orgType: 'School'),
    ).called(1);
    expect(submitted, 1);
  });
}
