// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vc_issuance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Issues a Verifiable Credential via QSeverse, then persists the resulting
/// URL against the achievement — the two-step flow the reference dashboard's
/// `issueVC` + `updateVCURL` calls form together.

@ProviderFor(VcIssuanceController)
const vcIssuanceControllerProvider = VcIssuanceControllerProvider._();

/// Issues a Verifiable Credential via QSeverse, then persists the resulting
/// URL against the achievement — the two-step flow the reference dashboard's
/// `issueVC` + `updateVCURL` calls form together.
final class VcIssuanceControllerProvider
    extends $AsyncNotifierProvider<VcIssuanceController, List<IssuedVc>?> {
  /// Issues a Verifiable Credential via QSeverse, then persists the resulting
  /// URL against the achievement — the two-step flow the reference dashboard's
  /// `issueVC` + `updateVCURL` calls form together.
  const VcIssuanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vcIssuanceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vcIssuanceControllerHash();

  @$internal
  @override
  VcIssuanceController create() => VcIssuanceController();
}

String _$vcIssuanceControllerHash() =>
    r'd3d82067b1f4f96aaad4d4a3e9a5b568371e2bff';

/// Issues a Verifiable Credential via QSeverse, then persists the resulting
/// URL against the achievement — the two-step flow the reference dashboard's
/// `issueVC` + `updateVCURL` calls form together.

abstract class _$VcIssuanceController extends $AsyncNotifier<List<IssuedVc>?> {
  FutureOr<List<IssuedVc>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<IssuedVc>?>, List<IssuedVc>?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<IssuedVc>?>, List<IssuedVc>?>,
              AsyncValue<List<IssuedVc>?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
