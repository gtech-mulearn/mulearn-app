// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App router (go_router) with an auth `redirect` that reads the core-level
/// [AppAuthController] (rules.md §1/§3, architecture §5).
///
/// NOTE (rules.md §2 / §10): the router is the app's composition root — it must
/// import feature screens, which `core/` is forbidden to do. It therefore lives
/// under `lib/app/` rather than `core/router/` (a deliberate, flagged deviation
/// from the build prompt's suggested location, to preserve the hard "core never
/// imports features" boundary). Route path *constants* remain in
/// `core/router/route_paths.dart`.
///
/// Guards:
///  * session still resolving → `/splash`
///  * signed out → `/sign-in`, `/forgot-password`, `/register`,
///    `/register/role`, or `/register/details` (registration itself
///    transitions from signed-out to signed-in mid-flow, so it's allowed in
///    both states — see `_alwaysAllowedSignedIn` below)
///  * signed in on any other pre-auth screen (or `/splash`) → `/profile`

@ProviderFor(goRouter)
const goRouterProvider = GoRouterProvider._();

/// App router (go_router) with an auth `redirect` that reads the core-level
/// [AppAuthController] (rules.md §1/§3, architecture §5).
///
/// NOTE (rules.md §2 / §10): the router is the app's composition root — it must
/// import feature screens, which `core/` is forbidden to do. It therefore lives
/// under `lib/app/` rather than `core/router/` (a deliberate, flagged deviation
/// from the build prompt's suggested location, to preserve the hard "core never
/// imports features" boundary). Route path *constants* remain in
/// `core/router/route_paths.dart`.
///
/// Guards:
///  * session still resolving → `/splash`
///  * signed out → `/sign-in`, `/forgot-password`, `/register`,
///    `/register/role`, or `/register/details` (registration itself
///    transitions from signed-out to signed-in mid-flow, so it's allowed in
///    both states — see `_alwaysAllowedSignedIn` below)
///  * signed in on any other pre-auth screen (or `/splash`) → `/profile`

final class GoRouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// App router (go_router) with an auth `redirect` that reads the core-level
  /// [AppAuthController] (rules.md §1/§3, architecture §5).
  ///
  /// NOTE (rules.md §2 / §10): the router is the app's composition root — it must
  /// import feature screens, which `core/` is forbidden to do. It therefore lives
  /// under `lib/app/` rather than `core/router/` (a deliberate, flagged deviation
  /// from the build prompt's suggested location, to preserve the hard "core never
  /// imports features" boundary). Route path *constants* remain in
  /// `core/router/route_paths.dart`.
  ///
  /// Guards:
  ///  * session still resolving → `/splash`
  ///  * signed out → `/sign-in`, `/forgot-password`, `/register`,
  ///    `/register/role`, or `/register/details` (registration itself
  ///    transitions from signed-out to signed-in mid-flow, so it's allowed in
  ///    both states — see `_alwaysAllowedSignedIn` below)
  ///  * signed in on any other pre-auth screen (or `/splash`) → `/profile`
  const GoRouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'goRouterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$goRouterHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return goRouter(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$goRouterHash() => r'a6bb559a378311d7f2b7e60e2353ac47ac081215';
