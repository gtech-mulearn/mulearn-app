// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(projectsRepository)
final projectsRepositoryProvider = ProjectsRepositoryProvider._();

final class ProjectsRepositoryProvider
    extends
        $FunctionalProvider<
          ProjectsRepository,
          ProjectsRepository,
          ProjectsRepository
        >
    with $Provider<ProjectsRepository> {
  ProjectsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProjectsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProjectsRepository create(Ref ref) {
    return projectsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProjectsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProjectsRepository>(value),
    );
  }
}

String _$projectsRepositoryHash() =>
    r'7ae2b4f9995cab3ecdc8f6fb8ebbed067f57cab7';

/// The signed-in member's id (votes and comments carry it) and muid.

@ProviderFor(projectsViewer)
final projectsViewerProvider = ProjectsViewerProvider._();

/// The signed-in member's id (votes and comments carry it) and muid.

final class ProjectsViewerProvider
    extends
        $FunctionalProvider<
          AsyncValue<({String id, String muid})>,
          ({String id, String muid}),
          FutureOr<({String id, String muid})>
        >
    with
        $FutureModifier<({String id, String muid})>,
        $FutureProvider<({String id, String muid})> {
  /// The signed-in member's id (votes and comments carry it) and muid.
  ProjectsViewerProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'projectsViewerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectsViewerHash();

  @$internal
  @override
  $FutureProviderElement<({String id, String muid})> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<({String id, String muid})> create(Ref ref) {
    return projectsViewer(ref);
  }
}

String _$projectsViewerHash() => r'4a4cc85eb413c42dd4460e1bb0a4b2af981a1e7d';

/// Published projects for a search (all when empty), a page at a time.
/// Each search is kept for a while once seen.

@ProviderFor(ProjectsFeed)
final projectsFeedProvider = ProjectsFeedFamily._();

/// Published projects for a search (all when empty), a page at a time.
/// Each search is kept for a while once seen.
final class ProjectsFeedProvider
    extends $AsyncNotifierProvider<ProjectsFeed, PagedState<Project>> {
  /// Published projects for a search (all when empty), a page at a time.
  /// Each search is kept for a while once seen.
  ProjectsFeedProvider._({
    required ProjectsFeedFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'projectsFeedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$projectsFeedHash();

  @override
  String toString() {
    return r'projectsFeedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProjectsFeed create() => ProjectsFeed();

  @override
  bool operator ==(Object other) {
    return other is ProjectsFeedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectsFeedHash() => r'5513fc7e8ffad1e8acf39fe1ecb830780afea7da';

/// Published projects for a search (all when empty), a page at a time.
/// Each search is kept for a while once seen.

final class ProjectsFeedFamily extends $Family
    with
        $ClassFamilyOverride<
          ProjectsFeed,
          AsyncValue<PagedState<Project>>,
          PagedState<Project>,
          FutureOr<PagedState<Project>>,
          String
        > {
  ProjectsFeedFamily._()
    : super(
        retry: noRetry,
        name: r'projectsFeedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Published projects for a search (all when empty), a page at a time.
  /// Each search is kept for a while once seen.

  ProjectsFeedProvider call(String search) =>
      ProjectsFeedProvider._(argument: search, from: this);

  @override
  String toString() => r'projectsFeedProvider';
}

/// Published projects for a search (all when empty), a page at a time.
/// Each search is kept for a while once seen.

abstract class _$ProjectsFeed extends $AsyncNotifier<PagedState<Project>> {
  late final _$args = ref.$arg as String;
  String get search => _$args;

  FutureOr<PagedState<Project>> build(String search);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PagedState<Project>>, PagedState<Project>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PagedState<Project>>, PagedState<Project>>,
              AsyncValue<PagedState<Project>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

/// What the viewer made or is on, drafts included, newest first.

@ProviderFor(myProjects)
final myProjectsProvider = MyProjectsProvider._();

/// What the viewer made or is on, drafts included, newest first.

final class MyProjectsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Project>>,
          List<Project>,
          FutureOr<List<Project>>
        >
    with $FutureModifier<List<Project>>, $FutureProvider<List<Project>> {
  /// What the viewer made or is on, drafts included, newest first.
  MyProjectsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'myProjectsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProjectsHash();

  @$internal
  @override
  $FutureProviderElement<List<Project>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Project>> create(Ref ref) {
    return myProjects(ref);
  }
}

String _$myProjectsHash() => r'b3c89ce8f26114f013675c2710670b0cd134655a';

/// One project.

@ProviderFor(project)
final projectProvider = ProjectFamily._();

/// One project.

final class ProjectProvider
    extends $FunctionalProvider<AsyncValue<Project>, Project, FutureOr<Project>>
    with $FutureModifier<Project>, $FutureProvider<Project> {
  /// One project.
  ProjectProvider._({
    required ProjectFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'projectProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$projectHash();

  @override
  String toString() {
    return r'projectProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Project> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Project> create(Ref ref) {
    final argument = this.argument as String;
    return project(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectHash() => r'3f88303e5c61cabb4c899ade2f10b0505994b3d7';

/// One project.

final class ProjectFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Project>, String> {
  ProjectFamily._()
    : super(
        retry: noRetry,
        name: r'projectProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// One project.

  ProjectProvider call(String id) =>
      ProjectProvider._(argument: id, from: this);

  @override
  String toString() => r'projectProvider';
}

/// μLearn members matching [query], for the team picker; nothing under two
/// characters. Each query is kept a while, so retyping costs no request and
/// a slower, older answer can't replace a newer one.

@ProviderFor(projectPeopleSearch)
final projectPeopleSearchProvider = ProjectPeopleSearchFamily._();

/// μLearn members matching [query], for the team picker; nothing under two
/// characters. Each query is kept a while, so retyping costs no request and
/// a slower, older answer can't replace a newer one.

final class ProjectPeopleSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProjectMember>>,
          List<ProjectMember>,
          FutureOr<List<ProjectMember>>
        >
    with
        $FutureModifier<List<ProjectMember>>,
        $FutureProvider<List<ProjectMember>> {
  /// μLearn members matching [query], for the team picker; nothing under two
  /// characters. Each query is kept a while, so retyping costs no request and
  /// a slower, older answer can't replace a newer one.
  ProjectPeopleSearchProvider._({
    required ProjectPeopleSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'projectPeopleSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$projectPeopleSearchHash();

  @override
  String toString() {
    return r'projectPeopleSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ProjectMember>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProjectMember>> create(Ref ref) {
    final argument = this.argument as String;
    return projectPeopleSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ProjectPeopleSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$projectPeopleSearchHash() =>
    r'91fb241ace102191c12820801e230e7074b1008b';

/// μLearn members matching [query], for the team picker; nothing under two
/// characters. Each query is kept a while, so retyping costs no request and
/// a slower, older answer can't replace a newer one.

final class ProjectPeopleSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ProjectMember>>, String> {
  ProjectPeopleSearchFamily._()
    : super(
        retry: noRetry,
        name: r'projectPeopleSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// μLearn members matching [query], for the team picker; nothing under two
  /// characters. Each query is kept a while, so retyping costs no request and
  /// a slower, older answer can't replace a newer one.

  ProjectPeopleSearchProvider call(String query) =>
      ProjectPeopleSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'projectPeopleSearchProvider';
}

/// Skills to tag a project with.

@ProviderFor(projectSkills)
final projectSkillsProvider = ProjectSkillsProvider._();

/// Skills to tag a project with.

final class ProjectSkillsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ProjectSkill>>,
          List<ProjectSkill>,
          FutureOr<List<ProjectSkill>>
        >
    with
        $FutureModifier<List<ProjectSkill>>,
        $FutureProvider<List<ProjectSkill>> {
  /// Skills to tag a project with.
  ProjectSkillsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'projectSkillsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectSkillsHash();

  @$internal
  @override
  $FutureProviderElement<List<ProjectSkill>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ProjectSkill>> create(Ref ref) {
    return projectSkills(ref);
  }
}

String _$projectSkillsHash() => r'3bee99ba56302748dc2bad1abd5747926efe7ace';

/// Every change to a project: one notifier for one busy / error state. Each
/// success refreshes the project, the viewer's list and the feed. Returns
/// true on success (the error is in [state]).

@ProviderFor(ProjectActions)
final projectActionsProvider = ProjectActionsProvider._();

/// Every change to a project: one notifier for one busy / error state. Each
/// success refreshes the project, the viewer's list and the feed. Returns
/// true on success (the error is in [state]).
final class ProjectActionsProvider
    extends $AsyncNotifierProvider<ProjectActions, void> {
  /// Every change to a project: one notifier for one busy / error state. Each
  /// success refreshes the project, the viewer's list and the feed. Returns
  /// true on success (the error is in [state]).
  ProjectActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'projectActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$projectActionsHash();

  @$internal
  @override
  ProjectActions create() => ProjectActions();
}

String _$projectActionsHash() => r'3024ec5ed2b94c0d37c9e9c6be22a78144b865f9';

/// Every change to a project: one notifier for one busy / error state. Each
/// success refreshes the project, the viewer's list and the feed. Returns
/// true on success (the error is in [state]).

abstract class _$ProjectActions extends $AsyncNotifier<void> {
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
