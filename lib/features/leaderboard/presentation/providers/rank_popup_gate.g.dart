// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_popup_gate.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rankPopupGate)
const rankPopupGateProvider = RankPopupGateProvider._();

final class RankPopupGateProvider
    extends $FunctionalProvider<RankPopupGate, RankPopupGate, RankPopupGate>
    with $Provider<RankPopupGate> {
  const RankPopupGateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankPopupGateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankPopupGateHash();

  @$internal
  @override
  $ProviderElement<RankPopupGate> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RankPopupGate create(Ref ref) {
    return rankPopupGate(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RankPopupGate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RankPopupGate>(value),
    );
  }
}

String _$rankPopupGateHash() => r'46d12fc7f82d6feb4d254779342a81965f71c897';
