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
final refreshDioProvider = RefreshDioProvider._();

/// Bare Dio used only for the token-refresh call and for retrying a request
/// after refresh — deliberately WITHOUT the auth interceptor, so refreshing
/// can't recurse (architecture §6b).

final class RefreshDioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// Bare Dio used only for the token-refresh call and for retrying a request
  /// after refresh — deliberately WITHOUT the auth interceptor, so refreshing
  /// can't recurse (architecture §6b).
  RefreshDioProvider._()
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

/// The user the HTTP cache is keyed for ([CacheScope]); one per app.

@ProviderFor(cacheScope)
final cacheScopeProvider = CacheScopeProvider._();

/// The user the HTTP cache is keyed for ([CacheScope]); one per app.

final class CacheScopeProvider
    extends $FunctionalProvider<CacheScope, CacheScope, CacheScope>
    with $Provider<CacheScope> {
  /// The user the HTTP cache is keyed for ([CacheScope]); one per app.
  CacheScopeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheScopeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheScopeHash();

  @$internal
  @override
  $ProviderElement<CacheScope> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CacheScope create(Ref ref) {
    return cacheScope(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheScope value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheScope>(value),
    );
  }
}

String _$cacheScopeHash() => r'e95030923de1b7ed1abb56bfd0be6b65b8e34132';

/// The app's main Dio client.
///
/// Interceptor order matters (rules.md §3): the cache scope tags the request
/// with the user, then the cache, then auth — a cache hit short-circuits
/// before any token attach/refresh runs, and entries never cross users.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// The app's main Dio client.
///
/// Interceptor order matters (rules.md §3): the cache scope tags the request
/// with the user, then the cache, then auth — a cache hit short-circuits
/// before any token attach/refresh runs, and entries never cross users.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The app's main Dio client.
  ///
  /// Interceptor order matters (rules.md §3): the cache scope tags the request
  /// with the user, then the cache, then auth — a cache hit short-circuits
  /// before any token attach/refresh runs, and entries never cross users.
  DioProvider._()
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

String _$dioHash() => r'd1a255c19e8d787fd3873d9c63c76dbc08323155';
