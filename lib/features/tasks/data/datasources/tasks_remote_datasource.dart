import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the tasks feature. Hits the real, dedicated task
/// catalog endpoint (`ApiPaths.taskList`) — DTO parsing happens in the
/// repository.
class TasksRemoteDataSource {
  const TasksRemoteDataSource(this._dio);

  final Dio _dio;

  /// `GET /api/v1/dashboard/task/list/` — an object keyed by category
  /// (`start_journey`/`become_expert`/`events`), each a bare array of task
  /// objects.
  Future<Map<String, dynamic>> fetchTaskList() async {
    final response = await _dio.get<dynamic>(ApiPaths.taskList);
    return ApiEnvelope.unwrapObject(response);
  }

  /// The signed-in user's level name from `GET
  /// /api/v1/dashboard/profile/user-profile/` (`"lvl4"`), for "Tasks for
  /// Level 4". Null when the profile has none.
  Future<String?> fetchMyLevel() async {
    final response = await _dio.get<dynamic>(ApiPaths.userProfile);
    final level = ApiEnvelope.unwrapObject(response)['level'];
    return level is String && level.isNotEmpty ? level : null;
  }
}
