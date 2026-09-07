import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:mulearn_app/core/network/api_envelope.dart';
import 'package:mulearn_app/core/network/api_paths.dart';

/// Raw Dio calls for the tasks feature. Hits the real, dedicated task
/// catalog endpoint (`ApiPaths.taskList`) — DTO parsing happens in the
/// repository.
///
/// Requests carry [_cacheOptions] (see `CacheConfig.tasks`) to force
/// client-side caching regardless of the backend's missing `Cache-Control`
/// header — see that doc comment for why.
class TasksRemoteDataSource {
  const TasksRemoteDataSource(this._dio, this._cacheOptions);

  final Dio _dio;
  final CacheOptions _cacheOptions;

  /// `GET /api/v1/dashboard/task/list/` — an object keyed by category
  /// (`start_journey`/`become_expert`/`events`), each a bare array of task
  /// objects.
  Future<Map<String, dynamic>> fetchTaskList() async {
    final response = await _dio.get<dynamic>(
      ApiPaths.taskList,
      options: _cacheOptions.toOptions(),
    );
    return ApiEnvelope.unwrapObject(response);
  }
}
