import 'package:dio/dio.dart';
import 'package:mulearn_app/core/network/api_exception.dart';
import 'package:mulearn_app/features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'package:mulearn_app/features/tasks/data/dtos/task_list_item_dto.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/domain/repositories/tasks_repository.dart';

/// The response's three top-level keys, confirmed live, mapped onto
/// [TaskCategory].
const _categoryKeys = {
  'start_journey': TaskCategory.startJourney,
  'become_expert': TaskCategory.becomeExpert,
  'events': TaskCategory.events,
};

class TasksRepositoryImpl implements TasksRepository {
  const TasksRepositoryImpl(this._remote);

  final TasksRemoteDataSource _remote;

  @override
  Future<List<TaskCatalogItem>> getTasks() => _guard(() async {
        final json = await _remote.fetchTaskList();
        final result = <TaskCatalogItem>[];
        for (final entry in _categoryKeys.entries) {
          final items = json[entry.key];
          if (items is! List) continue;
          for (final item in items.cast<Map<String, dynamic>>()) {
            result.add(TaskListItemDto.fromJson(item).toDomain(entry.value));
          }
        }
        return result;
      });

  Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
