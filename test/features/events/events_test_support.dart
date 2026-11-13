import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';

import '../../support/fake_http_adapter.dart';
import '../../support/fake_secure_storage.dart';

Future<ProviderContainer> eventsContainer(FakeHttpAdapter adapter) async {
  final tokens = TokenStorage(FakeSecureStorage());
  await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');
  final c = ProviderContainer(retry: (_, __) => null, overrides: [
    dioProvider.overrideWithValue(fakeDio(adapter)),
    tokenStorageProvider.overrideWithValue(tokens),
  ]);
  addTearDown(c.dispose);
  return c;
}

Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 8; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}
