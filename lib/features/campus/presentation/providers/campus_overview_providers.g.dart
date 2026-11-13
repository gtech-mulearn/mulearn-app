// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campus_overview_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(campusSummary)
const campusSummaryProvider = CampusSummaryProvider._();

final class CampusSummaryProvider
    extends
        $FunctionalProvider<
          AsyncValue<CampusSummary>,
          CampusSummary,
          FutureOr<CampusSummary>
        >
    with $FutureModifier<CampusSummary>, $FutureProvider<CampusSummary> {
  const CampusSummaryProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'campusSummaryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusSummaryHash();

  @$internal
  @override
  $FutureProviderElement<CampusSummary> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CampusSummary> create(Ref ref) {
    return campusSummary(ref);
  }
}

String _$campusSummaryHash() => r'fc50a5be63f5c2a1ee25ced94d97b80d9bc0f898';

@ProviderFor(campusWeeklyKarma)
const campusWeeklyKarmaProvider = CampusWeeklyKarmaProvider._();

final class CampusWeeklyKarmaProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<KarmaDay>>,
          List<KarmaDay>,
          FutureOr<List<KarmaDay>>
        >
    with $FutureModifier<List<KarmaDay>>, $FutureProvider<List<KarmaDay>> {
  const CampusWeeklyKarmaProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'campusWeeklyKarmaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusWeeklyKarmaHash();

  @$internal
  @override
  $FutureProviderElement<List<KarmaDay>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<KarmaDay>> create(Ref ref) {
    return campusWeeklyKarma(ref);
  }
}

String _$campusWeeklyKarmaHash() => r'338247b6ddc28ced9894847e73d979c3897a1af0';

/// The five students with the most karma.

@ProviderFor(campusTopStudents)
const campusTopStudentsProvider = CampusTopStudentsProvider._();

/// The five students with the most karma.

final class CampusTopStudentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CampusStudent>>,
          List<CampusStudent>,
          FutureOr<List<CampusStudent>>
        >
    with
        $FutureModifier<List<CampusStudent>>,
        $FutureProvider<List<CampusStudent>> {
  /// The five students with the most karma.
  const CampusTopStudentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'campusTopStudentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusTopStudentsHash();

  @$internal
  @override
  $FutureProviderElement<List<CampusStudent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CampusStudent>> create(Ref ref) {
    return campusTopStudents(ref);
  }
}

String _$campusTopStudentsHash() => r'6e5c04a6d2d134d3772ebc92ab3eda13ebe795ef';
