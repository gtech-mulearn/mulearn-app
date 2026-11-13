// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Submits a password change; the screen reads the state for its spinner
/// and errors.

@ProviderFor(ChangePasswordController)
const changePasswordControllerProvider = ChangePasswordControllerProvider._();

/// Submits a password change; the screen reads the state for its spinner
/// and errors.
final class ChangePasswordControllerProvider
    extends $AsyncNotifierProvider<ChangePasswordController, void> {
  /// Submits a password change; the screen reads the state for its spinner
  /// and errors.
  const ChangePasswordControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'changePasswordControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$changePasswordControllerHash();

  @$internal
  @override
  ChangePasswordController create() => ChangePasswordController();
}

String _$changePasswordControllerHash() =>
    r'aedc118993270e7912a853776f14d7097b6d3662';

/// Submits a password change; the screen reads the state for its spinner
/// and errors.

abstract class _$ChangePasswordController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
