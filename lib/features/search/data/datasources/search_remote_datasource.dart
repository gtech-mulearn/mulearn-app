import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio call for the user-search endpoint, returning the unwrapped
/// `response` object (`{data, pagination}`). DTO parsing happens in the
/// repository.
class SearchRemoteDataSource {
  const SearchRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/user/search/`.
  Future<Map<String, dynamic>> searchUsers({
    required String query,
    required int pageIndex,
    required int perPage,
    String? role,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiPaths.userSearch,
      queryParameters: {
        'search': query,
        if (role != null) 'role': role,
        'pageIndex': pageIndex,
        'perPage': perPage,
      },
    );
    return ApiEnvelope.unwrapObject(response);
  }
}
