// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_users_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The blocked-list storage; tests override it with an in-memory one.

@ProviderFor(blockedUsersStorage)
final blockedUsersStorageProvider = BlockedUsersStorageProvider._();

/// The blocked-list storage; tests override it with an in-memory one.

final class BlockedUsersStorageProvider
    extends
        $FunctionalProvider<
          BlockedUsersStorage,
          BlockedUsersStorage,
          BlockedUsersStorage
        >
    with $Provider<BlockedUsersStorage> {
  /// The blocked-list storage; tests override it with an in-memory one.
  BlockedUsersStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedUsersStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedUsersStorageHash();

  @$internal
  @override
  $ProviderElement<BlockedUsersStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BlockedUsersStorage create(Ref ref) {
    return blockedUsersStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BlockedUsersStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BlockedUsersStorage>(value),
    );
  }
}

String _$blockedUsersStorageHash() =>
    r'e660022f0eed269c2ea3e0dab2769943dd3a004d';
