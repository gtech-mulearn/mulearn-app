// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(mentorRemoteDataSource)
const mentorRemoteDataSourceProvider = MentorRemoteDataSourceProvider._();

final class MentorRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          MentorRemoteDataSource,
          MentorRemoteDataSource,
          MentorRemoteDataSource
        >
    with $Provider<MentorRemoteDataSource> {
  const MentorRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<MentorRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  MentorRemoteDataSource create(Ref ref) {
    return mentorRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MentorRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MentorRemoteDataSource>(value),
    );
  }
}

String _$mentorRemoteDataSourceHash() =>
    r'abe2d3fb8dc010f9a241abd9d3545784cca4858e';

/// Presentation depends on the [MentorRepository] contract (rules.md §2/§5).

@ProviderFor(mentorRepository)
const mentorRepositoryProvider = MentorRepositoryProvider._();

/// Presentation depends on the [MentorRepository] contract (rules.md §2/§5).

final class MentorRepositoryProvider
    extends
        $FunctionalProvider<
          MentorRepository,
          MentorRepository,
          MentorRepository
        >
    with $Provider<MentorRepository> {
  /// Presentation depends on the [MentorRepository] contract (rules.md §2/§5).
  const MentorRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mentorRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorRepositoryHash();

  @$internal
  @override
  $ProviderElement<MentorRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MentorRepository create(Ref ref) {
    return mentorRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MentorRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MentorRepository>(value),
    );
  }
}

String _$mentorRepositoryHash() => r'0423c18371293a7ff21444aefbc8c1fe7827b7c2';
