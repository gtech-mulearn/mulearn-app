import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/features/tasks/data/datasources/tasks_remote_datasource.dart';
import 'package:mulearn_app/features/tasks/data/repositories/tasks_repository_impl.dart';
import 'package:mulearn_app/features/tasks/domain/entities/task_catalog_item.dart';
import 'package:mulearn_app/features/tasks/domain/repositories/tasks_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_controller.g.dart';

@riverpod
TasksRemoteDataSource tasksRemoteDataSource(Ref ref) =>
    TasksRemoteDataSource(ref.watch(dioProvider));

@riverpod
TasksRepository tasksRepository(Ref ref) =>
    TasksRepositoryImpl(ref.watch(tasksRemoteDataSourceProvider));

/// Flat, filterable catalog of every task across every level (rules.md §4).
@riverpod
Future<List<TaskCatalogItem>> tasksController(Ref ref) =>
    ref.watch(tasksRepositoryProvider).getTasks();
