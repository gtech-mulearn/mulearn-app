// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_claims.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's `muid`, read directly off the stored JWT access
/// token's payload claim (confirmed live: `{"id", "muid", "roles", "expiry",
/// "tokenType"}`) rather than a network call — this app never verifies the
/// signature client-side, it only reads a claim already trusted because the
/// token came from secure storage after a successful sign-in.
///
/// Lives in `core/` (rules.md §2) because "which user am I" is needed by
/// multiple features (e.g. `learning_circles` determining lead/ownership)
/// without any of them importing `features/auth` or `features/profile`.

@ProviderFor(currentUserMuid)
const currentUserMuidProvider = CurrentUserMuidProvider._();

/// The signed-in user's `muid`, read directly off the stored JWT access
/// token's payload claim (confirmed live: `{"id", "muid", "roles", "expiry",
/// "tokenType"}`) rather than a network call — this app never verifies the
/// signature client-side, it only reads a claim already trusted because the
/// token came from secure storage after a successful sign-in.
///
/// Lives in `core/` (rules.md §2) because "which user am I" is needed by
/// multiple features (e.g. `learning_circles` determining lead/ownership)
/// without any of them importing `features/auth` or `features/profile`.

final class CurrentUserMuidProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// The signed-in user's `muid`, read directly off the stored JWT access
  /// token's payload claim (confirmed live: `{"id", "muid", "roles", "expiry",
  /// "tokenType"}`) rather than a network call — this app never verifies the
  /// signature client-side, it only reads a claim already trusted because the
  /// token came from secure storage after a successful sign-in.
  ///
  /// Lives in `core/` (rules.md §2) because "which user am I" is needed by
  /// multiple features (e.g. `learning_circles` determining lead/ownership)
  /// without any of them importing `features/auth` or `features/profile`.
  const CurrentUserMuidProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserMuidProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserMuidHash();

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    return currentUserMuid(ref);
  }
}

String _$currentUserMuidHash() => r'66026cfd56538dc9caa55c55989643a4e2d5c5cd';
