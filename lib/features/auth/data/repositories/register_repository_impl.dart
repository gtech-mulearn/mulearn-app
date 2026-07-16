import 'package:dio/dio.dart';
import 'package:mulearn_app/core/data/location_remote_datasource.dart';
import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/models/reference_option_dto.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/auth_token_parser.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/register_remote_datasource.dart';
import 'package:mulearn_app/features/auth/domain/entities/auth_session.dart';
import 'package:mulearn_app/features/auth/domain/entities/company_details.dart';
import 'package:mulearn_app/features/auth/domain/repositories/register_repository.dart';

class RegisterRepositoryImpl implements RegisterRepository {
  const RegisterRepositoryImpl({
    required RegisterRemoteDataSource remote,
    required LocationRemoteDataSource locationRemote,
    required TokenStorage tokenStorage,
  })  : _remote = remote,
        _locationRemote = locationRemote,
        _tokenStorage = tokenStorage;

  final RegisterRemoteDataSource _remote;
  final LocationRemoteDataSource _locationRemote;
  final TokenStorage _tokenStorage;

  @override
  Future<List<ReferenceOption>> fetchRoles() =>
      _fetchReferenceOptions(_remote.fetchRoles);

  @override
  Future<List<ReferenceOption>> fetchColleges() =>
      _fetchReferenceOptions(_remote.fetchColleges);

  @override
  Future<List<ReferenceOption>> fetchDepartments() =>
      _fetchReferenceOptions(_remote.fetchDepartments);

  @override
  Future<List<ReferenceOption>> fetchCompanies() =>
      _fetchReferenceOptions(_remote.fetchCompanies);

  @override
  Future<List<LocationOption>> fetchCountries() async {
    try {
      return await _locationRemote.fetchCountries();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<LocationOption>> fetchStates(String countryId) async {
    try {
      return await _locationRemote.fetchStates(countryId);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<List<LocationOption>> fetchDistricts(String stateId) async {
    try {
      return await _locationRemote.fetchDistricts(stateId);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<List<ReferenceOption>> _fetchReferenceOptions(
    Future<List<dynamic>> Function() fetch,
  ) async {
    try {
      final items = await fetch();
      return items
          .cast<Map<String, dynamic>>()
          .map((json) => ReferenceOptionDto.fromJson(json).toDomain())
          .toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<AuthSession> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String roleId,
    String? referralMuid,
  }) async {
    try {
      final payload = await _remote.register(
        fullName: fullName,
        email: email,
        password: password,
        roleId: roleId,
        referralMuid: referralMuid,
      );

      final tokens = AuthTokenParser.tryParse(payload);
      if (tokens == null) {
        throw const ApiException(
          message: 'Registered, but could not read the auth tokens from the '
              'response.',
        );
      }

      await _tokenStorage.saveTokens(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
      return AuthSession(
        accessToken: tokens.accessToken,
        refreshToken: tokens.refreshToken,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> registerCompany(CompanyDetails details) async {
    try {
      await _remote.registerCompany(details);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> selectOrganization({
    required String organization,
    required bool isStudent,
    String? department,
    int? graduationYear,
  }) async {
    try {
      await _remote.selectOrganization(
        organization: organization,
        isStudent: isStudent,
        department: department,
        graduationYear: graduationYear,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> createOrganization({
    required String title,
    String? orgType,
    String? department,
    int? graduationYear,
  }) async {
    try {
      await _remote.createOrganization(
        title: title,
        orgType: orgType,
        department: department,
        graduationYear: graduationYear,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> selectDomains(List<String> domains) async {
    try {
      await _remote.selectDomains(domains);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<void> selectEndgoals(List<String> endgoals) async {
    try {
      await _remote.selectEndgoals(endgoals);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
