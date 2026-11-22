// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opportunities_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(opportunitiesRemoteDataSource)
final opportunitiesRemoteDataSourceProvider =
    OpportunitiesRemoteDataSourceProvider._();

final class OpportunitiesRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          OpportunitiesRemoteDataSource,
          OpportunitiesRemoteDataSource,
          OpportunitiesRemoteDataSource
        >
    with $Provider<OpportunitiesRemoteDataSource> {
  OpportunitiesRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'opportunitiesRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$opportunitiesRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<OpportunitiesRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpportunitiesRemoteDataSource create(Ref ref) {
    return opportunitiesRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpportunitiesRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpportunitiesRemoteDataSource>(
        value,
      ),
    );
  }
}

String _$opportunitiesRemoteDataSourceHash() =>
    r'4064a23e807a4ae6a8cbe3ab0907436004d016ce';

/// Presentation depends on the [OpportunitiesRepository] contract.

@ProviderFor(opportunitiesRepository)
final opportunitiesRepositoryProvider = OpportunitiesRepositoryProvider._();

/// Presentation depends on the [OpportunitiesRepository] contract.

final class OpportunitiesRepositoryProvider
    extends
        $FunctionalProvider<
          OpportunitiesRepository,
          OpportunitiesRepository,
          OpportunitiesRepository
        >
    with $Provider<OpportunitiesRepository> {
  /// Presentation depends on the [OpportunitiesRepository] contract.
  OpportunitiesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'opportunitiesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$opportunitiesRepositoryHash();

  @$internal
  @override
  $ProviderElement<OpportunitiesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpportunitiesRepository create(Ref ref) {
    return opportunitiesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpportunitiesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpportunitiesRepository>(value),
    );
  }
}

String _$opportunitiesRepositoryHash() =>
    r'ab8d1e9dbb061cc3e8d6eb8b9be95a27928f10a8';

/// Jobs matching [search], page by page. A failed page keeps the jobs
/// already shown and records the error for an inline retry.

@ProviderFor(JobsController)
final jobsControllerProvider = JobsControllerFamily._();

/// Jobs matching [search], page by page. A failed page keeps the jobs
/// already shown and records the error for an inline retry.
final class JobsControllerProvider
    extends $AsyncNotifierProvider<JobsController, PagedState<Job>> {
  /// Jobs matching [search], page by page. A failed page keeps the jobs
  /// already shown and records the error for an inline retry.
  JobsControllerProvider._({
    required JobsControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'jobsControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$jobsControllerHash();

  @override
  String toString() {
    return r'jobsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  JobsController create() => JobsController();

  @override
  bool operator ==(Object other) {
    return other is JobsControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jobsControllerHash() => r'6c78b7601ead9da71028a9693d8956aba5416d12';

/// Jobs matching [search], page by page. A failed page keeps the jobs
/// already shown and records the error for an inline retry.

final class JobsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          JobsController,
          AsyncValue<PagedState<Job>>,
          PagedState<Job>,
          FutureOr<PagedState<Job>>,
          String
        > {
  JobsControllerFamily._()
    : super(
        retry: null,
        name: r'jobsControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Jobs matching [search], page by page. A failed page keeps the jobs
  /// already shown and records the error for an inline retry.

  JobsControllerProvider call(String search) =>
      JobsControllerProvider._(argument: search, from: this);

  @override
  String toString() => r'jobsControllerProvider';
}

/// Jobs matching [search], page by page. A failed page keeps the jobs
/// already shown and records the error for an inline retry.

abstract class _$JobsController extends $AsyncNotifier<PagedState<Job>> {
  late final _$args = ref.$arg as String;
  String get search => _$args;

  FutureOr<PagedState<Job>> build(String search);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<PagedState<Job>>, PagedState<Job>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedState<Job>>, PagedState<Job>>,
              AsyncValue<PagedState<Job>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// The learner's applications, newest first (the first page; learners
/// rarely have more than a handful).

@ProviderFor(myJobApplications)
final myJobApplicationsProvider = MyJobApplicationsProvider._();

/// The learner's applications, newest first (the first page; learners
/// rarely have more than a handful).

final class MyJobApplicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<JobApplication>>,
          List<JobApplication>,
          FutureOr<List<JobApplication>>
        >
    with
        $FutureModifier<List<JobApplication>>,
        $FutureProvider<List<JobApplication>> {
  /// The learner's applications, newest first (the first page; learners
  /// rarely have more than a handful).
  MyJobApplicationsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myJobApplicationsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myJobApplicationsHash();

  @$internal
  @override
  $FutureProviderElement<List<JobApplication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<JobApplication>> create(Ref ref) {
    return myJobApplications(ref);
  }
}

String _$myJobApplicationsHash() => r'a063a3fbc400acf243030fb0f9ca98d8305bef02';

/// Apply, resubmit and withdraw: one notifier so screens show one busy /
/// error state. Each success refreshes the jobs and applications.

@ProviderFor(ApplicationActionsController)
final applicationActionsControllerProvider =
    ApplicationActionsControllerProvider._();

/// Apply, resubmit and withdraw: one notifier so screens show one busy /
/// error state. Each success refreshes the jobs and applications.
final class ApplicationActionsControllerProvider
    extends $AsyncNotifierProvider<ApplicationActionsController, void> {
  /// Apply, resubmit and withdraw: one notifier so screens show one busy /
  /// error state. Each success refreshes the jobs and applications.
  ApplicationActionsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'applicationActionsControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$applicationActionsControllerHash();

  @$internal
  @override
  ApplicationActionsController create() => ApplicationActionsController();
}

String _$applicationActionsControllerHash() =>
    r'0fd2a66a2d147dfa80f28e2b0b068468c5c66a0d';

/// Apply, resubmit and withdraw: one notifier so screens show one busy /
/// error state. Each success refreshes the jobs and applications.

abstract class _$ApplicationActionsController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
