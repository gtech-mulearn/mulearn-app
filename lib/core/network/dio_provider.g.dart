// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Bare Dio used only for the token-refresh call and for retrying a request
/// after refresh — deliberately WITHOUT the auth interceptor, so refreshing
/// can't recurse (architecture §6b).

@ProviderFor(refreshDio)
const refreshDioProvider = RefreshDioProvider._();

/// Bare Dio used only for the token-refresh call and for retrying a request
/// after refresh — deliberately WITHOUT the auth interceptor, so refreshing
/// can't recurse (architecture §6b).

final class RefreshDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Bare Dio used only for the token-refresh call and for retrying a request
  /// after refresh — deliberately WITHOUT the auth interceptor, so refreshing
  /// can't recurse (architecture §6b).
  const RefreshDioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'refreshDioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$refreshDioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return refreshDio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$refreshDioHash() => r'c79cc2e3b15c2c16b24a16632f3e92e5349af292';

/// The app's main Dio client.
///
/// Interceptor order matters (rules.md §3): cache is added **before** auth, so a
/// cache hit short-circuits before any token attach/refresh runs.

@ProviderFor(dio)
const dioProvider = DioProvider._();

/// The app's main Dio client.
///
/// Interceptor order matters (rules.md §3): cache is added **before** auth, so a
/// cache hit short-circuits before any token attach/refresh runs.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The app's main Dio client.
  ///
  /// Interceptor order matters (rules.md §3): cache is added **before** auth, so a
  /// cache hit short-circuits before any token attach/refresh runs.
  const DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'681b8c3b6652ac2a54b483facaa0755602be1d7f';
