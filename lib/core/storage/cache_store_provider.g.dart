// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cache_store_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Persistent HTTP-response cache store (Hive-backed) for
/// `dio_cache_interceptor` — rules.md §1, architecture §12.
///
/// The path is resolved once during bootstrap and passed in via an override,
/// so this provider itself stays free of `path_provider`/`WidgetsBinding`
/// plumbing and is trivial to override in tests with a [MemCacheStore].

@ProviderFor(cacheStore)
const cacheStoreProvider = CacheStoreProvider._();

/// Persistent HTTP-response cache store (Hive-backed) for
/// `dio_cache_interceptor` — rules.md §1, architecture §12.
///
/// The path is resolved once during bootstrap and passed in via an override,
/// so this provider itself stays free of `path_provider`/`WidgetsBinding`
/// plumbing and is trivial to override in tests with a [MemCacheStore].

final class CacheStoreProvider
    extends $FunctionalProvider<CacheStore, CacheStore, CacheStore>
    with $Provider<CacheStore> {
  /// Persistent HTTP-response cache store (Hive-backed) for
  /// `dio_cache_interceptor` — rules.md §1, architecture §12.
  ///
  /// The path is resolved once during bootstrap and passed in via an override,
  /// so this provider itself stays free of `path_provider`/`WidgetsBinding`
  /// plumbing and is trivial to override in tests with a [MemCacheStore].
  const CacheStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheStoreHash();

  @$internal
  @override
  $ProviderElement<CacheStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CacheStore create(Ref ref) {
    return cacheStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CacheStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CacheStore>(value),
    );
  }
}

String _$cacheStoreHash() => r'f8c211c2fcd308db99487478d1c7ac8b704b1e42';
