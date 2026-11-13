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
