import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';
import 'package:mulearn_app/core/notifications/push/push_preferences.dart';

/// The backend's push endpoints (`/api/v1/push/`).
class PushRemoteDataSource {
  const PushRemoteDataSource(this._dio);

  final Dio _dio;

  /// Registers (or refreshes) this device's FCM token for the signed-in
  /// user. Cheap on the server: one upsert, `last_seen_at` at most hourly.
  Future<void> registerDevice({
    required String token,
    required String platform,
    required String appVersion,
    String? timezone,
  }) async {
    final response = await _dio.post<dynamic>(
      PushPaths.devices,
      data: {
        'token': token,
        'platform': platform,
        'app_version': appVersion,
        'timezone': ?timezone,
      },
    );
    ApiEnvelope.unwrapMessage(response);
  }

  /// Stops pushes to this token for the signed-in user (sign-out).
  Future<void> unregisterDevice(String token) async {
    final response = await _dio.delete<dynamic>(
      PushPaths.devices,
      data: {'token': token},
    );
    ApiEnvelope.unwrapMessage(response);
  }

  /// Tells the server a push was opened (feeds its "don't nag" rule).
  Future<void> reportOpened(String dedupeKey) async {
    final response = await _dio.post<dynamic>(
      PushPaths.opened,
      data: {'dedupe_key': dedupeKey},
    );
    ApiEnvelope.unwrapMessage(response);
  }

  Future<PushPreferences> fetchPreferences() async {
    final response = await _dio.get<dynamic>(PushPaths.preferences);
    return PushPreferences.fromJson(ApiEnvelope.unwrapObject(response));
  }

  /// Saves only the given fields; returns the stored settings.
  Future<PushPreferences> updatePreferences(Map<String, Object?> patch) async {
    final response = await _dio.patch<dynamic>(
      PushPaths.preferences,
      data: patch,
    );
    return PushPreferences.fromJson(ApiEnvelope.unwrapObject(response));
  }
}
