import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/entities/company_details.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/domain/repositories/register_repository.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_submit_controller.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late MockRegisterRepository repository;
  late MockTokenStorage tokenStorage;

  const roles = [
    ReferenceOption(id: 'role-student', title: 'Student'),
    ReferenceOption(id: 'role-mentor', title: 'Mentor'),
    ReferenceOption(id: 'role-enabler', title: 'Enabler'),
    ReferenceOption(id: 'role-company', title: 'Company'),
  ];

  const session = AuthSession(accessToken: 'a', refreshToken: 'r');

  setUpAll(() {
    registerFallbackValue(
      const CompanyDetails(companyName: '', companyDescription: ''),
    );
  });

  setUp(() {
    repository = MockRegisterRepository();
    tokenStorage = MockTokenStorage();
    when(() => tokenStorage.hasSession()).thenAnswer((_) async => false);
    when(() => repository.fetchRoles()).thenAnswer((_) async => roles);
    when(
      () => repository.registerUser(
        fullName: any(named: 'fullName'),
        email: any(named: 'email'),
        password: any(named: 'password'),
        roleId: any(named: 'roleId'),
        referralMuid: any(named: 'referralMuid'),
      ),
    ).thenAnswer((_) async => session);
  });

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        registerRepositoryProvider.overrideWithValue(repository),
        tokenStorageProvider.overrideWithValue(tokenStorage),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  ProviderContainer containerWithBasicInfo() {
    final container = makeContainer();
    container.read(registerWizardControllerProvider.notifier).setBasicInfo(
          fullName: 'Ada Lovelace',
          email: 'ada@mulearn.org',
          password: 'supersecret',
        );
    return container;
  }

  group('submitGeneric — student', () {
    test('College branch selects an existing college', () async {
      when(
        () => repository.selectOrganization(
          organization: any(named: 'organization'),
          isStudent: any(named: 'isStudent'),
          department: any(named: 'department'),
          graduationYear: any(named: 'graduationYear'),
        ),
      ).thenAnswer((_) async {});

      final container = containerWithBasicInfo();
      await container.read(appAuthControllerProvider.future);

      await container.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.student,
            college: 'college-1',
            department: 'dept-1',
            graduationYear: 2027,
          );

      verify(
        () => repository.registerUser(
          fullName: 'Ada Lovelace',
          email: 'ada@mulearn.org',
          password: 'supersecret',
          roleId: 'role-student',
        ),
      ).called(1);
      verify(
        () => repository.selectOrganization(
          organization: 'college-1',
          isStudent: true,
          department: 'dept-1',
          graduationYear: 2027,
        ),
      ).called(1);
      verifyNever(() => repository.createOrganization(title: any(named: 'title')));
      expect(container.read(appAuthControllerProvider).value, isTrue);
    });

    test('College branch with "others" creates a new college for review', () async {
      when(
        () => repository.createOrganization(
          title: any(named: 'title'),
          orgType: any(named: 'orgType'),
          department: any(named: 'department'),
          graduationYear: any(named: 'graduationYear'),
        ),
      ).thenAnswer((_) async {});

      final container = containerWithBasicInfo();
      await container.read(appAuthControllerProvider.future);

      await container.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.student,
            college: 'others',
            customCollege: 'My New College',
            department: 'dept-1',
            graduationYear: 2027,
          );

      verify(
        () => repository.createOrganization(
          title: 'My New College',
          orgType: 'College',
          department: 'dept-1',
          graduationYear: 2027,
        ),
      ).called(1);
    });

    test('Company-employed branch selects an existing company', () async {
      when(
        () => repository.selectOrganization(
          organization: any(named: 'organization'),
          isStudent: any(named: 'isStudent'),
          department: any(named: 'department'),
          graduationYear: any(named: 'graduationYear'),
        ),
      ).thenAnswer((_) async {});

      final container = containerWithBasicInfo();
      await container.read(appAuthControllerProvider.future);

      await container.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.student,
            organization: 'company-1',
            organizationType: OrganizationType.company,
          );

      verify(
        () => repository.selectOrganization(
          organization: 'company-1',
          isStudent: true,
        ),
      ).called(1);
    });
  });

  test('submitGeneric — enabler links a college', () async {
    when(
      () => repository.selectOrganization(
        organization: any(named: 'organization'),
        isStudent: any(named: 'isStudent'),
        department: any(named: 'department'),
        graduationYear: any(named: 'graduationYear'),
      ),
    ).thenAnswer((_) async {});

    final container = containerWithBasicInfo();
    await container.read(appAuthControllerProvider.future);

    await container.read(registerSubmitControllerProvider.notifier).submitGeneric(
          role: RegistrationRole.enabler,
          college: 'college-1',
        );

    verify(
      () => repository.registerUser(
        fullName: 'Ada Lovelace',
        email: 'ada@mulearn.org',
        password: 'supersecret',
        roleId: 'role-enabler',
      ),
    ).called(1);
    verify(
      () => repository.selectOrganization(organization: 'college-1', isStudent: false),
    ).called(1);
  });

  group('submitGeneric — mentor', () {
    test('College type sends department + graduation year', () async {
      when(
        () => repository.selectOrganization(
          organization: any(named: 'organization'),
          isStudent: any(named: 'isStudent'),
          department: any(named: 'department'),
          graduationYear: any(named: 'graduationYear'),
        ),
      ).thenAnswer((_) async {});

      final container = containerWithBasicInfo();
      await container.read(appAuthControllerProvider.future);

      await container.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.mentor,
            organization: 'college-1',
            department: 'dept-1',
            graduationYear: 2025,
            organizationType: OrganizationType.college,
          );

      verify(
        () => repository.selectOrganization(
          organization: 'college-1',
          isStudent: false,
          department: 'dept-1',
          graduationYear: 2025,
        ),
      ).called(1);
    });

    test('Company type omits department/graduation year', () async {
      when(
        () => repository.selectOrganization(
          organization: any(named: 'organization'),
          isStudent: any(named: 'isStudent'),
          department: any(named: 'department'),
          graduationYear: any(named: 'graduationYear'),
        ),
      ).thenAnswer((_) async {});

      final container = containerWithBasicInfo();
      await container.read(appAuthControllerProvider.future);

      await container.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.mentor,
            organization: 'company-1',
            organizationType: OrganizationType.company,
          );

      verify(
        () => repository.selectOrganization(
          organization: 'company-1',
          isStudent: false,
        ),
      ).called(1);
    });
  });

  test('submitGeneric throws when the role is not found in the role list', () async {
    when(() => repository.fetchRoles()).thenAnswer((_) async => const []);

    final container = containerWithBasicInfo();
    await container.read(appAuthControllerProvider.future);

    await expectLater(
      container.read(registerSubmitControllerProvider.notifier).submitGeneric(
            role: RegistrationRole.student,
            college: 'college-1',
          ),
      throwsA(anything),
    );

    verifyNever(
      () => repository.registerUser(
        fullName: any(named: 'fullName'),
        email: any(named: 'email'),
        password: any(named: 'password'),
        roleId: any(named: 'roleId'),
        referralMuid: any(named: 'referralMuid'),
      ),
    );
    expect(container.read(appAuthControllerProvider).value, isFalse);
  });

  test('submitCompany registers the POC user then creates the company', () async {
    when(() => repository.registerCompany(any())).thenAnswer((_) async {});

    final container = containerWithBasicInfo();
    await container.read(appAuthControllerProvider.future);

    const details = CompanyDetails(
      companyName: 'Acme Inc',
      companyDescription: 'We build things.',
    );

    await container
        .read(registerSubmitControllerProvider.notifier)
        .submitCompany(details);

    verify(
      () => repository.registerUser(
        fullName: 'Ada Lovelace',
        email: 'ada@mulearn.org',
        password: 'supersecret',
        roleId: 'role-company',
      ),
    ).called(1);
    verify(() => repository.registerCompany(details)).called(1);
    expect(container.read(appAuthControllerProvider).value, isTrue);
  });
}
