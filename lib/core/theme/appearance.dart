import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appearance.g.dart';

/// System, Light or Dark (artifact Screen patterns → Settings →
/// Appearance). Follows the phone until the person picks otherwise; the
/// choice is remembered on this device.
@Riverpod(keepAlive: true)
class Appearance extends _$Appearance {
  static const _key = 'appearance';

  @override
  ThemeMode build() {
    unawaited(_load());
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final stored = await ref.read(secureStorageProvider).read(key: _key);
    final mode = ThemeMode.values.where((m) => m.name == stored).firstOrNull;
    if (mode != null && ref.mounted) state = mode;
  }

  Future<void> set(ThemeMode mode) async {
    state = mode;
    await ref.read(secureStorageProvider).write(key: _key, value: mode.name);
  }
}
