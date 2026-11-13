// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(campusRemoteDataSource)
const campusRemoteDataSourceProvider = CampusRemoteDataSourceProvider._();

final class CampusRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          CampusRemoteDataSource,
          CampusRemoteDataSource,
          CampusRemoteDataSource
        >
    with $Provider<CampusRemoteDataSource> {
  const CampusRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campusRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<CampusRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CampusRemoteDataSource create(Ref ref) {
    return campusRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampusRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampusRemoteDataSource>(value),
    );
  }
}

String _$campusRemoteDataSourceHash() =>
    r'1e5a1acf13441b69bcdd819031325131fb2642ba';

/// Presentation depends on the [CampusRepository] contract (rules.md §2/§5).

@ProviderFor(campusRepository)
const campusRepositoryProvider = CampusRepositoryProvider._();

/// Presentation depends on the [CampusRepository] contract (rules.md §2/§5).

final class CampusRepositoryProvider
    extends
        $FunctionalProvider<
          CampusRepository,
          CampusRepository,
          CampusRepository
        >
    with $Provider<CampusRepository> {
  /// Presentation depends on the [CampusRepository] contract (rules.md §2/§5).
  const CampusRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campusRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusRepositoryHash();

  @$internal
  @override
  $ProviderElement<CampusRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CampusRepository create(Ref ref) {
    return campusRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampusRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampusRepository>(value),
    );
  }
}

String _$campusRepositoryHash() => r'e1ffd96df0824c0930b6961d54d31d5b488a3c3c';
