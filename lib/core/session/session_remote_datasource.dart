import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw calls behind the session: who am I, my mentor applications, and the
/// server-side logout.
class SessionRemoteDataSource {
  const SessionRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/user/info/`.
  Future<Map<String, dynamic>> fetchUserInfo() async =>
      ApiEnvelope.unwrapObject(await _dio.get<dynamic>(ApiPaths.userInfo));

  /// `GET /api/v1/dashboard/mentor/status/`. The backend answers 400 "No
  /// mentor requests found for your account." when there are none; that is
  /// an empty list, not an error.
  Future<List<dynamic>> fetchMentorApplications() async {
    try {
      return ApiEnvelope.unwrapList(await _dio.get<dynamic>(ApiPaths.mentorStatus));
    } on DioException catch (e) {
      final noApplications = e.response?.statusCode == 400 &&
          _generalMessages(e.response?.data).any((m) => m.startsWith('No mentor requests found'));
      if (noApplications) return const [];
      rethrow;
    }
  }

  /// `POST /api/v1/auth/logout/` — revokes the refresh token server-side.
  /// Short timeouts: sign-out must not hang on a slow network.
  Future<void> logout(String refreshToken) async {
    final response = await _dio.post<dynamic>(
      ApiPaths.logout,
      data: {'refreshToken': refreshToken},
      options: Options(
        headers: {RequestFlags.skipAuth: true},
        sendTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );
    ApiEnvelope.unwrapObject(response);
  }

  /// `GET /api/v1/register/connect-discord/?code=` — returns the backend's
  /// message ("You will be added to the discord server soon").
  Future<String> connectDiscord(String code) async {
    final response = await _dio.get<dynamic>(ApiPaths.connectDiscord, queryParameters: {'code': code});
    ApiEnvelope.unwrapObject(response);
    final messages = _generalMessages(response.data);
    return messages.isEmpty ? 'Discord connected' : messages.first;
  }

  static List<String> _generalMessages(Object? body) {
    if (body is! Map<String, dynamic>) return const [];
    final message = body['message'];
    final general = message is Map<String, dynamic> ? message['general'] : null;
    return general is List ? general.map((m) => '$m').toList() : const [];
  }
}
