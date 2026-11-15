// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_results.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app-wide [RecentResults].

@ProviderFor(recentResults)
const recentResultsProvider = RecentResultsProvider._();

/// The app-wide [RecentResults].

final class RecentResultsProvider
    extends $FunctionalProvider<RecentResults, RecentResults, RecentResults>
    with $Provider<RecentResults> {
  /// The app-wide [RecentResults].
  const RecentResultsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentResultsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentResultsHash();

  @$internal
  @override
  $ProviderElement<RecentResults> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecentResults create(Ref ref) {
    return recentResults(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecentResults value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecentResults>(value),
    );
  }
}

String _$recentResultsHash() => r'51e2840e7431f324bcba1b739a4bf77eaa4f4c9f';
