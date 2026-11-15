import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/core/theme/appearance.dart';

import '../../support/fake_secure_storage.dart';

void main() {
  test('follows the phone until a choice is made, then remembers it', () async {
    final storage = FakeSecureStorage();
    final first = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(first.dispose);

    expect(first.read(appearanceProvider), ThemeMode.system);
    await first.read(appearanceProvider.notifier).set(ThemeMode.dark);
    expect(first.read(appearanceProvider), ThemeMode.dark);

    // A fresh start reads the stored choice back.
    final second = ProviderContainer(
      overrides: [secureStorageProvider.overrideWithValue(storage)],
    );
    addTearDown(second.dispose);
    second.read(appearanceProvider);
    await Future<void>.delayed(Duration.zero);
    expect(second.read(appearanceProvider), ThemeMode.dark);
  });
}
