// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_users.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The people this user blocked on this device. Starts empty and fills from
/// storage a moment after launch; screens watch it and hide their content.

@ProviderFor(BlockedUsers)
final blockedUsersProvider = BlockedUsersProvider._();

/// The people this user blocked on this device. Starts empty and fills from
/// storage a moment after launch; screens watch it and hide their content.
final class BlockedUsersProvider
    extends $NotifierProvider<BlockedUsers, List<BlockedUser>> {
  /// The people this user blocked on this device. Starts empty and fills from
  /// storage a moment after launch; screens watch it and hide their content.
  BlockedUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedUsersProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedUsersHash();

  @$internal
  @override
  BlockedUsers create() => BlockedUsers();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<BlockedUser> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<BlockedUser>>(value),
    );
  }
}

String _$blockedUsersHash() => r'ebf7b99ac1572e64b31dba3b5450928206a05017';

/// The people this user blocked on this device. Starts empty and fills from
/// storage a moment after launch; screens watch it and hide their content.

abstract class _$BlockedUsers extends $Notifier<List<BlockedUser>> {
  List<BlockedUser> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<BlockedUser>, List<BlockedUser>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<BlockedUser>, List<BlockedUser>>,
              List<BlockedUser>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
