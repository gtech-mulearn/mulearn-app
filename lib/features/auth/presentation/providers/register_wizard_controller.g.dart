// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_wizard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds steps 1–2's data (basic info + role) across the separate screens
/// that make up the registration flow.
///
/// `keepAlive: true` because — unlike a single-screen form — this state must
/// survive navigating from the basic-info screen to the role-selection screen
/// to the role-details screen, each a separate route. [reset] is called once
/// the flow completes (or is abandoned back at sign-in).

@ProviderFor(RegisterWizardController)
const registerWizardControllerProvider = RegisterWizardControllerProvider._();

/// Holds steps 1–2's data (basic info + role) across the separate screens
/// that make up the registration flow.
///
/// `keepAlive: true` because — unlike a single-screen form — this state must
/// survive navigating from the basic-info screen to the role-selection screen
/// to the role-details screen, each a separate route. [reset] is called once
/// the flow completes (or is abandoned back at sign-in).
final class RegisterWizardControllerProvider
    extends $NotifierProvider<RegisterWizardController, RegisterWizardState> {
  /// Holds steps 1–2's data (basic info + role) across the separate screens
  /// that make up the registration flow.
  ///
  /// `keepAlive: true` because — unlike a single-screen form — this state must
  /// survive navigating from the basic-info screen to the role-selection screen
  /// to the role-details screen, each a separate route. [reset] is called once
  /// the flow completes (or is abandoned back at sign-in).
  const RegisterWizardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerWizardControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerWizardControllerHash();

  @$internal
  @override
  RegisterWizardController create() => RegisterWizardController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegisterWizardState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegisterWizardState>(value),
    );
  }
}

String _$registerWizardControllerHash() =>
    r'4636b5af091828c381989cbb251271af8fc0238d';

/// Holds steps 1–2's data (basic info + role) across the separate screens
/// that make up the registration flow.
///
/// `keepAlive: true` because — unlike a single-screen form — this state must
/// survive navigating from the basic-info screen to the role-selection screen
/// to the role-details screen, each a separate route. [reset] is called once
/// the flow completes (or is abandoned back at sign-in).

abstract class _$RegisterWizardController
    extends $Notifier<RegisterWizardState> {
  RegisterWizardState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<RegisterWizardState, RegisterWizardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RegisterWizardState, RegisterWizardState>,
              RegisterWizardState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
