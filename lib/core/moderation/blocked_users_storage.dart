import 'dart:convert';

import 'package:hive_ce/hive.dart';
import 'package:mulearn_app/core/moderation/blocked_user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'blocked_users_storage.g.dart';

/// Where the blocked list lives between launches.
abstract interface class BlockedUsersStorage {
  /// The saved list; empty when nothing was saved or it can't be read.
  Future<List<BlockedUser>> read();

  /// Replaces the saved list.
  Future<void> write(List<BlockedUser> users);
}

/// A small Hive box in the app-support directory (not the cache directory,
/// which the system may clear).
final class HiveBlockedUsersStorage implements BlockedUsersStorage {
  /// Storage backed by a Hive box.
  HiveBlockedUsersStorage();

  static const _boxName = 'mulearn_blocked_users_v1';
  static const _key = 'list';

  Future<Box<String>> _box() async {
    final dir = await getApplicationSupportDirectory();
    return Hive.openBox<String>(_boxName, path: dir.path);
  }

  @override
  Future<List<BlockedUser>> read() async {
    try {
      final raw = (await _box()).get(_key);
      if (raw == null) return const [];
      final decoded = jsonDecode(raw) as List<dynamic>;
      return [
        for (final e in decoded)
          BlockedUser.fromJson(e as Map<String, dynamic>),
      ];
    } on Object {
      return const [];
    }
  }

  @override
  Future<void> write(List<BlockedUser> users) async {
    final box = await _box();
    await box.put(_key, jsonEncode([for (final u in users) u.toJson()]));
  }
}

/// The blocked-list storage; tests override it with an in-memory one.
@Riverpod(keepAlive: true)
BlockedUsersStorage blockedUsersStorage(Ref ref) => HiveBlockedUsersStorage();
