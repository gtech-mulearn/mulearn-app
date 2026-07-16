import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/entities/company_details.dart';

/// Registration + onboarding-lookup repository contract (rules.md §2/§5).
///
/// Kept as a separate contract from [AuthRepository] — a distinct set of
/// operations for a distinct flow — but the same `auth` feature, since
/// registration produces an [AuthSession] the same way sign-in does and the
/// two are tightly coupled (rules.md §2 forbids cross-feature imports; nesting
/// avoids inventing that boundary for what the reference implementation
/// itself treats as one `auth` feature).
abstract interface class RegisterRepository {
  /// `GET /api/v1/register/role/list/` — role UUIDs are resolved by
  /// case-insensitive title match against this list.
  Future<List<ReferenceOption>> fetchRoles();

  /// `GET /api/v1/register/colleges/`.
  Future<List<ReferenceOption>> fetchColleges();

  /// `GET /api/v1/register/department/list/`.
  Future<List<ReferenceOption>> fetchDepartments();

  /// `GET /api/v1/register/company/list/`.
  Future<List<ReferenceOption>> fetchCompanies();

  /// `GET /api/v1/register/country/list/`.
  Future<List<LocationOption>> fetchCountries();

  /// `POST /api/v1/register/state/list/` `{"country": countryId}`.
  Future<List<LocationOption>> fetchStates(String countryId);

  /// `POST /api/v1/register/district/list/` `{"state": stateId}`.
  Future<List<LocationOption>> fetchDistricts(String stateId);

  /// Creates a new user account (student/mentor/enabler, or the Company
  /// role's initial POC account), persists the returned tokens, and returns
  /// the session. Throws [ApiException] on failure.
  Future<AuthSession> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String roleId,
    String? referralMuid,
  });

  /// Creates the Company record for the Company role. Must be called after
  /// [registerUser] has already authenticated the POC user.
  ///
  /// Throws [ApiException] on failure.
  Future<void> registerCompany(CompanyDetails details);

  /// Links the newly-registered user to an existing college/company.
  /// Authenticated — must be called after [registerUser].
  ///
  /// Throws [ApiException] on failure.
  Future<void> selectOrganization({
    required String organization,
    required bool isStudent,
    String? department,
    int? graduationYear,
  });

  /// Submits a not-yet-listed college/company for admin review, linking the
  /// user to it. Authenticated — must be called after [registerUser].
  ///
  /// Throws [ApiException] on failure.
  Future<void> createOrganization({
    required String title,
    String? orgType,
    String? department,
    int? graduationYear,
  });

  /// `POST /api/v1/register/select-domains/` — saves chosen learning
  /// pathways. Authenticated.
  ///
  /// Throws [ApiException] on failure.
  Future<void> selectDomains(List<String> domains);

  /// `POST /api/v1/register/select-endgoals/` — saves chosen end goals.
  /// Authenticated.
  ///
  /// Throws [ApiException] on failure.
  Future<void> selectEndgoals(List<String> endgoals);
}
