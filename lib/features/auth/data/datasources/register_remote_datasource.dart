import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for registration + onboarding-lookup endpoints. Returns
/// already-unwrapped `response` payloads; DTO parsing happens in the
/// repository.
class RegisterRemoteDataSource {
  const RegisterRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<dynamic>> fetchRoles() => _fetchList(
        ApiPaths.registerRoles,
        key: 'roles',
      );

  Future<List<dynamic>> fetchColleges() => _fetchList(
        ApiPaths.registerColleges,
        key: 'colleges',
      );

  Future<List<dynamic>> fetchDepartments() => _fetchList(
        ApiPaths.registerDepartments,
        key: 'departments',
      );

  Future<List<dynamic>> fetchCompanies() => _fetchList(
        ApiPaths.registerCompanies,
        key: 'companies',
      );

  Future<List<dynamic>> _fetchList(String path, {required String key}) async {
    final response = await _dio.get<dynamic>(
      path,
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    final payload = ApiEnvelope.unwrapObject(response);
    return payload[key] as List<dynamic>;
  }

  /// `POST /api/v1/register/` — creates the account. Unauthenticated.
  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required String roleId,
    String? referralMuid,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.register,
      data: {
        'user': {
          'full_name': fullName,
          'email': email,
          'password': password,
          'role': roleId,
        },
        if (referralMuid != null) 'referral': {'muid': referralMuid},
      },
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    return ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/register/` with the authserver's Google `tempToken`. The
  /// backend takes the email from the token (any client email is ignored)
  /// and creates the account without a password, so neither is sent.
  Future<Map<String, dynamic>> registerWithGoogle({
    required String tempToken,
    required String fullName,
    required String roleId,
    String? referralMuid,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.register,
      data: {
        'tempToken': tempToken,
        'user': {'full_name': fullName, 'role': roleId},
        if (referralMuid != null) 'referral': {'muid': referralMuid},
      },
      options: Options(headers: {RequestFlags.skipAuth: true}),
    );
    return ApiEnvelope.unwrapObject(response);
  }


  /// `POST /api/v1/dashboard/user/organization/` — authenticated.
  Future<void> selectOrganization({
    required String organization,
    required bool isStudent,
    String? department,
    int? graduationYear,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.selectOrganization,
      data: {
        'organization': organization,
        'department': department,
        'graduation_year': graduationYear,
        'is_student': isStudent,
      },
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/register/organization/create/` — authenticated.
  ///
  /// [graduationYear] is an `int` per the confirmed OpenAPI contract — an
  /// earlier pass had this as a numeric string, following the reference
  /// dashboard's client-side `.toString()` transform, which turned out to be
  /// a frontend quirk rather than what the backend actually expects.
  Future<void> createOrganization({
    required String title,
    String? orgType,
    String? department,
    int? graduationYear,
  }) async {
    final body = <String, dynamic>{
      'title': title,
      'org_type': orgType,
      'department': department,
      'graduation_year': graduationYear,
    }..removeWhere((_, value) => value == null);

    final response =
        await _dio.post<dynamic>(ApiPaths.createOrganization, data: body);
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/register/select-domains/` — authenticated.
  Future<void> selectDomains(List<String> domains) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.selectDomains,
      data: {'domains': domains},
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/register/select-endgoals/` — authenticated.
  Future<void> selectEndgoals(List<String> endgoals) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.selectEndgoals,
      data: {'endgoals': endgoals},
    );
    ApiEnvelope.unwrapObject(response);
  }
}
