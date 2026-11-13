import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mulearn_app/app/app_scope.dart';
import 'package:mulearn_app/core/network/dio_provider.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/events/presentation/providers/events_controller.dart';

import '../support/fake_http_adapter.dart';
import '../support/fake_secure_storage.dart';

/// Plan 3 final review, Important 3: Riverpod 3 retries a failing provider
/// by default (~38 s of spinner and 10 extra timer-driven requests per
/// failure). The app's root scope — the one production runs — never does.
/// Other tests pass `retry: (_, __) => null` themselves, so only this test
/// sees the production policy.
void main() {
  testWidgets('the app scope never auto-retries a failed request', (tester) async {
    final adapter = FakeHttpAdapter({
      'GET /api/v1/dashboard/events/x/': (_) => const FakeResponse(500, {
            'hasError': true,
            'statusCode': 500,
            'message': {'general': ['Server error']},
            'response': <String, dynamic>{},
          }),
    });
    final tokens = TokenStorage(FakeSecureStorage());
    await tokens.saveTokens(accessToken: 'a', refreshToken: 'r');

    await tester.pumpWidget(appProviderScope(
      overrides: [
        dioProvider.overrideWithValue(fakeDio(adapter)),
        tokenStorageProvider.overrideWithValue(tokens),
      ],
      child: MaterialApp(
        home: Consumer(
          builder: (_, ref, __) => Text(ref.watch(eventDetailProvider('x')).hasError ? 'error' : 'loading'),
        ),
      ),
    ));
    // A minute of fake time: Riverpod's default policy retries 10 times
    // within it (200 ms doubling to 6.4 s).
    for (var i = 0; i < 60; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.text('error'), findsOneWidget);
    expect(adapter.requests.where((r) => r.uri.path == '/api/v1/dashboard/events/x/').length, 1);
  });
}
