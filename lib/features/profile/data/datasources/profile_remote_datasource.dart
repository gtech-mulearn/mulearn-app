import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the profile feature's endpoints, returning the
/// unwrapped `response` payload. DTO parsing happens in the repository.
class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/profile/`.
  Future<Map<String, dynamic>> fetchEditableProfile() async {
    final response = await _dio.get<dynamic>(ApiPaths.editableProfile);
    return ApiEnvelope.unwrapObject(response);
  }

  /// `PATCH /api/v1/dashboard/profile/`.
  Future<void> updateProfile(Map<String, dynamic> body) async {
    final response = await _dio.patch<dynamic>(
      ApiPaths.editableProfile,
      data: body,
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/profile/user-log/` — bare array `response`.
  Future<List<dynamic>> fetchUserLog() async {
    final response = await _dio.get<dynamic>(ApiPaths.userLog);
    return ApiEnvelope.unwrapList(response);
  }

  /// `GET /api/v1/dashboard/profile/get-user-levels/` — bare array `response`.
  Future<List<dynamic>> fetchUserLevels() async {
    final response = await _dio.get<dynamic>(ApiPaths.userLevels);
    return ApiEnvelope.unwrapList(response);
  }

  /// `GET /api/v1/dashboard/profile/socials/`.
  Future<Map<String, dynamic>> fetchSocials() async {
    final response = await _dio.get<dynamic>(ApiPaths.socials);
    return ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/profile/user-profile/{muid}/`.
  Future<Map<String, dynamic>> fetchPublicUserProfile(String muid) async {
    final response = await _dio.get<dynamic>(ApiPaths.publicUserProfile(muid));
    return ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/profile/user-log/{muid}/` — bare array `response`.
  Future<List<dynamic>> fetchPublicUserLog(String muid) async {
    final response = await _dio.get<dynamic>(ApiPaths.publicUserLog(muid));
    return ApiEnvelope.unwrapList(response);
  }

  /// `GET /api/v1/dashboard/profile/get-user-levels/{muid}/` — bare array
  /// `response`.
  Future<List<dynamic>> fetchPublicUserLevels(String muid) async {
    final response = await _dio.get<dynamic>(ApiPaths.publicUserLevels(muid));
    return ApiEnvelope.unwrapList(response);
  }

  /// `GET /api/v1/dashboard/profile/socials/{muid}/`.
  Future<Map<String, dynamic>> fetchPublicSocials(String muid) async {
    final response = await _dio.get<dynamic>(ApiPaths.publicSocials(muid));
    return ApiEnvelope.unwrapObject(response);
  }

  /// `PUT /api/v1/dashboard/profile/socials/edit/`.
  Future<void> updateSocials(Map<String, dynamic> body) async {
    final response = await _dio.put<dynamic>(ApiPaths.socialsEdit, data: body);
    ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/user/preferences/`.
  Future<Map<String, dynamic>> fetchUserPreferences() async {
    final response = await _dio.get<dynamic>(ApiPaths.userPreferences);
    return ApiEnvelope.unwrapObject(response);
  }

  /// `PATCH /api/v1/dashboard/user/preferences/`.
  Future<void> updateUserPreferences(Map<String, dynamic> body) async {
    final response = await _dio.patch<dynamic>(
      ApiPaths.userPreferences,
      data: body,
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/ig/list/` — `response.interestGroup`.
  Future<List<dynamic>> fetchInterestGroupsList() async {
    final response = await _dio.get<dynamic>(ApiPaths.interestGroupsList);
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['interestGroup'] as List<dynamic>;
  }

  /// `PATCH /api/v1/dashboard/profile/ig-edit/` `{"interest_group": ids}`.
  Future<void> updateInterestGroups(List<String> groupIds) async {
    final response = await _dio.patch<dynamic>(
      ApiPaths.editInterestGroups,
      data: {'interest_group': groupIds},
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/dashboard/profile/change-password/`.
  Future<void> changePassword({
    required String current,
    required String next,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.changePassword,
      data: {'current_password': current, 'password': next},
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `PUT /api/v1/dashboard/profile/share-user-profile/` `{"is_public"}`.
  Future<void> togglePublicProfile({required bool isPublic}) async {
    final response = await _dio.put<dynamic>(
      ApiPaths.shareUserProfile,
      data: {'is_public': isPublic},
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/profile/cover-pic/`.
  Future<String?> fetchCoverPic() async {
    final response = await _dio.get<dynamic>(ApiPaths.coverPic);
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['cover_pic'] as String?;
  }

  /// `POST /api/v1/dashboard/profile/cover-pic/` (multipart, field `cover`).
  Future<String?> uploadCoverPic(List<int> bytes, String filename) async {
    final formData = FormData.fromMap({'cover': imagePart(bytes, filename)});
    final response = await _tooLargeAsMessage(
      'Cover photo',
      () => _dio.post<dynamic>(ApiPaths.coverPic, data: formData),
    );
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['cover_pic'] as String?;
  }

  /// `DELETE /api/v1/dashboard/profile/cover-pic/`.
  Future<void> deleteCoverPic() async {
    final response = await _dio.delete<dynamic>(ApiPaths.coverPic);
    ApiEnvelope.unwrapObject(response);
  }

  /// `POST /api/v1/dashboard/user/profile/update/` (multipart, fields
  /// `profile` + `user_id`).
  Future<void> updateProfileImage({
    required List<int> bytes,
    required String filename,
    required String userId,
  }) async {
    final formData = FormData.fromMap({
      'profile': imagePart(bytes, filename),
      'user_id': userId,
    });
    final response = await _tooLargeAsMessage(
      'Profile photo',
      () => _dio.post<dynamic>(ApiPaths.updateProfileImage, data: formData),
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/profile/badges/{muid}` — no trailing slash.
  Future<Map<String, dynamic>> fetchBadges(String muid) async {
    final response = await _dio.get<dynamic>(ApiPaths.badges(muid));
    return ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/dashboard/achievement/list/user/{muid}/` — bare array
  /// `response`.
  Future<List<dynamic>> fetchUserAchievements(String muid) async {
    final response = await _dio.get<dynamic>(ApiPaths.userAchievements(muid));
    return ApiEnvelope.unwrapList(response);
  }

  /// `GET` connected QSeverse DIDs for [muid], under `response.dids`.
  Future<List<dynamic>> fetchEligibleAchievements() async =>
      ApiEnvelope.unwrapList(
        await _dio.get<dynamic>(ApiPaths.achievementEligible),
      );

  Future<List<dynamic>> fetchAchievementProgress() async =>
      ApiEnvelope.unwrapList(
        await _dio.get<dynamic>(ApiPaths.achievementProgress),
      );

  Future<List<dynamic>> fetchAchievementCatalog() async =>
      ApiEnvelope.unwrapList(
        await _dio.get<dynamic>(ApiPaths.achievementCatalog),
      );

  /// The claim's `response` plus the backend's own message under `message`.
  Future<Map<String, dynamic>> claimAchievement(String id) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.achievementClaim(id),
      data: <String, dynamic>{},
    );
    final body = ApiEnvelope.unwrapObject(response);
    final general =
        ((response.data as Map<String, dynamic>?)?['message']
            as Map<String, dynamic>?)?['general'];
    final message = general is List && general.isNotEmpty
        ? '${general.first}'
        : 'Achievement claimed';
    return {...body, 'message': message};
  }

  Future<List<dynamic>> fetchConnectedDids(String muid) async {
    final response = await _dio.get<dynamic>(
      ApiPaths.qseverseConnectedUsers(muid),
    );
    final payload = ApiEnvelope.unwrapObject(response);
    return payload['dids'] as List<dynamic>;
  }

  /// `POST` the external QSeverse issuance call — bare array `response`.
  Future<List<dynamic>> issueVc(Map<String, dynamic> body) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.qseverseIssueVc,
      data: body,
    );
    return ApiEnvelope.unwrapList(response);
  }

  /// `POST /api/v1/dashboard/achievement/issue-vc/`
  /// `{"achievement_id", "vc_url"}`.
  Future<void> saveIssuedVcUrl({
    required String achievementId,
    required String vcUrl,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.saveIssuedVcUrl,
      data: {'achievement_id': achievementId, 'vc_url': vcUrl},
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `PATCH /api/v1/dashboard/college/change-college/`
  /// `{"org_id", "department_id"}`.
  Future<void> changeCollege({
    required String orgId,
    required String departmentId,
  }) async {
    final response = await _dio.patch<dynamic>(
      ApiPaths.changeCollege,
      data: {'org_id': orgId, 'department_id': departmentId},
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// A photo as a multipart part with an image content type. The backend
  /// rejects anything whose content type isn't `image/*` ("Expected an
  /// image"), and `MultipartFile.fromBytes` defaults to
  /// `application/octet-stream`. The in-app cropper outputs JPEG; a PNG is
  /// recognised by its signature.
  static MultipartFile imagePart(List<int> bytes, String filename) {
    final isPng =
        bytes.length > 4 &&
        bytes[0] == 0x89 &&
        bytes[1] == 0x50 &&
        bytes[2] == 0x4E &&
        bytes[3] == 0x47;
    return MultipartFile.fromBytes(
      bytes,
      filename: filename,
      contentType: isPng
          ? DioMediaType('image', 'png')
          : DioMediaType('image', 'jpeg'),
    );
  }

  /// A 413 comes from the reverse proxy (its body is HTML, not the API's
  /// envelope), so it would otherwise surface as a generic failure.
  static Future<Response<dynamic>> _tooLargeAsMessage(
    String what,
    Future<Response<dynamic>> Function() send,
  ) async {
    try {
      return await send();
    } on DioException catch (e) {
      if (e.response?.statusCode == 413) {
        throw ApiException(
          message: '$what is too large for the server. Use one under 5 MB.',
          statusCode: 413,
        );
      }
      rethrow;
    }
  }
}
