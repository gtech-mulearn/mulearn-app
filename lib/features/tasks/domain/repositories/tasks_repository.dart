import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';

/// Tasks repository contract (rules.md §2/§5). Throws [ApiException] on
/// failure.
abstract interface class TasksRepository {
  /// `GET /api/v1/dashboard/task/list/` — the real, dedicated task catalog,
  /// flattened across its three categories (`start_journey`/`become_expert`/
  /// `events`) into one list, each item tagged with its [TaskCategory].
  Future<List<TaskCatalogItem>> getTasks();
}
