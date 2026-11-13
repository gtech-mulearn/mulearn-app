import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/paging.dart';

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
  Future<void> join(String id) async =>
      ApiEnvelope.unwrapObject(await _dio.post<dynamic>(ApiPaths.igJoin(id), data: <String, dynamic>{}));

  Future<void> leave(String id) async => ApiEnvelope.unwrapObject(await _dio.delete<dynamic>(ApiPaths.igLeave(id)));

  /// The first circles in the group (`learningcircle/list/?ig=`).
  Future<List<dynamic>> fetchCirclesInGroup(String igId) async {
    final body = ApiEnvelope.unwrapObject(await _dio.get<dynamic>(
      ApiPaths.circlesList,
      queryParameters: {...PageIndexPaging.query(1, perPage: 5), 'ig': igId},
    ));
    return body['data'] as List<dynamic>? ?? const [];
  }

  /// The first events scoped to the group (`events/?ig_id=`).
  Future<List<dynamic>> fetchEventsInGroup(String igId) async {
    final body = ApiEnvelope.unwrapObject(await _dio.get<dynamic>(
      ApiPaths.events,
      queryParameters: {...PageIndexPaging.query(1, perPage: 5), 'ig_id': igId},
    ));
    return body['data'] as List<dynamic>? ?? const [];
  }

}
