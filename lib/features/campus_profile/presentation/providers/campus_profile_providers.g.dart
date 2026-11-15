// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_profile_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(campusProfileRepository)
const campusProfileRepositoryProvider = CampusProfileRepositoryProvider._();

final class CampusProfileRepositoryProvider
    extends
        $FunctionalProvider<
          CampusProfileRepository,
          CampusProfileRepository,
          CampusProfileRepository
        >
    with $Provider<CampusProfileRepository> {
  const CampusProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'campusProfileRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusProfileRepositoryHash();

  @$internal
  @override
  $ProviderElement<CampusProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CampusProfileRepository create(Ref ref) {
    return campusProfileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CampusProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CampusProfileRepository>(value),
    );
  }
}

String _$campusProfileRepositoryHash() =>
    r'41b4836af90840d306b848bf219862a5f01f1cd9';

/// A college's public page.

@ProviderFor(publicCampus)
const publicCampusProvider = PublicCampusFamily._();

/// A college's public page.

final class PublicCampusProvider
    extends
        $FunctionalProvider<
          AsyncValue<PublicCampus>,
          PublicCampus,
          FutureOr<PublicCampus>
        >
    with $FutureModifier<PublicCampus>, $FutureProvider<PublicCampus> {
  /// A college's public page.
  const PublicCampusProvider._({
    required PublicCampusFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'publicCampusProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicCampusHash();

  @override
  String toString() {
    return r'publicCampusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PublicCampus> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PublicCampus> create(Ref ref) {
    final argument = this.argument as String;
    return publicCampus(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicCampusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicCampusHash() => r'9b6c8b989d4486bcb5baf3cd5eb4f16b7191c41a';

/// A college's public page.

final class PublicCampusFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PublicCampus>, String> {
  const PublicCampusFamily._()
    : super(
        retry: noRetry,
        name: r'publicCampusProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// A college's public page.

  PublicCampusProvider call(String id) =>
      PublicCampusProvider._(argument: id, from: this);

  @override
  String toString() => r'publicCampusProvider';
}

/// Its last seven days of karma.

@ProviderFor(publicCampusWeeklyKarma)
const publicCampusWeeklyKarmaProvider = PublicCampusWeeklyKarmaFamily._();

/// Its last seven days of karma.

final class PublicCampusWeeklyKarmaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CampusKarmaDay>>,
          List<CampusKarmaDay>,
          FutureOr<List<CampusKarmaDay>>
        >
    with
        $FutureModifier<List<CampusKarmaDay>>,
        $FutureProvider<List<CampusKarmaDay>> {
  /// Its last seven days of karma.
  const PublicCampusWeeklyKarmaProvider._({
    required PublicCampusWeeklyKarmaFamily super.from,
    required String super.argument,
  }) : super(
         retry: noRetry,
         name: r'publicCampusWeeklyKarmaProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$publicCampusWeeklyKarmaHash();

  @override
  String toString() {
    return r'publicCampusWeeklyKarmaProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<CampusKarmaDay>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CampusKarmaDay>> create(Ref ref) {
    final argument = this.argument as String;
    return publicCampusWeeklyKarma(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PublicCampusWeeklyKarmaProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$publicCampusWeeklyKarmaHash() =>
    r'14f0ac7351353a2f3b1a55477ffac777c40d210f';

/// Its last seven days of karma.

final class PublicCampusWeeklyKarmaFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<CampusKarmaDay>>, String> {
  const PublicCampusWeeklyKarmaFamily._()
    : super(
        retry: noRetry,
        name: r'publicCampusWeeklyKarmaProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Its last seven days of karma.

  PublicCampusWeeklyKarmaProvider call(String id) =>
      PublicCampusWeeklyKarmaProvider._(argument: id, from: this);

  @override
  String toString() => r'publicCampusWeeklyKarmaProvider';
}
