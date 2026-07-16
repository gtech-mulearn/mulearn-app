import 'package:dio/dio.dart';
import 'package:mulearn_app/core/models/location_option.dart';
import 'package:mulearn_app/core/models/location_option_dto.dart';
import 'package:mulearn_app/core/models/reference_option.dart';
import 'package:mulearn_app/core/models/reference_option_dto.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_remote_datasource.g.dart';

@riverpod
LocationRemoteDataSource locationRemoteDataSource(Ref ref) =>
    LocationRemoteDataSource(ref.watch(dioProvider));

/// Shared country/state/district/community/college/school reference-data
/// lookups (rules.md §2 — promoted here once a second feature, `profile`'s
/// college-change picker, needed the same lists the `auth` registration flow
/// already used). Returns mapped domain objects directly — a thin exception
/// to the usual datasource-returns-raw-json convention, justified by there
/// being no feature-owned repository layer in `core/` to do the mapping.
class LocationRemoteDataSource {
  const LocationRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/register/country/list/`.
  Future<List<LocationOption>> fetchCountries() =>
      _fetchLocationOptions(ApiPaths.registerCountries, key: 'countries');

  /// `POST /api/v1/register/state/list/` `{"country": countryId}`.
  Future<List<LocationOption>> fetchStates(String countryId) =>
      _postLocationOptions(
        ApiPaths.registerStates,
        body: {'country': countryId},
        key: 'states',
      );

  /// `POST /api/v1/register/district/list/` `{"state": stateId}`.
  Future<List<LocationOption>> fetchDistricts(String stateId) =>
      _postLocationOptions(
        ApiPaths.registerDistricts,
        body: {'state': stateId},
        key: 'districts',
      );

  /// `GET /api/v1/register/community/list/`.
  Future<List<ReferenceOption>> fetchCommunities() =>
      _fetchReferenceOptions(ApiPaths.registerCommunities, key: 'communities');

  /// `GET /api/v1/register/colleges/` — every college, unfiltered. Used by
  /// the college-picker (registration) and by learning-circle creation's
  /// `org` dropdown, which validates against this same id space.
  Future<List<ReferenceOption>> fetchAllColleges() =>
      _fetchReferenceOptions(ApiPaths.registerColleges, key: 'colleges');

  /// `POST /api/v1/register/college/list/` `{"district": districtId}` —
  /// colleges and departments in a district, for the college-change picker.
  Future<({List<ReferenceOption> colleges, List<ReferenceOption> departments})>
      fetchCollegesByDistrict(String districtId) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.collegesByDistrict,
      data: {'district': districtId},
    );
    final payload = ApiEnvelope.unwrapObject(response);
    return (
      colleges: _mapReferenceOptions(payload['colleges'] as List<dynamic>),
      departments:
          _mapReferenceOptions(payload['departments'] as List<dynamic>),
    );
  }

  /// `POST /api/v1/register/schools/list/` `{"district": districtId}`.
  Future<List<ReferenceOption>> fetchSchoolsByDistrict(
    String districtId,
  ) =>
      _postReferenceOptions(
        ApiPaths.schoolsByDistrict,
        body: {'district': districtId},
        key: 'schools',
      );

  Future<List<LocationOption>> _fetchLocationOptions(
    String path, {
    required String key,
  }) async {
    final response = await _dio.get<dynamic>(path);
    final payload = ApiEnvelope.unwrapObject(response);
    return _mapLocationOptions(payload[key] as List<dynamic>);
  }

  Future<List<LocationOption>> _postLocationOptions(
    String path, {
    required Map<String, dynamic> body,
    required String key,
  }) async {
    final response = await _dio.post<dynamic>(path, data: body);
    final payload = ApiEnvelope.unwrapObject(response);
    return _mapLocationOptions(payload[key] as List<dynamic>);
  }

  Future<List<ReferenceOption>> _fetchReferenceOptions(
    String path, {
    required String key,
  }) async {
    final response = await _dio.get<dynamic>(path);
    final payload = ApiEnvelope.unwrapObject(response);
    return _mapReferenceOptions(payload[key] as List<dynamic>);
  }

  Future<List<ReferenceOption>> _postReferenceOptions(
    String path, {
    required Map<String, dynamic> body,
    required String key,
  }) async {
    final response = await _dio.post<dynamic>(path, data: body);
    final payload = ApiEnvelope.unwrapObject(response);
    return _mapReferenceOptions(payload[key] as List<dynamic>);
  }

  List<LocationOption> _mapLocationOptions(List<dynamic> items) => items
      .cast<Map<String, dynamic>>()
      .map((json) => LocationOptionDto.fromJson(json).toDomain())
      .toList();

  List<ReferenceOption> _mapReferenceOptions(List<dynamic> items) => items
      .cast<Map<String, dynamic>>()
      .map((json) => ReferenceOptionDto.fromJson(json).toDomain())
      .toList();
}
