import 'package:mulearn_app/core/auth/app_auth_controller.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/auth/domain/entities/company_details.dart';
import 'package:mulearn_app/features/auth/domain/entities/registration_role.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_providers.dart';
import 'package:mulearn_app/features/auth/presentation/providers/register_wizard_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_submit_controller.g.dart';

/// Organization type picked for the Student ("Company" vs "College" employer)
/// and Mentor role-details forms.
enum OrganizationType { college, company }

extension OrganizationTypeApi on OrganizationType {
  String get apiValue =>
      this == OrganizationType.college ? 'College' : 'Company';
}

/// Performs the actual registration submission — the same multi-call
/// sequence as the reference `register-client.tsx`'s `handleGenericSignup`/
/// `handleCompanySignup`: create the account, then (for student/mentor/
/// enabler) link an organization, or (for company) create the company record.
///
/// Exposes `AsyncValue<void>` for automatic loading/error state (rules.md §4).
@riverpod
class RegisterSubmitController extends _$RegisterSubmitController {
  @override
  FutureOr<void> build() {}

  /// Student / Mentor / Enabler path.
  ///
  /// [college]/[customCollege]/[department]/[graduationYear] apply to the
  /// College branch (student + enabler); [organization]/[customOrganization]
  /// apply to the Company branch (student) or are always used (mentor).
  /// [organizationType] is only meaningful for student/mentor.
  Future<void> submitGeneric({
    required RegistrationRole role,
    String? college,
    String? customCollege,
    String? department,
    int? graduationYear,
    String? organization,
    String? customOrganization,
    OrganizationType? organizationType,
  }) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final wizard = ref.read(registerWizardControllerProvider);
      final fullName = wizard.fullName;
      final email = wizard.email;
      final password = wizard.password;
      if (fullName == null || email == null || password == null) {
        throw const ApiException(message: 'Missing basic info. Please start over.');
      }

      final roles = await ref.read(registerRolesProvider.future);
      final roleId = resolveRoleId(roles, role.apiTitle);
      if (roleId == null) {
        throw ApiException(
          message: 'Role list has not loaded yet or "${role.apiTitle}" not '
              'found. Please try again.',
        );
      }

      final repo = ref.read(registerRepositoryProvider);
      await repo.registerUser(
        fullName: fullName,
        email: email,
        password: password,
        roleId: roleId,
      );
      ref.read(appAuthControllerProvider.notifier).setSignedIn();

      // Now authenticated — handle org linking.
      if (role == RegistrationRole.student &&
          organizationType == OrganizationType.company) {
        if (organization == 'others' && customOrganization != null) {
          await repo.createOrganization(
            title: customOrganization,
            orgType: 'Company',
          );
        } else if (organization != null) {
          await repo.selectOrganization(
            organization: organization,
            isStudent: true,
          );
        }
        return;
      }

      if (role == RegistrationRole.student || role == RegistrationRole.enabler) {
        final isStudent = role == RegistrationRole.student;
        if (college == 'others' && customCollege != null) {
          await repo.createOrganization(
            title: customCollege,
            orgType: 'College',
            department: isStudent ? department : null,
            graduationYear: isStudent ? graduationYear : null,
          );
        } else if (college != null) {
          await repo.selectOrganization(
            organization: college,
            isStudent: isStudent,
            department: isStudent ? department : null,
            graduationYear: isStudent ? graduationYear : null,
          );
        }
        return;
      }

      if (role == RegistrationRole.mentor) {
        if (organization == 'others' && customOrganization != null) {
          final orgType = organizationType ?? OrganizationType.company;
          final isCollege = orgType == OrganizationType.college;
          await repo.createOrganization(
            title: customOrganization,
            orgType: orgType.apiValue,
            department: isCollege ? department : null,
            graduationYear: isCollege ? graduationYear : null,
          );
        } else if (organization != null) {
          await repo.selectOrganization(
            organization: organization,
            isStudent: false,
            department: department,
            graduationYear: graduationYear,
          );
        }
      }
    });
    if (state.hasError) {
      Error.throwWithStackTrace(state.error!, state.stackTrace ?? StackTrace.current);
    }
  }

  /// Company path: register the POC user, then create the company record.
  Future<void> submitCompany(CompanyDetails details) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final wizard = ref.read(registerWizardControllerProvider);
      final fullName = wizard.fullName;
      final email = wizard.email;
      final password = wizard.password;
      if (fullName == null || email == null || password == null) {
        throw const ApiException(message: 'Missing basic info. Please start over.');
      }

      final roles = await ref.read(registerRolesProvider.future);
      final roleId = resolveRoleId(roles, RegistrationRole.company.apiTitle);
      if (roleId == null) {
        throw const ApiException(
          message: 'Role list has not loaded yet or "Company" not found. '
              'Please try again.',
        );
      }

      final repo = ref.read(registerRepositoryProvider);
      await repo.registerUser(
        fullName: fullName,
        email: email,
        password: password,
        roleId: roleId,
      );
      ref.read(appAuthControllerProvider.notifier).setSignedIn();

      await repo.registerCompany(details);
    });
    if (state.hasError) {
      Error.throwWithStackTrace(state.error!, state.stackTrace ?? StackTrace.current);
    }
  }
}
