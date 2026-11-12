// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_payload.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's own `GET /dashboard/profile/user-profile/` object,
/// fetched once and shared: Profile, Home's progress summary, interest-group
/// membership and the user's college each map it with their own DTO.
///
/// Mutations that change the user's profile invalidate this provider, which
/// refreshes every reader at once. It watches the auth state, so signing out
/// discards it. Rejected when signed out (no reader runs then).
///
/// Not auto-retried (Riverpod 3 retries failing providers by default, which
/// would keep every reader loading): a failure surfaces at once so screens
/// show their error state and Retry, which invalidates this provider.

@ProviderFor(myProfilePayload)
const myProfilePayloadProvider = MyProfilePayloadProvider._();

/// The signed-in user's own `GET /dashboard/profile/user-profile/` object,
/// fetched once and shared: Profile, Home's progress summary, interest-group
/// membership and the user's college each map it with their own DTO.
///
/// Mutations that change the user's profile invalidate this provider, which
/// refreshes every reader at once. It watches the auth state, so signing out
/// discards it. Rejected when signed out (no reader runs then).
///
/// Not auto-retried (Riverpod 3 retries failing providers by default, which
/// would keep every reader loading): a failure surfaces at once so screens
/// show their error state and Retry, which invalidates this provider.

final class MyProfilePayloadProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<String, dynamic>>,
          Map<String, dynamic>,
          FutureOr<Map<String, dynamic>>
        >
    with
        $FutureModifier<Map<String, dynamic>>,
        $FutureProvider<Map<String, dynamic>> {
  /// The signed-in user's own `GET /dashboard/profile/user-profile/` object,
  /// fetched once and shared: Profile, Home's progress summary, interest-group
  /// membership and the user's college each map it with their own DTO.
  ///
  /// Mutations that change the user's profile invalidate this provider, which
  /// refreshes every reader at once. It watches the auth state, so signing out
  /// discards it. Rejected when signed out (no reader runs then).
  ///
  /// Not auto-retried (Riverpod 3 retries failing providers by default, which
  /// would keep every reader loading): a failure surfaces at once so screens
  /// show their error state and Retry, which invalidates this provider.
  const MyProfilePayloadProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'myProfilePayloadProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProfilePayloadHash();

  @$internal
  @override
  $FutureProviderElement<Map<String, dynamic>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<String, dynamic>> create(Ref ref) {
    return myProfilePayload(ref);
  }
}

String _$myProfilePayloadHash() => r'a9ee3c871b7f3e1ca6f275fe9d79e1375ae272df';
