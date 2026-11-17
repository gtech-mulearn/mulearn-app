// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teamRemoteDataSource)
final teamRemoteDataSourceProvider = TeamRemoteDataSourceProvider._();

final class TeamRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          TeamRemoteDataSource,
          TeamRemoteDataSource,
          TeamRemoteDataSource
        >
    with $Provider<TeamRemoteDataSource> {
  TeamRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<TeamRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TeamRemoteDataSource create(Ref ref) {
    return teamRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamRemoteDataSource>(value),
    );
  }
}

String _$teamRemoteDataSourceHash() =>
    r'202ca571fa781fff0ec97d63b3e2ff15f241fb42';

/// Presentation depends on the [TeamRepository] contract (rules.md §2/§5).

@ProviderFor(teamRepository)
final teamRepositoryProvider = TeamRepositoryProvider._();

/// Presentation depends on the [TeamRepository] contract (rules.md §2/§5).

final class TeamRepositoryProvider
    extends $FunctionalProvider<TeamRepository, TeamRepository, TeamRepository>
    with $Provider<TeamRepository> {
  /// Presentation depends on the [TeamRepository] contract (rules.md §2/§5).
  TeamRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'teamRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$teamRepositoryHash();

  @$internal
  @override
  $ProviderElement<TeamRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeamRepository create(Ref ref) {
    return teamRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeamRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeamRepository>(value),
    );
  }
}

String _$teamRepositoryHash() => r'aec33a7da30decfc939da1e3c1e0d23aabfedd56';
