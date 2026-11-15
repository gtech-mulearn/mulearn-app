// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tasksRemoteDataSource)
const tasksRemoteDataSourceProvider = TasksRemoteDataSourceProvider._();

final class TasksRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          TasksRemoteDataSource,
          TasksRemoteDataSource,
          TasksRemoteDataSource
        >
    with $Provider<TasksRemoteDataSource> {
  const TasksRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<TasksRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TasksRemoteDataSource create(Ref ref) {
    return tasksRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TasksRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TasksRemoteDataSource>(value),
    );
  }
}

String _$tasksRemoteDataSourceHash() =>
    r'dcd67a5bfe07896be9b04ae88d60ecb5e27854d8';

@ProviderFor(tasksRepository)
const tasksRepositoryProvider = TasksRepositoryProvider._();

final class TasksRepositoryProvider
    extends
        $FunctionalProvider<TasksRepository, TasksRepository, TasksRepository>
    with $Provider<TasksRepository> {
  const TasksRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksRepositoryHash();

  @$internal
  @override
  $ProviderElement<TasksRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TasksRepository create(Ref ref) {
    return tasksRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TasksRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TasksRepository>(value),
    );
  }
}

String _$tasksRepositoryHash() => r'89827fb8aac3c7cbed3fb8acfb022138b45e97c4';

/// Flat, filterable catalog of every task across every level (rules.md §4).

@ProviderFor(tasksController)
const tasksControllerProvider = TasksControllerProvider._();

/// Flat, filterable catalog of every task across every level (rules.md §4).

final class TasksControllerProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TaskCatalogItem>>,
          List<TaskCatalogItem>,
          FutureOr<List<TaskCatalogItem>>
        >
    with
        $FutureModifier<List<TaskCatalogItem>>,
        $FutureProvider<List<TaskCatalogItem>> {
  /// Flat, filterable catalog of every task across every level (rules.md §4).
  const TasksControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tasksControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tasksControllerHash();

  @$internal
  @override
  $FutureProviderElement<List<TaskCatalogItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TaskCatalogItem>> create(Ref ref) {
    return tasksController(ref);
  }
}

String _$tasksControllerHash() => r'5f2318301cc0b2adad25f679603444ec00158d01';

/// The signed-in user's level name (`"lvl4"`) for the Tasks title and the
/// "you're here" marker; null when the profile has none.

@ProviderFor(myTaskLevel)
const myTaskLevelProvider = MyTaskLevelProvider._();

/// The signed-in user's level name (`"lvl4"`) for the Tasks title and the
/// "you're here" marker; null when the profile has none.

final class MyTaskLevelProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// The signed-in user's level name (`"lvl4"`) for the Tasks title and the
  /// "you're here" marker; null when the profile has none.
  const MyTaskLevelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myTaskLevelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myTaskLevelHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return myTaskLevel(ref);
  }
}

String _$myTaskLevelHash() => r'8697d96649842eec4a9fbc36b1f454fa53874dcb';
