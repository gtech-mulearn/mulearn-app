// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authRemoteDataSource)
const authRemoteDataSourceProvider = AuthRemoteDataSourceProvider._();

final class AuthRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          AuthRemoteDataSource,
          AuthRemoteDataSource,
          AuthRemoteDataSource
        >
    with $Provider<AuthRemoteDataSource> {
  const AuthRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<AuthRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthRemoteDataSource create(Ref ref) {
    return authRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRemoteDataSource>(value),
    );
  }
}

String _$authRemoteDataSourceHash() =>
    r'342226fe7f872bc7314ad608d768239951db2132';

/// Presentation depends on the [AuthRepository] contract, wired to the concrete
/// impl here via DI (rules.md §2/§5) so tests can override it.

@ProviderFor(authRepository)
const authRepositoryProvider = AuthRepositoryProvider._();

/// Presentation depends on the [AuthRepository] contract, wired to the concrete
/// impl here via DI (rules.md §2/§5) so tests can override it.

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  /// Presentation depends on the [AuthRepository] contract, wired to the concrete
  /// impl here via DI (rules.md §2/§5) so tests can override it.
  const AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'b692f41f48a45408bfa74b9900c3932eda1b3e2a';

@ProviderFor(googleNativeSignInDataSource)
const googleNativeSignInDataSourceProvider =
    GoogleNativeSignInDataSourceProvider._();

final class GoogleNativeSignInDataSourceProvider
    extends
        $FunctionalProvider<
          GoogleNativeSignInDataSource,
          GoogleNativeSignInDataSource,
          GoogleNativeSignInDataSource
        >
    with $Provider<GoogleNativeSignInDataSource> {
  const GoogleNativeSignInDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleNativeSignInDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleNativeSignInDataSourceHash();

  @$internal
  @override
  $ProviderElement<GoogleNativeSignInDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleNativeSignInDataSource create(Ref ref) {
    return googleNativeSignInDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleNativeSignInDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleNativeSignInDataSource>(value),
    );
  }
}

String _$googleNativeSignInDataSourceHash() =>
    r'8c451a213a48ea7823b90e2537452e68de69008a';

@ProviderFor(appleNativeSignInDataSource)
const appleNativeSignInDataSourceProvider =
    AppleNativeSignInDataSourceProvider._();

final class AppleNativeSignInDataSourceProvider
    extends
        $FunctionalProvider<
          AppleNativeSignInDataSource,
          AppleNativeSignInDataSource,
          AppleNativeSignInDataSource
        >
    with $Provider<AppleNativeSignInDataSource> {
  const AppleNativeSignInDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appleNativeSignInDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appleNativeSignInDataSourceHash();

  @$internal
  @override
  $ProviderElement<AppleNativeSignInDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppleNativeSignInDataSource create(Ref ref) {
    return appleNativeSignInDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppleNativeSignInDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppleNativeSignInDataSource>(value),
    );
  }
}

String _$appleNativeSignInDataSourceHash() =>
    r'c34dbec30a90b18f16da5654260664f67637d25f';

/// Drives the sign-in / sign-out actions. Exposes `AsyncValue<void>` so
/// screens get automatic loading/error states via [AsyncValue.guard]
/// (rules.md §4). Every action also rethrows its error after recording it, so
/// callers that need a success/failure signal for control flow (e.g. the OTP
/// screen only advancing to the verify step on success) can `try`/`catch`
/// without duplicating error handling — the error is still available via
/// `ref.listen(authControllerProvider, ...)` for a shared snackbar.
///
/// The coarse routing signal lives in the core [AppAuthController].

@ProviderFor(AuthController)
const authControllerProvider = AuthControllerProvider._();

/// Drives the sign-in / sign-out actions. Exposes `AsyncValue<void>` so
/// screens get automatic loading/error states via [AsyncValue.guard]
/// (rules.md §4). Every action also rethrows its error after recording it, so
/// callers that need a success/failure signal for control flow (e.g. the OTP
/// screen only advancing to the verify step on success) can `try`/`catch`
/// without duplicating error handling — the error is still available via
/// `ref.listen(authControllerProvider, ...)` for a shared snackbar.
///
/// The coarse routing signal lives in the core [AppAuthController].
final class AuthControllerProvider
    extends $AsyncNotifierProvider<AuthController, void> {
  /// Drives the sign-in / sign-out actions. Exposes `AsyncValue<void>` so
  /// screens get automatic loading/error states via [AsyncValue.guard]
  /// (rules.md §4). Every action also rethrows its error after recording it, so
  /// callers that need a success/failure signal for control flow (e.g. the OTP
  /// screen only advancing to the verify step on success) can `try`/`catch`
  /// without duplicating error handling — the error is still available via
  /// `ref.listen(authControllerProvider, ...)` for a shared snackbar.
  ///
  /// The coarse routing signal lives in the core [AppAuthController].
  const AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();
}

String _$authControllerHash() => r'736b9afab056a95f464770e577111dc4dca4883d';

/// Drives the sign-in / sign-out actions. Exposes `AsyncValue<void>` so
/// screens get automatic loading/error states via [AsyncValue.guard]
/// (rules.md §4). Every action also rethrows its error after recording it, so
/// callers that need a success/failure signal for control flow (e.g. the OTP
/// screen only advancing to the verify step on success) can `try`/`catch`
/// without duplicating error handling — the error is still available via
/// `ref.listen(authControllerProvider, ...)` for a shared snackbar.
///
/// The coarse routing signal lives in the core [AppAuthController].

abstract class _$AuthController extends $AsyncNotifier<void> {
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
