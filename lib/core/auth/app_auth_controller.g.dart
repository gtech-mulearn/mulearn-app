// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Coarse, app-wide authentication signal used by the router (rules.md §4:
/// auth state is genuinely cross-feature, so it lives in `core/`, which is what
/// lets `core/router/` guard routes without importing `features/`).
///
/// The value is simply "is there a usable session?". It bootstraps from secure
/// storage on startup, and listens to the [SessionEventBus] so an unrecoverable
/// token-refresh failure (emitted by the auth interceptor) flips the app to
/// signed-out — which the router `redirect` picks up automatically.
///
/// The auth *feature* controller drives the transitions via [setSignedIn] /
/// [setSignedOut] after performing the actual sign-in/out work.

@ProviderFor(AppAuthController)
const appAuthControllerProvider = AppAuthControllerProvider._();

/// Coarse, app-wide authentication signal used by the router (rules.md §4:
/// auth state is genuinely cross-feature, so it lives in `core/`, which is what
/// lets `core/router/` guard routes without importing `features/`).
///
/// The value is simply "is there a usable session?". It bootstraps from secure
/// storage on startup, and listens to the [SessionEventBus] so an unrecoverable
/// token-refresh failure (emitted by the auth interceptor) flips the app to
/// signed-out — which the router `redirect` picks up automatically.
///
/// The auth *feature* controller drives the transitions via [setSignedIn] /
/// [setSignedOut] after performing the actual sign-in/out work.
final class AppAuthControllerProvider
    extends $AsyncNotifierProvider<AppAuthController, bool> {
  /// Coarse, app-wide authentication signal used by the router (rules.md §4:
  /// auth state is genuinely cross-feature, so it lives in `core/`, which is what
  /// lets `core/router/` guard routes without importing `features/`).
  ///
  /// The value is simply "is there a usable session?". It bootstraps from secure
  /// storage on startup, and listens to the [SessionEventBus] so an unrecoverable
  /// token-refresh failure (emitted by the auth interceptor) flips the app to
  /// signed-out — which the router `redirect` picks up automatically.
  ///
  /// The auth *feature* controller drives the transitions via [setSignedIn] /
  /// [setSignedOut] after performing the actual sign-in/out work.
  const AppAuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appAuthControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appAuthControllerHash();

  @$internal
  @override
  AppAuthController create() => AppAuthController();
}

String _$appAuthControllerHash() => r'18ec71b2f6318b759b2794459d08d6b47e2c4b8b';

/// Coarse, app-wide authentication signal used by the router (rules.md §4:
/// auth state is genuinely cross-feature, so it lives in `core/`, which is what
/// lets `core/router/` guard routes without importing `features/`).
///
/// The value is simply "is there a usable session?". It bootstraps from secure
/// storage on startup, and listens to the [SessionEventBus] so an unrecoverable
/// token-refresh failure (emitted by the auth interceptor) flips the app to
/// signed-out — which the router `redirect` picks up automatically.
///
/// The auth *feature* controller drives the transitions via [setSignedIn] /
/// [setSignedOut] after performing the actual sign-in/out work.

abstract class _$AppAuthController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
