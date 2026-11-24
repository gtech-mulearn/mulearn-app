import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/network/paging.dart';

/// The Team workspace's endpoints. Returns raw payloads; the repository maps
/// them. Every call needs a verified team role on the backend except the
/// three public pickers.
class TeamRemoteDataSource {
  const TeamRemoteDataSource(this._dio);

  final Dio _dio;

  /// `{count, page, page_size, results}`.
  Future<Map<String, dynamic>> fetchBroadcasts(int page) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          TeamPaths.broadcasts,
          queryParameters: PagePaging.query(page),
        ),
      );

  Future<void> sendToEveryone(Map<String, Object?> body) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.post<dynamic>(TeamPaths.sendToEveryone, data: body),
      );

  /// The updated row.
  Future<Map<String, dynamic>> updateBroadcast(
    String id,
    Map<String, Object?> body,
  ) async => ApiEnvelope.unwrapObject(
    await _dio.patch<dynamic>(TeamPaths.broadcastUpdate(id), data: body),
  );

  Future<void> deleteBroadcast(String id) async => ApiEnvelope.unwrapMessage(
    await _dio.delete<dynamic>(TeamPaths.broadcastDelete(id)),
  );

  Future<void> deleteAllBroadcasts() async => ApiEnvelope.unwrapMessage(
    await _dio.delete<dynamic>(TeamPaths.broadcastDeleteAll),
  );

  /// `{campaigns: [...]}`.
  Future<Map<String, dynamic>> fetchCampaigns() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(TeamPaths.campaigns));

  /// The saved campaign.
  Future<Map<String, dynamic>> createCampaign(
    Map<String, Object?> body,
  ) async => ApiEnvelope.unwrapObject(
    await _dio.post<dynamic>(TeamPaths.campaigns, data: body),
  );

  Future<void> campaignAction(String id, String action) async =>
      ApiEnvelope.unwrapMessage(
        await _dio.post<dynamic>(
          TeamPaths.campaignAction(id, action),
          data: <String, dynamic>{},
        ),
      );

  /// The backend's success message, if any.
  Future<String?> sendTestPush() async => ApiEnvelope.unwrapMessage(
    await _dio.post<dynamic>(TeamPaths.testPush, data: <String, dynamic>{}),
  );

  /// `{data, pagination}`.
  Future<Map<String, dynamic>> fetchActivity(
    int pageIndex, {
    String? action,
  }) async => ApiEnvelope.unwrapObject(
    await _dio.get<dynamic>(
      TeamPaths.activityLog,
      queryParameters: {
        ...PageIndexPaging.query(pageIndex),
        if (action != null && action.isNotEmpty) 'action': action,
      },
    ),
  );

  Future<Map<String, dynamic>> fetchRoles() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(TeamPaths.roles));

  Future<Map<String, dynamic>> fetchInterestGroups() async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(TeamPaths.interestGroups),
      );

  Future<Map<String, dynamic>> searchColleges(String query) async =>
      ApiEnvelope.unwrapObject(
        await _dio.get<dynamic>(
          TeamPaths.colleges,
          queryParameters: {'search': query, 'perPage': 20},
        ),
      );
}
