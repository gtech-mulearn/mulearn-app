import 'dart:async';

import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:mulearn_app/core/moderation/blocked_users_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blocked_users.g.dart';

/// The people this user blocked on this device. Starts empty and fills from
/// storage a moment after launch; screens watch it and hide their content.
@Riverpod(keepAlive: true)
class BlockedUsers extends _$BlockedUsers {
  @override
  List<BlockedUser> build() {
    unawaited(_load());
    return const [];
  }

  Future<void> _load() async {
    final saved = await ref.read(blockedUsersStorageProvider).read();
    if (!ref.mounted || saved.isEmpty) return;
    var merged = [...saved];
    for (final u in state) {
      merged = _with(merged, u);
    }
    state = merged;
  }

  List<BlockedUser> _with(List<BlockedUser> list, BlockedUser user) {
    final i = list.indexWhere((b) => b.matches(id: user.id, muid: user.muid));
    if (i < 0) return [...list, user];
    return [...list]..[i] = list[i].merge(user);
  }

  /// Blocks [user]; blocking the same person twice keeps one entry.
  Future<void> block(BlockedUser user) async {
    state = _with(state, user);
    await ref.read(blockedUsersStorageProvider).write(state);
  }

  /// Unblocks the person matching [user].
  Future<void> unblock(BlockedUser user) async {
    state = [
      for (final b in state)
        if (!b.matches(id: user.id, muid: user.muid)) b,
    ];
    await ref.read(blockedUsersStorageProvider).write(state);
  }
}
