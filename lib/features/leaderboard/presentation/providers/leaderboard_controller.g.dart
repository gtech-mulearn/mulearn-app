// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(leaderboardRemoteDataSource)
const leaderboardRemoteDataSourceProvider =
    LeaderboardRemoteDataSourceProvider._();

final class LeaderboardRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          LeaderboardRemoteDataSource,
          LeaderboardRemoteDataSource,
          LeaderboardRemoteDataSource
        >
    with $Provider<LeaderboardRemoteDataSource> {
  const LeaderboardRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaderboardRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaderboardRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<LeaderboardRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LeaderboardRemoteDataSource create(Ref ref) {
    return leaderboardRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeaderboardRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeaderboardRemoteDataSource>(value),
    );
  }
}

String _$leaderboardRemoteDataSourceHash() =>
    r'd754d3702629b7e3bfe491b24c21174dccc156ee';

/// Presentation depends on the [LeaderboardRepository] contract (rules.md
/// §2/§5).

@ProviderFor(leaderboardRepository)
const leaderboardRepositoryProvider = LeaderboardRepositoryProvider._();

/// Presentation depends on the [LeaderboardRepository] contract (rules.md
/// §2/§5).

final class LeaderboardRepositoryProvider
    extends
        $FunctionalProvider<
          LeaderboardRepository,
          LeaderboardRepository,
          LeaderboardRepository
        >
    with $Provider<LeaderboardRepository> {
  /// Presentation depends on the [LeaderboardRepository] contract (rules.md
  /// §2/§5).
  const LeaderboardRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'leaderboardRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$leaderboardRepositoryHash();

  @$internal
  @override
  $ProviderElement<LeaderboardRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LeaderboardRepository create(Ref ref) {
    return leaderboardRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LeaderboardRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LeaderboardRepository>(value),
    );
  }
}

String _$leaderboardRepositoryHash() =>
    r'42a645283e1892408b8a1d014c9a9d1d645a0c6f';

@ProviderFor(studentLeaderboard)
const studentLeaderboardProvider = StudentLeaderboardFamily._();

final class StudentLeaderboardProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<StudentLeaderboardEntry>>,
          List<StudentLeaderboardEntry>,
          FutureOr<List<StudentLeaderboardEntry>>
        >
    with
        $FutureModifier<List<StudentLeaderboardEntry>>,
        $FutureProvider<List<StudentLeaderboardEntry>> {
  const StudentLeaderboardProvider._({
    required StudentLeaderboardFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'studentLeaderboardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$studentLeaderboardHash();

  @override
  String toString() {
    return r'studentLeaderboardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<StudentLeaderboardEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<StudentLeaderboardEntry>> create(Ref ref) {
    final argument = this.argument as bool;
    return studentLeaderboard(ref, monthly: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentLeaderboardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$studentLeaderboardHash() =>
    r'5760d3eada2cfb0e83a1290425fba6a5f10c7006';

final class StudentLeaderboardFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<StudentLeaderboardEntry>>,
          bool
        > {
  const StudentLeaderboardFamily._()
    : super(
        retry: null,
        name: r'studentLeaderboardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  StudentLeaderboardProvider call({required bool monthly}) =>
      StudentLeaderboardProvider._(argument: monthly, from: this);

  @override
  String toString() => r'studentLeaderboardProvider';
}

@ProviderFor(collegeLeaderboard)
const collegeLeaderboardProvider = CollegeLeaderboardFamily._();

final class CollegeLeaderboardProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CollegeLeaderboardEntry>>,
          List<CollegeLeaderboardEntry>,
          FutureOr<List<CollegeLeaderboardEntry>>
        >
    with
        $FutureModifier<List<CollegeLeaderboardEntry>>,
        $FutureProvider<List<CollegeLeaderboardEntry>> {
  const CollegeLeaderboardProvider._({
    required CollegeLeaderboardFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'collegeLeaderboardProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$collegeLeaderboardHash();

  @override
  String toString() {
    return r'collegeLeaderboardProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CollegeLeaderboardEntry>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CollegeLeaderboardEntry>> create(Ref ref) {
    final argument = this.argument as bool;
    return collegeLeaderboard(ref, monthly: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CollegeLeaderboardProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collegeLeaderboardHash() =>
    r'f831cdbfd5ad7426de890f775b2e6d9e65d9c4b3';

final class CollegeLeaderboardFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CollegeLeaderboardEntry>>,
          bool
        > {
  const CollegeLeaderboardFamily._()
    : super(
        retry: null,
        name: r'collegeLeaderboardProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CollegeLeaderboardProvider call({required bool monthly}) =>
      CollegeLeaderboardProvider._(argument: monthly, from: this);

  @override
  String toString() => r'collegeLeaderboardProvider';
}
