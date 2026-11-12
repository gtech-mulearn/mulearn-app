import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the interest-group directory and the current user's
/// own membership, returning unwrapped JSON for the repository to map.
class InterestGroupsRemoteDataSource {
  InterestGroupsRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/ig/list/` — `response.interestGroup`.
  Future<List<dynamic>> fetchCatalog() async {
    final response = await _dio.get<dynamic>(ApiPaths.interestGroupsList);
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['interestGroup'] as List<dynamic>;
  }

  /// `GET /api/v1/public/ig/{id}/` — `response.interestGroup` (singular
  /// object, same rich shape as one entry in [fetchCatalog]).
  Future<Map<String, dynamic>> fetchDetail(String id) async {
    final response = await _dio.get<dynamic>(ApiPaths.interestGroupDetail(id));
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['interestGroup'] as Map<String, dynamic>;
  }


  /// `PATCH /api/v1/dashboard/profile/ig-edit/` `{"interest_group": ids}`.
  Future<void> setMyGroupIds(List<String> groupIds) async {
    final response = await _dio.patch<dynamic>(
      ApiPaths.editInterestGroups,
      data: {'interest_group': groupIds},
    );
    ApiEnvelope.unwrapObject(response);
  }
}
