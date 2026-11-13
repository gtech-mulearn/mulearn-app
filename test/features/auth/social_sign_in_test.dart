import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mulearn_app/core/storage/secure_storage_provider.dart';
import 'package:mulearn_app/features/auth/data/datasources/apple_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/google_native_signin_datasource.dart';
import 'package:mulearn_app/features/auth/data/datasources/register_remote_datasource.dart';
import 'package:mulearn_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mulearn_app/features/auth/domain/entities/social_sign_in_outcome.dart';
import 'package:mulearn_app/features/auth/presentation/providers/auth_controller.dart';

import '../../support/fake_http_adapter.dart';

class MockTokenStorage extends Mock implements TokenStorage {}

class FakeAppleSignIn implements AppleNativeSignInDataSource {
  @override
  Future<AppleSignInResult> signIn() async => (identityToken: 'apple-token', email: 'leak@example.com');
}

Map<String, dynamic> envelope(Map<String, dynamic> response, {int status = 200, List<String>? general}) => {
      'hasError': status >= 400,
      'statusCode': status,
      'message': {'general': general ?? <String>[]},
      'response': response,
    };

void main() {
  late MockTokenStorage tokens;

  setUp(() {
    tokens = MockTokenStorage();
    when(() => tokens.saveTokens(accessToken: any(named: 'accessToken'), refreshToken: any(named: 'refreshToken')))
        .thenAnswer((_) async {});
  });

  AuthRepositoryImpl repoServing(FakeHttpAdapter adapter) =>
      AuthRepositoryImpl(
        remote: AuthRemoteDataSource(fakeDio(adapter)),
        tokenStorage: tokens,
      );

  group('Google (authserver GoogleMobileAuthAPIView)', () {
    test('an unknown Google email asks to register and stores no tokens', () async {
      final repo = repoServing(FakeHttpAdapter({
        'POST /api/v1/auth/google-mobile/': (_) => FakeResponse(200, envelope({
              'isNewUser': true,
              'tempToken': 't',
              'email': 'e@x.org',
              'fullName': 'N',
            })),
      }));

      final outcome = await repo.signInWithGoogle(idToken: 'id');

      expect(outcome, isA<SocialNeedsRegistration>());
      final needs = outcome as SocialNeedsRegistration;
      expect((needs.tempToken, needs.email, needs.fullName), ('t', 'e@x.org', 'N'));
      verifyNever(() => tokens.saveTokens(accessToken: any(named: 'accessToken'), refreshToken: any(named: 'refreshToken')));
    });

    test('a known Google account signs in and stores the token pair', () async {
      final repo = repoServing(FakeHttpAdapter({
        'POST /api/v1/auth/google-mobile/': (_) => FakeResponse(200, envelope({
              'accessToken': 'a',
              'refreshToken': 'r',
              'isNewUser': false,
            })),
      }));

      final outcome = await repo.signInWithGoogle(idToken: 'id');

      expect(outcome, isA<SocialSignedIn>());
      verify(() => tokens.saveTokens(accessToken: 'a', refreshToken: 'r')).called(1);
    });

    test('the button is offered only where an ID token can be obtained', () {
      bool available(TargetPlatform p, String id) =>
          GoogleNativeSignInDataSource(platform: p, serverClientId: id).isAvailable;

      expect(available(TargetPlatform.android, ''), isFalse);
      expect(available(TargetPlatform.android, 'web-client-id'), isTrue);
      expect(available(TargetPlatform.iOS, ''), isTrue);
      expect(available(TargetPlatform.windows, 'web-client-id'), isFalse);
    });

    test('Google sign-up posts the tempToken with no email or password', () async {
      final adapter = FakeHttpAdapter({
        'POST /api/v1/register/': (_) => FakeResponse(200, envelope({'accessToken': 'a', 'refreshToken': 'r'})),
      });

      await RegisterRemoteDataSource(fakeDio(adapter))
          .registerWithGoogle(tempToken: 't', fullName: 'N', roleId: 'role-1');

      expect(adapter.requests.single.data, {
        'tempToken': 't',
        'user': {'full_name': 'N', 'role': 'role-1'},
      });
    });
  });

  group('Apple (authserver AppleMobileAuthAPIView)', () {
    test('only the identity token is sent - never a client-supplied email', () async {
      final adapter = FakeHttpAdapter({
        'POST /api/v1/auth/apple-mobile/': (_) => FakeResponse(200, envelope({'accessToken': 'a', 'refreshToken': 'r'})),
      });

      await AuthRemoteDataSource(fakeDio(adapter)).authenticateWithApple(identityToken: 'x');

      expect(adapter.requests.single.data, {'identity_token': 'x', 'identityToken': 'x'});
    });

    test('"No account found with this email" becomes AppleAccountNotFound', () async {
      final adapter = FakeHttpAdapter({
        'POST /api/v1/auth/apple-mobile/': (_) =>
            FakeResponse(400, envelope({}, status: 400, general: ['No account found with this email'])),
      });
      final container = ProviderContainer(overrides: [
        authRepositoryProvider.overrideWithValue(repoServing(adapter)),
        appleNativeSignInDataSourceProvider.overrideWithValue(FakeAppleSignIn()),
      ]);
      addTearDown(container.dispose);
      container.listen(authControllerProvider, (_, __) {});

      await expectLater(
        container.read(authControllerProvider.notifier).signInWithApple(),
        throwsA(isA<AppleAccountNotFound>()),
      );
      expect(adapter.requests.single.data, isNot(contains('email')));
    });
  });
}
