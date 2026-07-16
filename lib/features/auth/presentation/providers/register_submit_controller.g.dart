// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_submit_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Performs the actual registration submission — the same multi-call
/// sequence as the reference `register-client.tsx`'s `handleGenericSignup`/
/// `handleCompanySignup`: create the account, then (for student/mentor/
/// enabler) link an organization, or (for company) create the company record.
///
/// Exposes `AsyncValue<void>` for automatic loading/error state (rules.md §4).

@ProviderFor(RegisterSubmitController)
const registerSubmitControllerProvider = RegisterSubmitControllerProvider._();

/// Performs the actual registration submission — the same multi-call
/// sequence as the reference `register-client.tsx`'s `handleGenericSignup`/
/// `handleCompanySignup`: create the account, then (for student/mentor/
/// enabler) link an organization, or (for company) create the company record.
///
/// Exposes `AsyncValue<void>` for automatic loading/error state (rules.md §4).
final class RegisterSubmitControllerProvider
    extends $AsyncNotifierProvider<RegisterSubmitController, void> {
  /// Performs the actual registration submission — the same multi-call
  /// sequence as the reference `register-client.tsx`'s `handleGenericSignup`/
  /// `handleCompanySignup`: create the account, then (for student/mentor/
  /// enabler) link an organization, or (for company) create the company record.
  ///
  /// Exposes `AsyncValue<void>` for automatic loading/error state (rules.md §4).
  const RegisterSubmitControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'registerSubmitControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$registerSubmitControllerHash();

  @$internal
  @override
  RegisterSubmitController create() => RegisterSubmitController();
}

String _$registerSubmitControllerHash() =>
    r'2bb11afb9ae1504b4481fcf3f95bb80441fd6696';

/// Performs the actual registration submission — the same multi-call
/// sequence as the reference `register-client.tsx`'s `handleGenericSignup`/
/// `handleCompanySignup`: create the account, then (for student/mentor/
/// enabler) link an organization, or (for company) create the company record.
///
/// Exposes `AsyncValue<void>` for automatic loading/error state (rules.md §4).

abstract class _$RegisterSubmitController extends $AsyncNotifier<void> {
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
