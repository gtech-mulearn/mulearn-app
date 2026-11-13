// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workspace_cards_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Upcoming sessions for the Home mentor card; watched only when the mentor
/// workspace is open, so other users make no call.

@ProviderFor(mentorUpcomingCount)
const mentorUpcomingCountProvider = MentorUpcomingCountProvider._();

/// Upcoming sessions for the Home mentor card; watched only when the mentor
/// workspace is open, so other users make no call.

final class MentorUpcomingCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Upcoming sessions for the Home mentor card; watched only when the mentor
  /// workspace is open, so other users make no call.
  const MentorUpcomingCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'mentorUpcomingCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mentorUpcomingCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return mentorUpcomingCount(ref);
  }
}

String _$mentorUpcomingCountHash() =>
    r'f424feca4d756eabe7714481cdd0311059a62390';

/// The Home campus card's line; watched only when the campus workspace is
/// open.

@ProviderFor(campusHeadline)
const campusHeadlineProvider = CampusHeadlineProvider._();

/// The Home campus card's line; watched only when the campus workspace is
/// open.

final class CampusHeadlineProvider
    extends
        $FunctionalProvider<
          AsyncValue<
            ({String code, String college, String? statLabel, num? statValue})
          >,
          ({String code, String college, String? statLabel, num? statValue}),
          FutureOr<
            ({String code, String college, String? statLabel, num? statValue})
          >
        >
    with
        $FutureModifier<
          ({String code, String college, String? statLabel, num? statValue})
        >,
        $FutureProvider<
          ({String code, String college, String? statLabel, num? statValue})
        > {
  /// The Home campus card's line; watched only when the campus workspace is
  /// open.
  const CampusHeadlineProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'campusHeadlineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$campusHeadlineHash();

  @$internal
  @override
  $FutureProviderElement<
    ({String code, String college, String? statLabel, num? statValue})
  >
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<({String code, String college, String? statLabel, num? statValue})>
  create(Ref ref) {
    return campusHeadline(ref);
  }
}

String _$campusHeadlineHash() => r'1ac2f3387ec729e23474bc90290a3ade1e273f31';
